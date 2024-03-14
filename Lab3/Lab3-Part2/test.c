#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include "vector.h"

int main() {
    vector my_vector;
    printf("Initialising: \n");
    init_v(&my_vector);
    printf("Initialised\n");
    printf("Putting: \n");
    // Push some elements into the vector
    for (uint64_t i = 0; i < 10; i++) {
        push_v(&my_vector, (i+1)*10);
        printf("Current vector size: %lu\n", size_v(&my_vector));

    }
    printf("Deleting\n");
    delete_v(&my_vector);
    printf("Vector deleted successfully, now to add elements again\n\n");

    init_v(&my_vector);
    for (uint64_t i = 0; i < 10; i++) {
        push_v(&my_vector, (i+1)*10);
        printf("Current vector size: %lu\n", size_v(&my_vector));
    }

   // Print the vector's elements
    printf("Printing elements\n");
    for (uint64_t i = 0; i < size_v(&my_vector); i++) {
        uint64_t *element = get_element_v(&my_vector, i);
        printf("Element at index %lu: %lu\n", i, *element);
    }

    // Pop elements from the vector
    while (size_v(&my_vector) > 0) {
        printf("Current vector size: %lu\n", size_v(&my_vector));
        uint64_t popped = pop_v(&my_vector);
        printf("Popped element: %lu\n", popped);
    }

    // Test resizing
    //resize_v(&my_vector, 20);
//    printf("Vector resizing successful\n");

    // Print the resized vector's size
    printf("Final vector size: %lu\n", size_v(&my_vector));

    // Clean up the vector
    //delete_v(&my_vector);
    //printf("Vector deleted successfully\n\n");
    printf("Reached the end!!!\n");
    return 0;
}