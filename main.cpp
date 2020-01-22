#include <iostream>
#include <cstdlib>
#include "avx.hpp"

float *aligned_float_alloc()
{
#ifdef _GLIBCXX_HAVE_ALIGNED_ALLOC
    float *t = static_cast<float *>(std::aligned_alloc(32, sizeof(float) * 8));
#else
    float *t = static_cast<float *>(c_aligned_alloc(32, sizeof(float) * 8, false));
#endif

    return t;
}

int main(void)
{
    float *t1 = aligned_float_alloc();
    float *t2 = aligned_float_alloc();
    float *t3 = aligned_float_alloc();
    for (int i = 0; i < 8; i++) {
        t1[i] = 1.1f * (i + 1);
        t2[i] = 0.1f * (i + 1);
    }
    for (unsigned int i = 0; i < 2000000000; i++)
        AVXAddTab(t1, t2, t1);
    for (int i = 0; i < 8; i++) {
        std::cout << t1[i];
        if (i < 7)
            std::cout << " ";
    }
    std::cout << std::endl;
#ifdef _GLIBCXX_HAVE_ALIGNED_ALLOC
    delete t1;
    delete t2;
    delete t3;
#else
    c_aligned_free(t1);
    c_aligned_free(t2);
    c_aligned_free(t3);
#endif
    return 0;
}