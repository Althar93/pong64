# The build tools
TMPVIEW = './tools/TMPview_v1.3_Win32-STYLE/tmpview'

# Parameters
INPUTDIR  		?= d64
OUTPUTDIR 		?= src

# Header size for the P00 format 
# See : https://infinite-loop.at/Power64/Documentation/Power64-ReadMe/AE-File_Formats.html
P00_HEADER 		:= 26

# Inputs/outputs
INPUT_P00       := $(wildcard $(INPUTDIR)/*.P00)
INPUT_S00    	:= $(wildcard $(INPUTDIR)/*.S00)

INPUT_PRG       := $(patsubst $(INPUTDIR)/%.P00,$(OUTPUTDIR)/%.P00.C64,$(INPUT_P00))
INPUT_SEQ 	    := $(patsubst $(INPUTDIR)/%.S00,$(OUTPUTDIR)/%.S00.C64,$(INPUT_S00))

OUTPUT_PRG      := $(patsubst $(OUTPUTDIR)/%.P00.C64,$(OUTPUTDIR)/%.prg,$(INPUT_PRG))
OUTPUT_SEQ 	    := $(patsubst $(OUTPUTDIR)/%.S00.C64,$(OUTPUTDIR)/%.seq,$(INPUT_SEQ))

# Default step
default: $(OUTPUT_PRG) $(OUTPUT_SEQ)

# Clean step
clean: 
	rm -f $(OUTPUTDIR)/*

# List files
list: 
	@echo "Input file(s)" $(INPUT_FILES)
	@echo "PRG file(s)" $(INPUT_PRG)
	@echo "SEQ file(s)" $(INPUT_SEQ)

# P00 to C64 conversion
$(OUTPUTDIR)/%.C64: $(INPUTDIR)/%
	mkdir -p $(@D)
	dd skip=$(P00_HEADER) bs=1 if=$^ of=$@

# PRG files
$(OUTPUTDIR)/%.prg: $(OUTPUTDIR)/%.P00.C64
	mkdir -p $(@D)
	$(TMPVIEW) -i $^ -o $@

# SEQ files
$(OUTPUTDIR)/%.seq: $(OUTPUTDIR)/%.S00.C64
	mkdir -p $(@D)
	cp -f $^ $@ 