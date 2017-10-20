[org 0x7c00]		 ; for BIOS to load boot sector to this address.
KERNEL_OFFSET equ 0x1000 ;  The same offset used when linking the kernel

    mov [BOOT_DRIVE], dl ; BIOS sets the boot drive in 'dl' on boot
    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE 
    call print
    call print_nl
	
    call load_kernel ; read the kernel from disk 
    call switch_to_pm ; disable interrupts, load GDT, etc. and jumps to 'BEGIN_PM'
    jmp $ ; Never executed

	
%include "bootsect_print.asm"
%include "hex_print.asm"
%include "disk_bootsect.asm"
%include "gdt.asm"
%include "switch_32bit.asm"

[bits 16]
load_kernel:
    mov bx, HELLO
    call print
    call print_nl

    mov bx, MSG
    call print
    call print_nl

    mov bx, BYE
    call print
    call print_nl

    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ; Read from disk and store in 0x1000
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    call KERNEL_OFFSET ; Give control to the kernel
    jmp $ ; Stay here, if kernel returns the control (does not happen)


;; data
BOOT_DRIVE:
	db 0 ; It is a good idea to store it in memory because 'dl' may get overwritten

MSG_REAL_MODE:
	db "Started in 16-bit Real Mode", 0

MSG_PROT_MODE:
	db "Landed in 32-bit Protected Mode", 0

MSG_LOAD_KERNEL:
	db "Now lets load kernel into memory", 0

HELLO:
	db "Hello, Holberton!", 0

MSG:
	db "Presenting simple OS.", 0

BYE:
	db "Goodbye!", 0
	
;; padding with zeroes
times 510 - ($-$$) db 0
dw 0xaa55 			; boot sector magic number 
