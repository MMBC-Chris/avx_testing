#include <iostream>
#include <cstdlib>
#include "avx.hpp"

float *aligned_float_alloc()
{
    float *t = static_cast<float *>(std::aligned_alloc(32, sizeof(float) * 8));

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
    /*std::cout << "AVX support: ";
    if (GetAVXSupportFlag())
        std::cout << "ok";
    else
        std::cout << "none";
    std::cout << std::endl;

    float float_tab[8] = {
        1.1f,
        2.2f,
        3.3f,
        4.4f,
        5.5f,
        6.6f,
        7.7f,
        8.8f
    };
    SetVal(float_tab, 4, 0.9f);
    float test = GetVal(float_tab, 4);
    std::cout << test << std::endl;*/
    delete t1;
    delete t2;
    delete t3;
    return 0;
}