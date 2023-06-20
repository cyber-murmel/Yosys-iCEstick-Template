# Parameters
NAME ?= example
CLK_MHZ ?= 100
DEVICE = hx1k


# Tool and Flag Definition
SYN ?= yosys
SYN_FLAGS ?= -r $(NAME) -q -p "synth_ice40 -blif $@"
PNR ?= arachne-pnr
PNR_FLAGS ?= -d $(subst hx,,$(subst lp,,$(DEVICE))) -P tq144
PCK ?= icepack
PCK_FLAGS ?= 
PRG ?= iceprog
PRG_FLAGS ?=
TIM ?= icetime
TIM_FLAGS ?= -tmd $(DEVICE) -c $(CLK_MHZ)
SIM ?= iverilog
SIM_FLAGS ?= 
RUN ?= vvp
RUN_FLAGS ?= -N


# Directories and Files
PRJ_DIR  = .
PRJ_SRC  = $(wildcard $(PRJ_DIR)/src/*.v)
PRJ_PCF  = $(wildcard $(PRJ_DIR)/src/*.pcf)
TESTBEN  = $(wildcard $(PRJ_DIR)/test_bench/*.v)
GTKW     = $(wildcard $(PRJ_DIR)/test_bench/*.gtkw)
OUT_DIR  = $(PRJ_DIR)/build


# Targets
all: lint synthesize check_time

## Real Targets
$(OUT_DIR)/$(NAME).blif: $(PRJ_SRC)
	mkdir -p $(OUT_DIR)
	$(SYN) $(SYN_FLAGS) $^

$(OUT_DIR)/$(NAME).asc: $(PRJ_PCF) $(OUT_DIR)/$(NAME).blif
	$(PNR) $(PNR_FLAGS) -p $^ -o $@

$(OUT_DIR)/$(NAME).bin: $(OUT_DIR)/$(NAME).asc
	$(PCK) $(PCK_FLAGS) $^ $@

$(OUT_DIR)/$(NAME).rpt: $(PRJ_PCF) $(OUT_DIR)/$(NAME).asc
	$(TIM) $(TIM_FLAGS) -r $@ -p $^

$(OUT_DIR)/$(NAME).tb: $(PRJ_SRC) $(TESTBEN)
	mkdir -p $(OUT_DIR)
	$(SIM) $(SIM_FLAGS) $^ -o $@

$(OUT_DIR)/$(NAME).vcd: $(OUT_DIR)/$(NAME).tb
	$(RUN) $(RUN_FLAGS) $^
	mv dump.vcd $(OUT_DIR)/$(NAME).vcd

## Phony Targets
lint: $(PRJ_SRC)
	verilator --lint-only $^

synthesize: build/$(NAME).bin

check_time: build/$(NAME).rpt

sim: build/$(NAME).vcd $(GTKW)
	gtkwave $^ &

flash: synthesize
	$(PRG) $(PRG_FLAGS) build/$(NAME).bin

clean:
	rm -rf build

.PHONY: all lint synthesize build check_time flash clean
