# RandSoC FPT-2026 dataset -- build any single design from its design.tcl.
#
# Requirements:
#   * Xilinx Vivado 2024.2 on your PATH. The designs instantiate
#     version-specific IP (VLNVs), so design.tcl checks the Vivado version and
#     errors out on a mismatch.
#   * python3 (only for the tiny vivado_ioparse.py helper).
#
# Usage:
#   make DESIGN=0042            # synth + impl + bitstream for design_0042
#   make synth DESIGN=0042      # synthesis only
#   make clean DESIGN=0042      # remove that design's build directory
#   make list                   # how many designs are available
#
# All build products land in build/design_<DESIGN>/ and mirror the artifacts
# shipped in the original dataset:
#   synthesis:      viv_synth.edf, synth.dcp, synth.v, report_io.txt, design.xdc
#   implementation: impl.dcp, viv_impl.v, viv_impl.edf, design.bit,
#                   utilization.txt, utilization_hier.txt, timing_summary.txt,
#                   congestion.txt, logic_levels.txt, power.txt

VIVADO  ?= vivado
PYTHON  ?= python3
DESIGN  ?= 0000
PART    ?= xc7a200tlffv1156-2L

# Absolute path to this Makefile's directory, so builds work from anywhere.
ROOT       := $(abspath $(dir $(lastword $(MAKEFILE_LIST))))
DESIGN_DIR := $(ROOT)/designs/design_$(DESIGN)
WORK       := $(ROOT)/build/design_$(DESIGN)

SYNTH_EDF  := $(WORK)/viv_synth.edf
BITSTREAM  := $(WORK)/design.bit

.PHONY: all synth impl clean list check

all: impl
synth: $(SYNTH_EDF)
impl: $(BITSTREAM)

check:
	@test -f $(DESIGN_DIR)/design.tcl || \
		{ echo "No such design: $(DESIGN_DIR) (try DESIGN=0000)"; exit 1; }

# --- Synthesis -----------------------------------------------------------
# design.tcl is self-contained: it builds the project + block design, runs
# synth_1, and writes viv_synth.edf / synth.dcp / report_io.txt into $(WORK).
# vivado_ioparse.py then turns report_io.txt into the pin constraints (design.xdc).
$(SYNTH_EDF): $(DESIGN_DIR)/design.tcl | check
	mkdir -p $(WORK)
	cd $(WORK) && $(VIVADO) -mode batch -source $(DESIGN_DIR)/design.tcl
	cd $(WORK) && $(PYTHON) $(ROOT)/scripts/vivado_ioparse.py \
		< report_io.txt > design.xdc

# --- Implementation ------------------------------------------------------
# Read the synthesized netlist + constraints, opt/place/route, write reports
# and the bitstream. DESIGN_DIR and PART are passed to impl.tcl via the env.
$(BITSTREAM): $(SYNTH_EDF)
	cd $(WORK) && DESIGN_DIR=$(DESIGN_DIR) PART=$(PART) \
		$(VIVADO) -mode batch -source $(ROOT)/scripts/impl.tcl

clean:
	rm -rf $(WORK)

list:
	@echo "$(words $(wildcard $(ROOT)/designs/design_*)) designs available (design_0000 .. design_9999)"
