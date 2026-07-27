# Implementation of a single RandSoC design.
#
# Run from the design's build/working directory (where synthesis already wrote
# viv_synth.edf and design.xdc). The design's source directory -- which holds
# impl_constraints.tcl and clock_constraint.xdc -- and the target part are passed
# in through the DESIGN_DIR and PART environment variables (see the Makefile).
#
# This mirrors the original bfasst implementation flow (setup -> opt/place/route
# -> reports -> bitstream) so a rebuilt design matches the shipped dataset.

set design_dir $::env(DESIGN_DIR)
set part $::env(PART)

if { [catch {

    # --- Setup: load the synthesized netlist as a gate-level design ----------
    read_edif viv_synth.edf
    set_property top_file [pwd]/viv_synth.edf [current_fileset]
    link_design -part $part
    set_property design_mode GateLvl [current_fileset]

    # --- Constraints ---------------------------------------------------------
    read_xdc design.xdc
    read_xdc $design_dir/impl_constraints.tcl
    read_xdc $design_dir/clock_constraint.xdc

    # --- Place & route -------------------------------------------------------
    opt_design
    place_design
    route_design

    # --- Outputs -------------------------------------------------------------
    write_checkpoint -force -file impl.dcp
    write_edif       -force -file viv_impl.edf
    write_verilog    -force -file viv_impl.v

    # --- Reports (same set the shipped dataset was built with) ---------------
    report_utilization -file utilization.txt
    report_utilization -hierarchical -file utilization_hier.txt
    report_timing_summary -delay_type max -report_unconstrained \
        -check_timing_verbose -file timing_summary.txt
    report_design_analysis -congestion -file congestion.txt
    report_power -file power.txt

    # Max combinational logic depth (guarded: designs with no constrained setup
    # paths produce an empty report rather than failing the whole build).
    if { [catch {
        set ll_paths [get_timing_paths -setup -max_paths 100000 -nworst 1]
        report_design_analysis -logic_level_distribution \
            -of_timing_paths $ll_paths -file logic_levels.txt
    } ll_err] } {
        puts "WARNING: logic-level distribution report failed: $ll_err"
    }

    # --- Bitstream -----------------------------------------------------------
    # These designs pull random I/O to package pins, which trips benign default
    # DRCs; the original dataset disables DRC rules before bitgen, so mirror that.
    foreach rule [get_drc_checks] {
        set_property IS_ENABLED false $rule
    }
    write_bitstream -force design.bit

} error_msg] } {
    puts "\n$error_msg"
    exit 1
}
exit
