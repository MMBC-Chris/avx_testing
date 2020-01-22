#pragma once

int GetAVXSupportFlag(void);

float GetVal(float *, int);
void SetVal(float *, int, float);

// now we get into the spicy stuff
void NonAVXAddTab(float *, float *, float *);
void AVXAddTab(float *, float *, float *);