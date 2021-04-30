/*****************************************************************************
******************************************************************************/

/**
 * @file data.c
 * @brief ASCII to int and vice-versa conversions
 *
 * Implementation of atoi and itoa functions.
 *
 * @author Vinay Sathyanarayana
 * @date 29 April 2021
 *
 */
#include "data.h"
#include "memory.h"

uint8_t my_itoa(int32_t data, uint8_t * ptr, uint32_t base){

	uint8_t i = 0;
    bool isNegative = false;

    /* Handle 0 explicitly, otherwise empty string is printed for 0 */
    if (data == 0)
    {
        ptr[i++] = '0';
        ptr[i] = '\0';
        return i;
    }

    // In standard itoa(), negative numbers are handled only with
    // base 10. Otherwise numbers are considered unsigned.
	if (data < 0)
    {
        isNegative = true;
        data = -data;
    }

    // Process individual digits
    while (data != 0)
    {
        int rem = data % base;
        ptr[i++] = (rem > 9)? (rem-10) + 'a' : rem + '0';
        data = data/base;
    }

    // If number is negative, append '-'
    if (isNegative){
        ptr[i++] = '-';
	}

	// Reverse the string until the null termination
	my_reverse(ptr, i);

    ptr[i] = '\0'; // Append string terminator

    return i;
}


int32_t my_atoi(uint8_t * ptr, uint8_t digits, uint32_t base){

  int32_t result = 0;
  int8_t sign = 1;
  uint8_t index = 0;

  if (ptr[0] == '-'){
      sign = -1;
      index++;
  }

  for (; index < digits; index++){
      result = result*base + ptr[index] - '0';
  }

  return sign*result;
}
