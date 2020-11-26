section .bss

section .data
	
	terminal db '/bin/bash', 0
	argv0 db 'echo', 0
	argv1 db '~/asm', 0
	argv dd argv0, argv1, 0
	buffer times 1024 db 0
	msg db ' Результат: ', 0xA	
	len equ $ - msg
	
section .text

	global _start
	
_start:

	mov eax, 11
	mov ebx, terminal
	mov ecx, argv0
	mov edx, 0
	int 0x80
; Сохранить ввод в buffer
	mov eax, 3
	mov ebx, 2
	mov ecx, buffer
	mov edx, 1024
	int 0x80
; Написать msg
	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, len
	int 0x80
	
	mov eax, 4
	mov ebx, 1
	mov ecx, buffer
	mov edx, 1024
	int 0x80
; Выход		
	mov eax, 1
	mov ebx, 0
	int 0x80
