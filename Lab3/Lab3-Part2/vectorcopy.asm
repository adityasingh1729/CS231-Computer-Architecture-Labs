extern realloc
extern free
extern malloc

section .data
Debugger1:  db        "Debugger1", 10
Debugger2:  db        "Debugger2", 10
Debugger3:  db        "Debugger3", 10
Debugger4:  db        "Debugger4", 10
Debugger5:  db        "Debugger5", 10

;mov rax, 1
;mov rdi, 1
;mov rsi, Debugger5
;mov rdx, 10
;syscall

section .text
global init_v
global delete_v
global resize_v
global get_element_v
global push_v
global pop_v
global size_v

init_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8   
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15

        push rdi
        mov rdi, 1000000000
        call malloc
        mov r13, rax   ; Storing the vector in r13
        pop rdi
        mov r13, rdi

        mov qword [r13], 1000000000
        mov qword [r13 + 8], 0
        
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

init_va:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8   
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15

        push rdi
        mov rdi, 1000000000
        call malloc
        mov r12, rax   ; Storing the vector in r13
        pop rdi
        mov r12, rdi

        mov qword [r12], 1000000000
        mov qword [r12 + 8], 0
        
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

delete_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15

        mov r13, rdi
        ;mov rdi, r13
        ;call free

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

resize_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15

        mov r13, rdi

        mov r8, qword [r13] ; Storing original buffer size in r8
        imul r8, 2
        inc r8   ; now r8 stores the new size of the reallocated array
        mov rdi, r15
        mov rsi, r8
        call realloc
        mov r15, rax
        mov qword [r13], r8

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

get_element_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15

        mov r13, rdi
        imul rsi, 8
        push r13
        add r13, 16
        add r13, rsi
        mov rax, r13
        pop r13
        ;mov rax, [r13 + 8*rsi + 16]
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

push_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15

        mov r13, rdi

        ;mov r9, [r13]      ; The buff_size
        ;mov r10, [r13 + 8]  ; The size of vector
        ;cmp r9, r10
        ;je resize_v
        mov r10, [rdi + 8]  ; The size of vector
        mov [r13 + r10*8 + 16], rsi
        inc qword [r13 + 8] ; increasing the size by 1
        mov rdi, r13

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

pop_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
   
        mov r13, rdi
        add qword [r13+8], -1
        ; dec qword [r13 + 8] ; decreasing the size by 1
        mov r10, qword [r13 + 8]
        mov r9, qword [r13 + 8*r10 + 16]  ; Now r9 stores the return value
        mov rax, r9
        mov qword [r13 + 8*r10 + 16], 0
        ;mov rax, r9 ;  storing the return value in rax
        ; mov rax, [rax]  

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret

size_v:
        push rbp
        mov rbp, rsp
        push rax
        push rbx
        push rcx
        push rdx
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        
        mov r13, rdi
        mov rax, qword [r13 + 8]

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rdx
        pop rcx
        pop rbx
        mov rsp, rbp
        pop rbp
        ret
