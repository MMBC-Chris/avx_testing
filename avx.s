    global GetAVXSupportFlag
    global GetVal
    global SetVal
    global NonAVXAddTab
    global AVXAddTab

    section .text
GetAVXSupportFlag:
    mov rax, 1
    cpuid
    xor rax, rax
    bt ecx, 28
    adc rax, rax
    ret

GetVal:
    cmp esi, 0
    jge GetVal_CV
    xor rsi, rsi
GetVal_CV:
    movss xmm0, [rdi + rsi*4]
    ret

SetVal:
    cmp esi, 0
    jge SetVal_CV
    xor rsi, rsi
SetVal_CV:
    movss [rdi + rsi*4], xmm0
    ret

NonAVXAddTab:
    xor rbx, rbx
NonAVXAddTab_LB:
    cmp rbx, 8
    je NonAVXAddTab_LE
    movss xmm1, [rdi + rbx*4]
    vaddss xmm0, xmm1, [rsi + rbx*4]
    movss [rdx + rbx*4], xmm0
    inc rbx
    jmp NonAVXAddTab_LB
NonAVXAddTab_LE:
    ret

AVXAddTab:
    vmovaps ymm1, [rdi]
    vaddps ymm0, ymm1, [rsi]
    vmovaps [rdx], ymm0
    ret