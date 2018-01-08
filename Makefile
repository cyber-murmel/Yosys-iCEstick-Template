TOP = example
CLK_MHZ = 100

SYN = yosys
SYN_FLAGS = -q -p "synth_ice40 -blif $@"
PNR = arachne-pnr
PNR_FLAGS = -d 1k -p src/$(TOP).pcf
PCK = icepack
PCK_FLAGS = 
PRG = iceprog
PRG_FLAGS =
TIM = icetime
TIM_FLAGS = -tmd hx1k -c $(CLK_MHZ) -p src/$(TOP).pcf -r /dev/null

synthesize: build build/$(TOP).bin

build/$(TOP).blif: src/$(TOP).v
	$(SYN) $(SYN_FLAGS) $<

build/$(TOP).asc: build/$(TOP).blif src/$(TOP).pcf
	$(PNR) $(PNR_FLAGS) $< -o $@

build/$(TOP).bin: build/$(TOP).asc
	$(PCK) $(PCK_FLAGS) $< $@

build:
	mkdir -p build

check_time: build/$(TOP).asc src/$(TOP).pcf
	$(TIM) $(TIM_FLAGS) $<   
	
flash: build/$(TOP).bin
	$(PRG) $(PRG_FLAGS) $<

clean:
	rm -rf build

.PHONY: synthesize flash clean check_time
