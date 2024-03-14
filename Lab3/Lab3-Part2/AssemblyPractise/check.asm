

	global _start

	section .text
	
_start:	push rbx
        push rcx
	mov rbx, 1
	mov rcx, 2
	add rcx, rbx

	mov rax, 1
	mov rdi, 1
	mov rsi, message
	mov rdx, 13
	syscall
	
	mov rax, 1
	mov rdi, 1
	mov rsi, rcx
	mov rdx, 8
	syscall
	
	pop rcx
	pop rbx
	mov rax, 60
	xor rdi, rdi
	syscall

	section .data
message: db "Hello World", 10
