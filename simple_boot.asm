mov ah, 0x0e	; text mode for printing with BIOS
[org 0x7c00]	; for  assembler to know that offset is bootsector code

mov bx, HELLO
call print
call print_nl

mov bx, MSG
call print
call print_nl

mov bx, GOODBYE
call print
call print_nl

;;  data
HELLO:
	db 'Hello, Holberton!', 0 ; null terminated string

MSG:
	db 'This is an attempt to build a simple OS for my Year End Project.', 0

GOODBYE:
	db 'Goodbye!', 0

print:
	pusha
start:
	mov al, [bx]	; 'bx' is the base address for the string
	cmp al, 0	; while (string[i] != 0) { print string[i]; i++ }
	je done

	int 0x10	;'al' already contains the char

	add bx, 1	; increment pointer
	jmp start

done:
	popa
	ret

print_nl:
	pusha

	mov al, 0x0a		; new line
	int 0x10
	mov al, 0x0d		; carriage return
	int 0x10

	popa
	ret

;; boot sector program that loops forever
jmp $
times 510-($-$$) db 0
dw 0xaa55
