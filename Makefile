#******************************************************************************
# Copyright (C) 2017 by Alex Fosdick - University of Colorado
#
# Redistribution, modification or use of this software in source or binary
# forms is permitted as long as the files maintain this copyright. Users are
# permitted to modify this and use it to learn about the field of embedded
# software. Alex Fosdick and the University of Colorado are not liable for any
# misuse of this material.
#
#*****************************************************************************

#------------------------------------------------------------------------------
# <Put a Description Here>
#
# Use: make [TARGET] [PLATFORM-OVERRIDES]
#
# Build Targets:
#      <Put a description of the supported targets here>
#
# Platform Overrides:
#      <Put a description of the supported Overrides here
#
#------------------------------------------------------------------------------
include sources.mk

# Platform Overrides
PLATFORM = HOST

#common variables for all platforms
BASENAME 			:= c1m2
TARGET 				:= $(BASENAME).out
COMMONCFLAGS 	= -Wall -O0 -Werror -g -std=c99
COMMONLDFLAGS = -Wl,-Map=$(BASENAME).map
CPPFLAGS 			= -D$(PLATFORM) $(INCLUDES)
NMFLAGS				= -A -S --size-sort -s
OBJDUMPFLAGS	= -d

ifeq ($(PLATFORM), MSP432)

	# Architectures Specific Flags
	LINKER_PATH	= -L ../
	LINKER_FILE = msp432p401r.lds
	CPU 				= cortex-m4
	ARCH 				= armv7e-m
	SPECS 			= nosys.specs
	ADDITIONAL 	= -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16

	# C compiler Flags and Defines
	CC 				= arm-none-eabi-gcc
	CFLAGS 		= $(COMMONCFLAGS) -mcpu=$(CPU) -march=$(ARCH) --specs=$(SPECS) $(ADDITIONAL)

	# Linker Flags and Defines
	LD 				= arm-none-eabi-ld
	LDFLAGS 	= $(COMMONLDFLAGS) $(LINKER_PATH) -T $(LINKER_FILE) -nostdlib

	#GNU Bin Utils Flags and Defines
	OBJDUMP = arm-none-eabi-objdump
	SIZE 		= arm-none-eabi-size
	NM 			= arm-none-eabi-nm
else

	# C compiler Flags and Defines
	CC 			= gcc
	CFLAGS 	= $(COMMONCFLAGS)

	# Linker Flags and Defines
	LD 			= ld
	LDFLAGS	= $(COMMONLDFLAGS)

	#GNU Bin Utils Flags and Defines
	OBJDUMP = objdump
	SIZE 		= size
	NM			= nm
endif

OBJS := $(SOURCES:.c=.o)
ASMS := $(SOURCES:.c=.asm)
PRES := $(SOURCES:.c=.i)

##############################################################################################################
#Generates the object files of all c-program implementation files and its dependecies.

#This implementation places dependency files into a subdirectory named .deps.
DEPDIR := .deps

# DEPFLAGS:

# -M
# Instead of outputting the result of preprocessing, output a rule suitable for
# make describing the dependencies of the main source file.

# -MT $@
# Set the name of the target in the generated dependency file.

# -MMD
# Generate dependency information as a side-effect of compilation, not instead of compilation.
# This version omits system headers from the generated dependencies.
# If you prefer to preserve system headers as prerequisites, use -MD.

# -MP
# Adds a target for each prerequisite in the list, to avoid errors when deleting files.

# -MF $(DEPDIR)/$*.d
# Write the generated dependency file $(DEPDIR)/$*.d.

DEPFLAGS = -MT $@ -MMD -MP -MF $(DEPDIR)/$*.d

# Delete the built-in rules for building object files from .c files, so that, this rule is used instead.
#%.o : %.c
%.o : %.c $(DEPDIR)/%.d | $(DEPDIR)
	$(CC) $(DEPFLAGS) $(CPPFLAGS) $(CFLAGS) -c $< -o $@

# Declare a rule for creating the dependency directory if it doesn’t exist.
$(DEPDIR): ; @mkdir -p $@

# Generate a list of all the dependency files that could exist.
DEPFILES := $(SOURCES:%.c=$(DEPDIR)/%.d)

# Mention each dependency file as a target, so that make won’t fail if the file doesn’t exist.
$(DEPFILES):

include $(wildcard $(DEPFILES))
############################################################################################################

# Generates the preprocessed output of all c-program implementation files.
%.i: %.c
	$(CC) $(CPPFLAGS) -E $(CFLAGS) -o $@ $^

# Create assembly file of a C source.
%.asm: %.c
	$(CC) $(CPPFLAGS) -S $(CFLAGS) -o $@ $<

# Compile all objects but do NOT link them.
.PHONY: compile-all
compile-all: $(SOURCES)
	$(CC) $(CPPFLAGS) -c $(CFLAGS) $^

#################################################################################
# Complete build:	*.d      - Dependency Files for each source file
#									*.o      - Individual object files
#									c1m2.map - Map file for the full build
#									c1m2.out - Output Executable file
.PHONY: build
build: $(TARGET)

$(TARGET):$(OBJS)
	$(CC) $(LDFLAGS) $^ -o $@
	$(OBJDUMP) $(OBJDUMPFLAGS) $^ $@ > $*_objdump.txt
	$(NM) $(NMFLAGS) $@ > $*_nm.txt
	$(SIZE) $^ $@ > $*_size.txt

.PHONY: build-all
build-all: $(PRES) $(ASMS) $(OBJS) $(TARGET)

# Remove all compiled objects, preprocessed outputs, assembly outputs executable files and build output files.
.PHONY: clean
clean:
	rm -f $(TARGET) *.map *.o *.asm *.i *.txt
	rm -r $(DEPDIR)
