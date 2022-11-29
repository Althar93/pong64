# The build tools
TMPVIEW = './tools/TMPview_v1.3_Win32-STYLE/tmpview'

# Parameters
INPUTDIR  ?= d64
OUTPUTDIR ?= src

INPUT_FILES     := $(wildcard $(INPUTDIR)/*)
INPUT_PRG       := $(filter-out $(wildcard $(INPUTDIR)/*.*),$(INPUT_FILES))
INPUT_SEQ    	:= $(filter-out $(INPUT_PRG),$(INPUT_FILES))

OUTPUT_PRG      := $(patsubst $(INPUTDIR)/%,$(OUTPUTDIR)/%.asm,$(INPUT_PRG))
OUTPUT_SEQ 	    := $(patsubst $(INPUTDIR)/%,$(OUTPUTDIR)/%,$(INPUT_SEQ))

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

# PRG files
$(OUTPUTDIR)/%.asm: $(INPUTDIR)/%
	mkdir -p $(@D)
	$(TMPVIEW) -i $^ -o $@

# SEQ files
$(OUTPUTDIR)/%: $(INPUTDIR)/%
	cp -f $^ $@ 
