/******************************************************************************
******************************************************************************/

#include <stddef.h>
#include <memory.h>

/**
 * @file data.h
 * @brief Abstraction of integer to ASCII and ASCII to integer conversion
 *
 * This header file provides interfaces to convert data from ASCII to Integer
 * and vice-versa.
 *
 * @author Vinay Sathyanarayana
 * @date 28/04/2021
 *
 */

#define ABS(a) ((a) < 0 ? -(a) : (a))

/**
 * @brief Converts integer to ASCII.
 *
 * Given a pointer to a char data set, and 32 bit integer,depending on the
 * base provided, it converts the integer to ASCII String representation.
 *
 * @param ptr Pointer to data array
 * @param data Integer
 * @param base Base provided from 2 to 16
 *
 * @return uint8_t Length of the coverted string.
 */

uint8_t my_itoa(int32_t data, uint8_t * ptr, uint32_t base);

/**
 * @brief Converts ASCII to integer
 *
 * Given a pointer to a char data set, and the length of the string,
 * depending on the base it converts from ASCII string to integer
 *
 * @param ptr Pointer to data array
 * @param digits Length of the String
 * @param base Base provided from 2 to 16
 *
 * @return int32_t converted 32-bit signed integer
 *
 */

int32_t my_atoi(uint8_t * ptr, uint8_t digits, uint32_t base);
