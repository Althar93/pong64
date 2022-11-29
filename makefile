# The build tools
TMPVIEW = './tools/TMPview_v1.3_Win32-STYLE/tmpview'

# Parameters
INPUTDIR  ?= d64
OUTPUTDIR ?= src

BINARY_FILES  	:= $(wildcard $(INPUTDIR)/*)
ASM_FILES 		:= $(patsubst $(INPUTDIR)/%,$(OUTPUTDIR)/%.asm,$(BINARY_FILES))

# Default step
default: $(ASM_FILES)

# Clean step
clean: 
	rm -f $(OUTPUTDIR)/*.asm

# Conversion rule
$(OUTPUTDIR)/%.asm: $(INPUTDIR)/%
	mkdir -p $(@D)
	$(TMPVIEW) -i $^ -o $@

