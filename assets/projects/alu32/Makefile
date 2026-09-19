# Makefile for ATSH VLSI IMPLEMENTATION FLOW
# Ataus Shafi
# atausshafi@gmail.com

# Checking if enviornment is setup correctly
ifndef PROJECT 
$(error PROJECT variable not found. Please make sure to update the variable and source env.sh)
endif

ifndef REPO_ROOT
$(error REPO_ROOT variable not found. Please make sure to update the variable and source env.sh)
endif

ifndef TOP 
$(info TOP variable not found; Extracting from manifest.json)
TOP=$(shell python3 ${REPO_ROOT}/util/compile.py manifest.json syn_top)
export TOP
endif

# Generating a timestamp with format: YYYYMMDD_HHMM to keep the order same choronologiaclly and alphabetically
TIMESTAMP := $(shell date +%Y%m%d_%H%M)
ifdef KEEP_BUILDS 
BUILD := _$(TOP)_$(TIMESTAMP)
endif

TECH := sky130_cadence


OPT_INNOVUS := ""
OPT_GENUS := ""


.PHONY: all synth pnr lec clean

all: signoff
	

setup:
	$(which bash) ../../util/setup.sh

elaborate:
	cd sim ; \
	make elaborate

verify: elaborate
	cd sim ; \
	make verify

lint: build

synth$(BUILD)/outputs/$(TOP)_gate.v:
	mkdir -vp synth$(BUILD) ; \
	mkdir -vp synth$(BUILD)/design_data ; \
	mkdir -vp synth$(BUILD)/scripts ; \
	cp -vp $(shell python3 $(REPO_ROOT)/util/compile.py manifest.json syn) synth$(BUILD)/design_data ; \
	cp -vp $(shell python3 $(REPO_ROOT)/util/compile.py manifest.json syn_sdc) synth$(BUILD)/design_data ; \
	cp -vr $(REPO_ROOT)/util/scripts/synth/* synth$(BUILD)/scripts ; \
	cd synth$(BUILD) ; \
	unlink outputs; unlink reports; unlink logs; \
	genus -f scripts/run_synth.tcl
	@if [ ! -f $@ ] ; then \
		printf "ERROR: Cannot find $@ \n\tSynthesis did not complete succussfully \n\t Please check logfile"; \
		false ; \
	fi

lec: synth
	mkdir -p backend/lec ; \
	cd backend/lec ; \
	lec -dofile ../synth/

pnr$(BUILD)/final/$(TOP).gds: synth$(BUILD)/outputs/$(TOP)_gate.v
	mkdir -p pnr$(BUILD) ; \
	mkdir -p pnr$(BUILD)/design_data ; \
	mkdir -p pnr$(BUILD)/scripts ; \
	cp synth$(BUILD)/outputs/$(TOP)_gate.v pnr$(BUILD)/design_data/ ; \
	cp synth$(BUILD)/outputs/$(TOP).sdc pnr$(BUILD)/design_data/ ; \
	cp ${REPO_ROOT}/util/viewDefinition_$(TECH).tcl pnr$(BUILD)/design_data/viewDefinition.tcl ; \
	cp -r ${REPO_ROOT}/util/scripts/pnr/* pnr$(BUILD)/scripts/ ; \
	cd pnr$(BUILD) ; \
	make pnr -f scripts/Makefile_pnr

synth: synth$(BUILD)/outputs/$(TOP)_gate.v
pnr: pnr$(BUILD)/final/$(TOP).gds 
signoff: backend/pnr$(BUILD)/outputs/$(TOP).gds 

clean:
	rm -rf synth*
	rm -rf pnr*

