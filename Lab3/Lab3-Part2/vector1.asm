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
        mov rdi, 24
        call malloc
        mov r13, rax   ; Storing the vector in r13
        pop rdi
        mov r13, rdi

        mov rdi, 400
        call malloc
        mov r15, rax
        syscall
        ;mov r15, 400

        mov qword [r13], 400
        mov qword [r13 + 8], 0
        push r13
        mov r10, 16
        add r13, r10
        mov r13, r15  ; Storing rbx at r13 + 16
        pop r13
        
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

        push rsi
        mov rax, 1
        mov rdi, 1
        mov rsi, Debugger5
        mov rdx, 10
        syscall                
        pop rsi

        mov rdi, r13 ; freeing the register which stored the properties of the vector
        call free

        push rsi
        mov rax, 1
        mov rdi, 1
        mov rsi, Debugger4
        mov rdx, 10
        syscall
        pop rsi

        mov rdi, r15 ; freeing the register storing the elements of the vector
        call free

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
        push r13
        mov r10, 16
        add r13, r10
        mov r15, r13  ; Storing rbx at r13 + 16
        pop r13

        push r15
        imul rsi, 8
        add r15, rsi
        mov rax, qword [r15]
        pop r15
        
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

        mov r9, [r13]      ; The buff_size
        mov r10, [r13 + 8]  ; The size of vector
        cmp r9, r10
        je resize_v
        mov r10, [r13 + 8]  ; The size of vector
        imul r10, 8
        push r15
        add r15, r10
        mov [r15], rsi

        pop r15 ; restoring value of rbx
        inc qword [r13 + 8] ; increasing the size by 1

        push r13
        mov r10, 16
        add r13, r10
        mov r13, r15  ; Storing rbx at r13 + 16
        pop r13

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
        dec qword [r13 + 8] ; decreasing the size by 1
        mov r10, qword [r13 + 8]
        imul r10, 8
        push rbx ; Storing the value of rbx
        add rbx, r10
        mov r9, qword [rbx]  ; Now r9 stores the return value
        mov qword [rbx], 0  ; Just for fun
        pop rbx ; restoring value of rbx
        mov rax, r9 ;  storing the return value in rax

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
        mov rax, qword [r13 + 8]  ; I doubt this, because rax stores address, 
                                  ;but I need to return the size which is an integer
                                  ;So I think the following might work
                                  ;mov r10, qword [r13 + 8]
                                  ;mov [rax], r10 
                                  ;-- All this is most probably wrong

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
