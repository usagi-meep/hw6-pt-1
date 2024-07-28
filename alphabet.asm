section .data
	newline db 10		; newline char

section .text
	global _start

_start:
	mov ecx, 26		; start counter at 26
	mov bl, 'A'		; start with char 'A'

print:
	push ecx		; saves value of ecx to top of stack
	push ebx		; saves value of ebx to top of stack
	call character		
	pop ebx			; remove top value from stack, place in ebx
	pop ecx			; remove top value from stack, place in ecx

	call nl

	inc bl			; moves onto next character
	loop print		; auto decrement and jnz

	; Exit
	mov eax, 1
	xor ebx, ebx
	int 0x80

character:
	mov eax, 4		; syscall number for sys_write
	mov ebx, 1		; stdout
	movzx edx, bl		; move char to edx
	int 0x80
	ret			; return to end procedure

nl:
	mov eax, 4		; syscall number for sys_write
	mov ebx, 1		; stdout
	mov edx, [newline]	; loads address of newline char
	int 0x80
	ret			; return to end procedure
