
#### Coursera - Embedded Software - Course 1 Final Assessment <br /> ####

Vinay Sathyanarayana <br />

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
