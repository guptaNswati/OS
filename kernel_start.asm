[bits 32]
[extern main] ; Define calling point, must be same name as kernel.c 'main' function
call main ; Calls the C function.
jmp $
