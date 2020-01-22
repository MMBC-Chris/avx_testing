#pragma once

#include <cstdlib>

int GetAVXSupportFlag(void);

float GetVal(float *, int);
void SetVal(float *, int, float);

// compatible memory alignment
extern "C" void *c_aligned_alloc(size_t, size_t, bool);
extern "C" void c_aligned_free(void *);

// now we get into the spicy stuff
extern "C" void NonAVXAddTab(float *, float *, float *);
extern "C" void AVXAddTab(float *, float *, float *);