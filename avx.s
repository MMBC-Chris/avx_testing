%ifidn __OUTPUT_FORMAT__, elf64
    global GetAVXSupportFlag
    global GetVal
    global SetVal
    global NonAVXAddTab
    global AVXAddTab
%elifidn __OUTPUT_FORMAT__, macho64
    global _GetAVXSupportFlag
    global _GetVal
    global _SetVal
    global _NonAVXAddTab
    global _AVXAddTab
%endif

    section .text
GetAVXSupportFlag:
_GetAVXSupportFlag:
    mov rax, 1
    cpuid
    xor rax, rax
    bt ecx, 28
    adc rax, rax
    ret

GetVal:
_GetVal:
    cmp esi, 0
    jge GetVal_CV
    xor rsi, rsi
GetVal_CV:
    movss xmm0, [rdi + rsi*4]
    ret

SetVal:
_SetVal:
    cmp esi, 0
    jge SetVal_CV
    xor rsi, rsi
SetVal_CV:
    movss [rdi + rsi*4], xmm0
    ret

NonAVXAddTab:
_NonAVXAddTab:
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
_AVXAddTab:
    vmovaps ymm1, [rdi]
    vaddps ymm0, ymm1, [rsi]
    vmovaps [rdx], ymm0
    ret