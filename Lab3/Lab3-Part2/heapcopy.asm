extern init_v
extern init_va
extern pop_v
extern push_v
extern size_v
extern get_element_v
extern resize_v
extern delete_v
extern malloc
extern free

section .data
Debugger1:  db        "Debugger1", 10
Debugger2:  db        "Debugger2", 10
Debugger3:  db        "Debugger3", 10
Debugger4:  db        "Debugger4", 10
Debugger5:  db        "Debugger5", 10

section .text
global init_h
global delete_h
global size_h
global insert_h
global get_max
global pop_max
global heapify
global heapsort

init_h:
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

        call init_v

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

delete_h:
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

        call delete_v

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


size_h:
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

        call size_v
        
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

insert_h:
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
        call push_v
        call size_v
        mov r8, rax   ; Storing size in r8
        dec r8  ; Index of last inserted element
        ;; r8 - stores the index
        mov r9, 0
        mov rdi, 8
        call malloc
        mov r10, rax
        mov rdi, 8
        call malloc
        mov r11, rax

        jmp while

        while:
                cmp r8, 0
                je exit
                ;; Calculating parent(i), where i is r8
                mov [r10], r8 ; r10 = r8
                sub qword [r10], 1     ; r10 = r8 - 1
                mov rax, [r10]
                mov qword [r11], 2  ; r11 stores the divisor
                mov r15, [r11]
                xor rdx, rdx
                div r15
                mov r12, rax  ; Now r12 stores parent(i)
                mov rsi, r12
                mov rdi, r13
                call get_element_v
                mov r14, [rax]  ; Now r14 stores arr[parent(i)]
                mov rsi, r8
                mov rdi, r13
                call get_element_v
                mov r15, [rax]  ; Now r15 stores arr[i]
                cmp r14, r15
                jge exit
                ;; Now we swap arr[parent(i)] and arr[i]
                mov qword [r13 + 8*r8 + 16], r14
                mov qword [r13 + 8*r12 + 16], r15
                mov r8, r12
                jmp while
        
        exit:

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

insert_h2:
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

        mov rbx, rdi
        call push_v
        call size_v
        mov r8, rax   ; Storing size in r8
        dec r8  ; Index of last inserted element
        ;; r8 - stores the index
        mov r9, 0
        mov rdi, 8
        call malloc
        mov r10, rax
        mov rdi, 8
        call malloc
        mov r11, rax

        jmp while2

        while2:
                cmp r8, 0
                je exit2
                ;; Calculating parent(i), where i is r8
                mov [r10], r8 ; r10 = r8
                sub qword [r10], 1     ; r10 = r8 - 1
                mov rax, [r10]
                mov qword [r11], 2  ; r11 stores the divisor
                mov r15, [r11]
                xor rdx, rdx
                div r15
                mov r12, rax  ; Now r12 stores parent(i)
                mov rsi, r12
                mov rdi, r13
                call get_element_v
                mov r14, [rax]  ; Now r14 stores arr[parent(i)]
                mov rsi, r8
                mov rdi, r13
                call get_element_v
                mov r15, [rax]  ; Now r15 stores arr[i]
                cmp r14, r15
                jge exit2
                ;; Now we swap arr[parent(i)] and arr[i]
                mov qword [r13 + 8*r8 + 16], r14
                mov qword [r13 + 8*r12 + 16], r15
                mov r8, r12
                jmp while2
        
        exit2:

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

get_max:
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

        mov rsi, 0   ; For getting the index 0 element
        call get_element_v
        mov rax, [rax]
        ;; Now rax contains the max_element, so done

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

pop_max:
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
        ;call size_v
        ;mov r8, rax  ; Storing the size in r8
        ;mov r9, 1
        ;cmp r8, r9
        ;je exit1     ; This is the base case when heap has 1 element - heapify not required
        mov rdi, r12
        call init_v2
        mov r14, 1   ;; We use r14 as counter, and also a traverser of the vector
        call size_v
        mov r15, rax  ; Size of the vector stored in r15
        
        mov rsi, 0
        mov rdi, r13
        call get_element_v 
        mov r11, [rax]

        push rdi
        push rsi
        mov rax, 1
        mov rdi, 1
        mov rsi, Debugger1
        mov rdx, 10
        syscall
        pop rsi
        pop rdi

        jmp loop

        loop:
                mov rdi, r12
                mov rsi, [r13 + 8*r14 + 16]
                push r14
                push r15
                call insert_h2
                pop r15
                pop r14
                add r14, 1
                cmp r14, r15
                jge exitloop
                jmp loop

        exitloop:
                mov r13, r12
                mov rax, r11

        
        ;mov rsi, 0
        ;mov rdi, r13
        ;call get_element_v 
        ;push qword [rax]  
        ;mov rdi, r13

        ;call pop_v  ; Now rax has the value of the last element
        ;mov qword [r13 + 16], rax



        pop rax
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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;THE CODES BELOW ARE OPTIONAL;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


heapify:
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
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
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

heapsort:
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
        ; ENTER YOUR CODE HERE, DO NOT MODIFY EXTERNAL CODE
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
