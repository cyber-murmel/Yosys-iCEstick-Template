# Parameters
NAME ?= example
CLK_MHZ ?= 100

# Tool and Flag Definition
SYN ?= yosys
SYN_FLAGS ?= -q -p "synth_ice40 -blif $@"
PNR ?= arachne-pnr
PNR_FLAGS ?= -d 1k
PCK ?= icepack
PCK_FLAGS ?= 
PRG ?= iceprog
PRG_FLAGS ?=
TIM ?= icetime
TIM_FLAGS ?= -tmd hx1k -c $(CLK_MHZ) -p src/$(NAME).pcf -r /dev/null

# Directories and Files
PRJ_DIR  = .
PRJ_SRC  = $(wildcard $(PRJ_DIR)/src/*.v)
PRJ_PCF  = $(wildcard $(PRJ_DIR)/src/*.pcf)
OUT_DIR  = ./build

# Targets
synthesize: lint build build/$(NAME).bin

build/$(NAME).blif: $(PRJ_SRC)
	$(SYN) $(SYN_FLAGS) $?

build/$(NAME).asc: build/$(NAME).blif $(PRJ_PCF)
	$(PNR) $(PNR_FLAGS) -p $(PRJ_PCF) $< -o $@

build/$(NAME).bin: build/$(NAME).asc
	$(PCK) $(PCK_FLAGS) $< $@

lint: $(PRJ_SRC)
	verilator --lint-only $^

build:
	mkdir -p $(OUT_DIR)

check_time: build/$(NAME).asc src/$(NAME).pcf
	$(TIM) $(TIM_FLAGS) $<   
	
flash: synthesize
	$(PRG) $(PRG_FLAGS) build/$(NAME).bin

clean:
	rm -rf build

.PHONY: synthesize lint build flash clean check_time
