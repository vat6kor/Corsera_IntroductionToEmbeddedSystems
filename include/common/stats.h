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
 * @file stats.h
 * @brief This file contains declarations for statistics functions
 *
 * This file has declarations for the following functions
 * print_statistics(), print_array(), find_median(), find_mean(), find_maximum(), find_minimum() and sort_array()
 *
 * @author Vinay Sathyanarayana
 * @date 08.Apr.2021
 *
 */
#ifndef __STATS_H__
#define __STATS_H__

/* Add Your Declarations and Function Comments here */ 
typedef unsigned char 	uint8_t;
typedef unsigned short int uint16_t;

/**
 * @brief A function that prints the statistics of an array including minimum, maximum, mean, and median.
 *
 * This function prints the statistics for a given array of unsigend char data.
 * It takes two inputs i.e. a pointer to the unsigned character array and the length of the array.
 * It then calculates minimum, maximum, mean and median for the array using the respective functions and prints them on the screen.
 *
 * @param[IN] data A constant unsigned char pointer to the base address of the array containing the data.
 * @param[IN] size The size of the array in terms of number of elements contained in it.
 *
 * @return void
 */
void print_statistics(uint8_t* data, uint8_t size);

/**
 * @brief Given an array of data and a length, prints the array to the screen
 *
 * This function prints the input array data as a list of numbers. 
 * It takes two inputs i.e. a pointer to the unsigned character array and the length of the array.
 * The numbers are printed separated by comma and enclosed in square brackets.
 *
 * @param[IN] data A constant unsigned char pointer to the base address of the array containing the data.
 * @param[IN] size The size of the array in terms of number of elements contained in it.
 *
 * @return void
 */
void print_array(uint8_t* data, uint8_t size);

 /**
 * @brief Given an array of data and the length of the array, returns the median value
 * 
 * This function retusns the median value of the given array.
 * It takes two inputs i.e. a pointer to the unsigned character array and the length of the array.
 * The array is sorted in decreasing order and if the size of the array is odd, the middle value is returened,
 * Else the mean value of the two mid values is returned. If the calulated mean of the 2 mid values is a fractional value,
 * it is rounded down to the nearest integer.
 *
 * @param[IN] data A constant unsigned char pointer to the base address of the array containing the data.
 * @param[IN] size The size of the array in terms of number of elements contained in it.
 *
 * @return uint8_t median value
 */
uint8_t find_median(uint8_t* data, uint8_t size);

/**
 * @brief Given an array of data and the length of the array, returns the mean value
 *
 * This function returns the mean value for a given array.
 * It takes two inputs i.e. a pointer to the unsigned character array and the length of the array.
 * It adds all the numbers in the array and divides it by the length of the array.
 * If the calulated mean is a fractional value, it is rounded down to the nearest integer.
 *
 * @param[IN] data A constant unsigned char pointer to the base address of the array containing the data.
 * @param[IN] size The size of the array in terms of number of elements contained in it.
 *
 * @return uint8_t mean value
 */
uint8_t find_mean(uint8_t* data, uint8_t size); 

/**
 * @brief Given an array of data and a length, returns the maximum
 *
 * This function returns the maximum value in the given array.
 * It takes two inputs i.e. a pointer to the unsigned character array and the length of the array.
 * The array is sorted in decreasing order and the first value i.e. at zeroth index is returned.
 *
 * @param[IN] data A constant unsigned char pointer to the base address of the array containing the data.
 * @param[IN] size The size of the array in terms of number of elements contained in it.
 *
 * @return uint8_t maximum value
 */
uint8_t find_maximum(uint8_t* data, uint8_t size); 

/**
 * @brief Given an array of data and a length, returns the minimum
 *
 * This function returns the minimum value in the given array.
 * It takes two inputs i.e. a pointer to the unsigned character array and the length of the array.
 * The array is sorted in decreasing order and the last value i.e. at length-1 index is returned.
 *
 * @param[IN] data A constant unsigned char pointer to the base address of the array containing the data.
 * @param[IN] size The size of the array in terms of number of elements contained in it.
 *
 * @return uint8_t minimum value
 */
uint8_t find_minimum(uint8_t*  data, uint8_t size); 

/**
 * @brief Given an array of data and a length, sorts the array from largest to smallest. 
 *
 * This function sorts the given array in the decreasing order.
 * It takes two inputs i.e. a pointer to the unsigned character array and the length of the array.
 * The function uses bubble sort algorithm for sorting.
 *
 * @param[IN] data A constant unsigned char pointer to the base address of the array containing the data.
 * @param[IN] size The size of the array in terms of number of elements contained in it.
 *
 * @return void
 */
void sort_array(uint8_t* data, uint8_t size); 


#endif /* __STATS_H__ */
