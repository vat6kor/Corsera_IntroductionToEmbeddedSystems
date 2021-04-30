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

# Set project directory one level above the Makefile directory. $(CURDIR) is a
# GNU make variable containing the path to the current working directory

# Platform Overrides
PLATFORM = MSP432

PROJDIR	:= $(realpath $(CURDIR))
PROJNAME:= finalAssessment

ifeq ($(PLATFORM),MSP432)
	SOURCEDIRS	= src/common src/msp432
	INCLUDEDIRS	= include/CMSIS include/common include/msp432
else
	SOURCEDIRS	= src/common
	INCLUDEDIRS	= include/common
endif

TARGETDIRS 	:= out

# Create the list of directories
SOURCEPATH 	= $(foreach dir, $(SOURCEDIRS), $(addprefix $(PROJDIR)/, $(dir)))
INCLUDEPATH = $(foreach dir, $(INCLUDEDIRS), $(addprefix $(PROJDIR)/, $(dir)))
TARGETPATH 	= $(foreach dir, $(TARGETDIRS), $(addprefix $(PROJDIR)/, $(dir)))

build-test:
	@echo $(SOURCEPATH)

# Add this list to VPATH, the place make will look for the source files
VPATH = $(SOURCEPATH)

# Add your include paths to this variable
# Generate the GCC includes parameters by adding -I before each source folder
INCLUDES = $(foreach dir, $(INCLUDEPATH), $(addprefix -I$(INCLUDE), $(dir)))

# Create a list of *.c sources in DIRS
SOURCES = $(foreach dir,$(SOURCEPATH),$(wildcard $(dir)/*.c))
