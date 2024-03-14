extern init_v
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
        call size_v
        mov r8, rax  ; Storing the size in r8
        mov r9, 1
        cmp r8, r9
        je exit1     ; This is the base case when heap has 1 element - heapify not required
        mov rsi, 0
        mov rdi, r13
        call get_element_v 
        push qword [rax]  
        mov rdi, r13
        call pop_v  ; Now rax has the value of the last element
        mov qword [r13 + 16], rax
        ;; Now we need to perform heapify - we write a recursive function
        mov rdi, r13
        call size_v
        mov r15, rax  ; Storing the size in r15
        mov r8, 0
        jmp rec_heapify
        rec_heapify:
                ;; r8 - i
                ;; r9 - 2*i + 1  - left child
                ;; r10 - 2*i + 2  - right child
                push r8
                imul r8, 2  ; r8 = 2*i
                add r8, 1 ; r8 = 2*i + 1
                mov r9, r8 ; r9 = 2*i + 1
                inc r8 ; r8 = 2*i + 2
                mov r10, r8 ; r10 = 2*i + 2 
                pop r8   ; Restoring value of r8
                ;; We define a variable largest = i
                ;; we store largest in r11
                mov r11, r8
                call check1
                call check2
                ;; Now we do the final check - here only
                cmp r11, r8
                je bye
                ;; Now we need to swap arr[i] with arr[largest]
                mov rsi, r8
                mov rdi, r13
                call get_element_v
                mov r12, [rax]   ; r12 = arr(i)
                mov rsi, r11
                mov rdi, r13
                call get_element_v
                mov r14, [rax]   ; r14 = arr(largest)
                mov qword [r13 + 8*r8 + 16], r14
                mov qword [r13 + 8*r11 + 16], r12
                mov r8, r11
                jmp rec_heapify   ;;;;;; CHECK IF JMP OR CALL - I THINK DOESN'T MATTER
        check1:
                cmp r9, r15
                jge leave
                mov rsi, r9
                mov rdi, r13
                call get_element_v
                mov r12, [rax]   ; r12 = arr(l)
                mov rsi, r8
                mov rdi, r13
                call get_element_v
                mov r14, [rax]   ; r14 = arr(i)
                cmp r12, r14
                jle leave
                mov r11, r9
                ret
        check2:
                cmp r10, r15
                jge leave
                mov rsi, r10
                mov rdi, r13
                call get_element_v
                mov r12, [rax]   ; r12 = arr(r)
                mov rsi, r11
                mov rdi, r13
                call get_element_v
                mov r14, [rax]   ; r14 = arr(largest)
                cmp r12, r14
                jle leave
                mov r11, r10
                ret
        leave:
                ret
        exit1:    
                mov rdi, r13
                call pop_v  ; After this rax stores the return value
        bye:
                ;pop rax
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
