
#### Coursera - Embedded Software - Course 1 Final Assessment <br /> ####
Vinay Sathyanarayana <br />

This repository contains solution to the final assessment of "Intro to Embedded Systems"
course on coursera. This assessment, fpcuses on memory management and data handling. For
more details on assignment requirements, please check the following url.

Assessment requirements: https://www.coursera.org/learn/introduction-embedded-systems/peer/prT70/expanded-build-system-and-memory

----

 Use: <br />
 `make [TARGET] [PLATFORM-OVERRIDES] [FUNCTION] [DEBUG - Optional]`

 Example: <br />
 `$ make build PLATFORM=HOST FUNCTION=COURSE1 DEBUG=VERBOSE`

----

* Build Targets:   
    * <FILE>.i - Generate <FILE>.i preprocessed output
    * <FILE>.asm - Generate <FILE>.asm assembly output
    * <FILE>.o - Builds <FILE>.o object file
    * compile-all - Compile all object files, but DO NOT link
    * build - Builds and links all source files
    * clean - Removes all generated files

----

* PLATFORM-OVERRIDES:
    * PLATFORM=HOST - Compile for HOST using gcc
    * PLATFORM=MSP432 - Compile for MSP432 using arm-none-eabi-gcc

----

* Directory structure:
    * CourseraEmbeddedSystems1  -> Project Root
        * out                   -> build outputs
            * bin               -> executables
            * gen               -> intermediate files
            * log               -> additional information from bin utils
        * src                   -> source files
            * common            -> sources common to both msp432 and host platforms
            * msp432            -> sources exclusively for msp432
        * include               -> file headers
            * CMSIS             -> Cortex M specific files
            * common            -> common headers for both host and msp432 platforms
            * msp432            -> msp432 specific files
        * .deps                 -> generated dependency files for each source file
----

* FUNCTION:
  * FUNCTION=COURSE1
  * FUNCTION=TEST_DATA1
  *	FUNCTION=TEST_DATA2
  *	FUNCTION=TEST_MEMMOVE1
  *	FUNCTION=TEST_MEMMOVE2
  *	FUNCTION=TEST_MEMMOVE3
  *	FUNCTION=TEST_MEMCOPY
  *	FUNCTION=TEST_MEMSET
  *	FUNCTION=TEST_REVERSE

 * DEBUG:
   * DEBUG=VERBOSE - Print extra information on the memory data
