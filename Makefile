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
# Simple makefile for two target platforms and their own
# specific compilers. These two platforms are the HOST and
# the MSP432.
# The host embedded system will use the native compiler, gcc.
# The target embedded system will use the cross compiler,
# arm-none-eabi-gcc.
#
# @author Vinay Sathyanarayana
# @date 29 April 2021
#
# Use: make [TARGET] [PLATFORM-OVERRIDES] [FUNCTION] [DEBUG - Optional]
# Example: $ make build PLATFORM=HOST FUNCTION=COURSE1 DEBUG=VERBOSE
#
# Build Targets:
#      <FILE>.i - Generate <FILE>.i preprocessed output
#      <FILE>.asm - Generate <FILE>.asm assembly output
#      <FILE>.o - Builds <FILE>.o object file
#      compile-all - Compile all object files, but DO NOT link
#      build - Builds and links all source files
#      clean - Removes all generated files
#
# PLATFORM-OVERRIDES:
#       PLATFORM=HOST - Compile for HOST using gcc
#       PLATFORM=MSP432 - Compile for MSP432 using arm-none-eabi-gcc
#
# FUNCTION:
# 			FUNCTION=COURSE1
# 			FUNCTION=TEST_DATA1
# 			FUNCTION=TEST_DATA2
# 			FUNCTION=TEST_MEMMOVE1
# 			FUNCTION=TEST_MEMMOVE2
# 			FUNCTION=TEST_MEMMOVE3
# 			FUNCTION=TEST_MEMCOPY
# 			FUNCTION=TEST_MEMSET
# 			FUNCTION=TEST_REVERSE
#
# DEBUG:
#       DEBUG=VERBOSE - Print extra information on the memory data
#
#------------------------------------------------------------------------------
include sources.mk

# Platform overrides
PLATFORM 	= HOST
FUNCTION 	= COURSE1
VERBOSE		= TRUE
#DEBUG		= VERBOSE

#output
TARGET 	= $(BINPATH)/$(PROJNAME).out

#Out dirs
BINDIR	:= bin
GENDIR	:= gen
LOGDIR	:= log

#gendirs
CPPDIR	:= gen/cpp
ASMDIR 	:= gen/asm
OBJDIR 	:= gen/obj

#paths
BINPATH := $(TARGETPATH)/$(BINDIR)
GENPATH := $(TARGETPATH)/$(GENDIR)
LOGPATH := $(TARGETPATH)/$(LOGDIR)

ASMPATH	:= $(TARGETPATH)/$(ASMDIR)
CPPPATH	:= $(TARGETPATH)/$(CPPDIR)
OBJPATH	:= $(TARGETPATH)/$(OBJDIR)

#common variables for all platforms
COMMONCFLAGS 	= -Wall -O0 -Werror -g -std=c99 -Wno-pointer-sign
COMMONLDFLAGS 	= -Wl,-Map=$(PROJNAME).map

ifeq ($(DEBUG), VERBOSE)
	CPPFLAGS = -D$(PLATFORM) -D$(FUNCTION) -D$(DEBUG) $(INCLUDES)
else
	CPPFLAGS = -D$(PLATFORM) -D$(FUNCTION) $(INCLUDES)
endif

NMFLAGS			= -A -S --size-sort -s
OBJDUMPFLAGS	= -d

ifeq ($(PLATFORM), MSP432)
	# Architectures Specific Flags
	LINKER_PATH	= -L ./
	LINKER_FILE = msp432p401r.lds
	CPU 		= cortex-m4
	ARCH 		= armv7e-m
	SPECS 		= nosys.specs
	ADDITIONAL 	= -mthumb -mfloat-abi=hard -mfpu=fpv4-sp-d16

	# C compiler Flags and Defines
	CC 		= arm-none-eabi-gcc
	CFLAGS 	= $(COMMONCFLAGS) -mcpu=$(CPU) -march=$(ARCH) --specs=$(SPECS) $(ADDITIONAL)

	# Linker Flags and Defines
	LD 		= arm-none-eabi-ld
	LDFLAGS = $(COMMONLDFLAGS) $(LINKER_PATH) -T $(LINKER_FILE) -nostartfiles

	#GNU Bin Utils Flags and Defines
	OBJDUMP = arm-none-eabi-objdump
	SIZE 	= arm-none-eabi-size
	NM 		= arm-none-eabi-nm
else
	# C compiler Flags and Defines
	CC 		= gcc
	CFLAGS 	= $(COMMONCFLAGS)

	# Linker Flags and Defines
	LD 		= ld
	LDFLAGS	= $(COMMONLDFLAGS)

	#GNU Bin Utils Flags and Defines
	OBJDUMP = objdump
	SIZE 	= size
	NM		= nm
endif

# Define objects for all sources
CPP	 = $(foreach src, $(notdir $(SOURCES:.c=.i)), $(addprefix $(CPPPATH)/, $(src)))
ASMS = $(foreach src, $(notdir $(SOURCES:.c=.asm)), $(addprefix $(ASMPATH)/, $(src)))
OBJS = $(foreach src, $(notdir $(SOURCES:.c=.o)), $(addprefix $(OBJPATH)/, $(src)))

RM 			= rm -rf
RMDIR 		= rm -rf
MKDIR 		= mkdir -p
ERRIGNORE 	= 2>/dev/null

# Hide or not the calls depending of VERBOSE
ifeq ($(VERBOSE),TRUE)
	HIDE =
else
	HIDE = @
endif

##############################################################################################################
#Generates the object files of all c-program implementation files and its dependecies.

#This implementation places dependency files into a subdirectory named .deps.
DEPDIR := $(PROJDIR)/.deps

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
# Define the function that will generate each rule
define generateRules
$$(OBJPATH)/%.o: %.c $$(DEPDIR)/%.d | $$(DEPDIR) directories
	$$(CC) -c $$(DEPFLAGS) $$(CPPFLAGS) $$(CFLAGS) $$< -o $$@
endef

# Generate rules
$(foreach targetdir, $(OBJPATH), $(eval $(call generateRules, $(targetdir))))

# Declare a rule for creating the dependency directory if it doesn’t exist.
$(DEPDIR): ; @mkdir -p $@

# Generate a list of all the dependency files that could exist.
DEPFILES := $(foreach src,$(notdir $(SOURCES:.c=.d)),$(addprefix $(DEPDIR)/,$(src)))

# Mention each dependency file as a target, so that make won’t fail if the file doesn’t exist.
$(DEPFILES):

include $(wildcard $(DEPFILES))
############################################################################################################

.PHONY: directories compile-all build build-all clean build-test

directories:
	@mkdir -p $(BINPATH) $(GENPATH) $(LOGPATH) $(OBJPATH) $(ASMPATH) $(CPPPATH)

# Generates the preprocessed output of all c-program implementation files.
$(CPPPATH)/%.i: %.c
	$(CC) $(CPPFLAGS) -E $(CFLAGS) -o $@ $^

# Create assembly file of a C source.
$(ASMPATH)/%.asm: %.c
	$(CC) $(CPPFLAGS) -S $(CFLAGS) -o $@ $<

# Compile all objects but do NOT link them.
compile-all: $(SOURCES)
	$(CC) $(CPPFLAGS) -c $^ $(CFLAGS)

# Complete build:
build: $(TARGET)
$(TARGET):$(OBJS)
	$(CC) $(CFLAGS) $(LDFLAGS) $^ -o $@
	mv $(PROJNAME).map $(LOGPATH)
	$(OBJDUMP) $(OBJDUMPFLAGS) $^ $@ > $(LOGPATH)/$(notdir $*)_objdump.txt
	$(NM) $(NMFLAGS) $@ > $(LOGPATH)/$(notdir $*)_nm.txt
	$(SIZE) $^ $@ > $(LOGPATH)/$(notdir $*)_size.txt
	@echo "\a\n\nBuild successful\nplease find the binary at ./out/bin/finalAssessment.out"
	

build-all: directories $(CPP) $(ASMS) $(OBJS) $(TARGET)

# Remove all compiled objects, preprocessed outputs, assembly outputs executable files and build output files.
clean:
	$(HIDE)$(RMDIR) $(TARGETPATH) $(DEPDIR) $(ERRIGNORE)
	$(HIDE)$(RM) $(TARGET) $(ERRIGNORE)
	@echo Cleaning done !
