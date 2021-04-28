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
 * @file stats.c
 * @brief contains definition of functions declared in stats.h and the main function 
 *
 * This file implements the prototypes defined in stats.h. In addition the main function
 * is also present here. The needed functions are called within the main function
 * to demonstrate the working of the stats functions.
 *
 * @author Vinay Sathyanarayana
 * @date 08.Apr.2021
 *
 */


#include <stdio.h>
#include "stats.h"

/* Size of the Data Set */
#define SIZE (40)

int main() {

  	unsigned char test[SIZE] = { 34, 201, 190, 154,   8, 194,   2,   6,
                             114, 88,   45,  76, 123,  87,  25,  23,
                             200, 122, 150, 90,   92,  87, 177, 244,
                             201,   6,  12,  60,   8,   2,   5,  67,
                               7,  87, 250, 230,  99,   3, 100, 90};

  /* Other Variable Declarations Go Here */
	uint8_t * data = test;

  /* Statistics and Printing Functions Go Here */
  	print_array(data,SIZE);
    print_statistics(data,SIZE);                                

    return 0;

}

void print_statistics(uint8_t* data, uint8_t size){

	sort_array(data, size);

	printf("\nThe summary of statistics for the given dataset is as follows.\
			\nMinimum value=%u\
			\nMaximum value=%u\
			\nmedian value=%u\
			\nmean value=%u\n",data[size-1],data[0],find_median(data,size),find_mean(data,size));
}

void print_array(uint8_t* data, uint8_t size){

	printf("\nThe elements in the array are:[");

	for(uint8_t i=0;i<size-1;++i){
		printf("%u, ",data[i]);
	}

	printf("%u]\n",data[size-1]);
}

uint8_t find_median(uint8_t* data, uint8_t size){

	sort_array(data, size);

	return size%2==0?(data[size/2]+data[(size-1)/2])/2:data[size/2];

}

uint8_t find_mean(uint8_t* data, uint8_t size){

	uint16_t sum=0;

	for(int i=0;i<size;++i)
		sum+=data[i];

	return sum/size;

}

uint8_t find_maximum(uint8_t* data, uint8_t size){

	uint8_t max = data[0];
  
  	for(int i=1;i<size;++i){
    	if(data[i]>max){
      	max = data[i];
    	}
  	}

  return max;

}

uint8_t find_minimum(uint8_t* data, uint8_t size){

	uint8_t min = data[0];
  
  	for(int i=1;i<size;++i){
    	if(data[i]<min){
      	min = data[i];
    	}
  	}

  return min;

}


void sort_array(uint8_t* data, uint8_t size){

	uint8_t temp = 0;

	for(uint8_t i=0;i<size;++i){
		for(uint8_t j=0;j<size-i-1;++j){
			if(data[j]<data[j+1]){
				temp = data[j];
				data[j] = data[j+1];
				data[j+1]=temp;
			}
		}
	}

}

