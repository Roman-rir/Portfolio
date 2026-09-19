
.PHONY: elaborate verify clean

ifndef SIM_TOP 
$(info SIM_TOP variable not found; Extracting from manifest.json)
SIM_TOP=$(shell python3 ${REPO_ROOT}/util/compile.py ../manifest.json sim_top)
export SIM_TOP
endif

elaborate:
	python3 $(REPO_ROOT)/util/compile.py ../manifest.json --elaborate

verify:
	python3 $(REPO_ROOT)/util/compile.py ../manifest.json --verify

clean:
	rm -rf xrun* INCA_libs waves.shm .simvision cov_work/ xcelium.d/ qaLog.txt

