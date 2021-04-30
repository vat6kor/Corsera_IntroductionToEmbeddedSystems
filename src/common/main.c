/******************************************************************************
 * Copyright (C) 2017 by Alex Fosdick - University of Colorado
 *
 * Redistribution, modification or use of this software in source or binary
 * forms is permitted as long as the files maintain this copyright. Users are
 * permitted to modify this and use it to learn about the field of embedded
 * software. Alex Fosdick and the University of Colorado are not liable for any
 * misuse of this material.
 *
 *****************************************************************************/
/**
 * @file main.c
 * @brief Main entry point to the course1 final Assessment
 *
 * This file contains calls to the functions defined in
 * course1.h but wrapped in a compile time switch.
 *
 * @author Vinay Sathyanarayana
 * @date April 28 2021
 *
 */
#include "course1.h"

/* A pretty boring main file */
int main(void) {

    /******************************************************************************
     FUNCTION = COURSE1
    ******************************************************************************/
    #if defined (COURSE1)
      course1();

    /******************************************************************************
     FUNCTION = TEST_DATA1
    ******************************************************************************/
    #elif defined (TEST_DATA1)
      test_data1();

    /******************************************************************************
     FUNCTION = TEST_DATA2
    ******************************************************************************/
    #elif defined (TEST_DATA2)
      test_data2();

    /******************************************************************************
     FUNCTION = TEST_MEMMOVE1
    ******************************************************************************/
    #elif defined (TEST_MEMMOVE1)
      test_memmove1();

    /******************************************************************************
     FUNCTION = TEST_MEMMOVE2
    ******************************************************************************/
    #elif defined (TEST_MEMMOVE2)
      test_memmove2();

    /******************************************************************************
     FUNCTION = TEST_MEMMOVE3
    ******************************************************************************/
    #elif defined (TEST_MEMMOVE3)
      test_memmove3();

    /******************************************************************************
     FUNCTION = TEST_MEMCOPY
    ******************************************************************************/
    #elif defined (TEST_MEMCOPY)
      test_memcopy();

    /******************************************************************************
     FUNCTION = TEST_MEMSET
    ******************************************************************************/
    #elif defined (TEST_MEMSET)
      test_memset();

    /******************************************************************************
     FUNCTION = TEST_REVERSE
    ******************************************************************************/
    #elif defined (TEST_REVERSE)
      test_reverse();

    /******************************************************************************
     FUNCTION - Unsupported
    ******************************************************************************/
    #else
        #error "Function provided is not supported in this Build System"
    #endif

    return 0;

  return 0;
}
