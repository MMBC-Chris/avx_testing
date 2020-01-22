    global _Z17GetAVXSupportFlagv
    global _Z6GetValPfi
    global _Z6SetValPfif
    global _Z12NonAVXAddTabPfS_S_
    global _Z9AVXAddTabPfS_S_

    section .text
_Z17GetAVXSupportFlagv:
    mov rax, 1
    cpuid
    xor rax, rax
    bt ecx, 28
    adc rax, rax
    ret

_Z6GetValPfi:
    cmp esi, 0
    jge _Z6GetValPfi_CV
    xor rsi, rsi
_Z6GetValPfi_CV:
    movss xmm0, [rdi + rsi*4]
    ret

_Z6SetValPfif:
    cmp esi, 0
    jge _Z6SetValPfif_CV
    xor rsi, rsi
_Z6SetValPfif_CV:
    movss [rdi + rsi*4], xmm0
    ret

_Z12NonAVXAddTabPfS_S_:
    xor rbx, rbx
_Z12NonAVXAddTabPfS_S__LB:
    cmp rbx, 8
    je _Z12NonAVXAddTabPfS_S__LE
    movss xmm1, [rdi + rbx*4]
    vaddss xmm0, xmm1, [rsi + rbx*4]
    movss [rdx + rbx*4], xmm0
    inc rbx
    jmp _Z12NonAVXAddTabPfS_S__LB
_Z12NonAVXAddTabPfS_S__LE:
    ret

_Z9AVXAddTabPfS_S_:
    vmovaps ymm1, [rdi]
    vaddps ymm0, ymm1, [rsi]
    vmovaps [rdx], ymm0
    ret