# Makefile for VCS + Verdi Flow

# User changeable variables
VERDI_HOME     ?=	/home/synopsys/verdi/Verdi_O-2018.09-SP2
VCS_CMD        ?=	vcs
VERDI_CMD      ?=	verdi
DESIGN_FILES   ?=	sync_fifo_method1.v sync_fifo_tb.sv
TOP_MODULE     ?=	sync_fifo_tb
FSDB_FILE      ?=	dump.fsdb
PLI_TAB        ?=	$(VERDI_HOME)/share/PLI/VCS/LINUX64/novas.tab
PLI_LIB        ?=	$(VERDI_HOME)/share/PLI/VCS/LINUX64/pli.a
COMPILE_LOG    ?=	compile.log
SIM_LOG        ?=	simulate.log

# default target: compile and run simulation
all: compile simulate

# compiling design
compile:
	$(VCS_CMD) -sverilog -debug_access+all \
		-timescale=1ns/1ps \
		-P $(PLI_TAB) $(PLI_LIB) \
		-fsdb \
		+define+FSDB \
		-top $(TOP_MODULE) \
		$(DESIGN_FILES) \
		-l $(COMPILE_LOG)

# run simulation
simulate:
	./simv -l $(SIM_LOG)

# run verdi to view waveforms
verdi:
	$(VERDI_CMD) -ssf $(FSDB_FILE) &

# clean files that generated
clean:
	rm -rf simv simv.daidir csrc *.vpd *.fsdb *.log *.key *vcd DVEfiles

# usage help
help:
	@echo "Usage:"
	@echo "  make compile      # compile design"
	@echo "  make simulate     # run simulation to generate FSDB file"
	@echo "  make verdi        # run verdi to view waveforms"
	@echo "  make all          # compile and run simulation(default, equal to make)"
	@echo "  make clean        # clean up files that generated"

.PHONY: all compile simulate verdi clean help