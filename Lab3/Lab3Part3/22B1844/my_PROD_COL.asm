        section .text
        global hadarmard_prod

hadarmard_prod:
        push rdi                       ; pointer to mat1
        push rdx                       ; pointer to mat2
        push r8                        ; pointer to mat3
        push r9                        ; number of rows/ columns of the matrix (n)
        push r11
        push r12
        push r13
        push r14
        push r15


; ; 0-indexing on all matrices
; ; mat1[j][i] = rdi+(r9*j+i)*8
; ; GOAL - Compute hadarmard product of of mat1, mat2 and save the result in mat3
; ; Note : mat1, mat2 and mat3 here are not the same as one given in problem statement.
; ; They are just placeholders for any three matrices using this functionality.

; ; TODO - Fill your code here performing the hadarmard product in the following order
; ; for(int i = 0; i < n; i++){for(int j = 0; j < n; j++){mat3[j][i] = mat1[j][i] * mat2[j][i];}}

        ;; storing i in r11
        ;; storing j in r12

        mov r11, 0
        mov r12, 0

        outer_loop:
                cmp r11, r9
                jge exit
                mov r12, 0
                jmp inner_loop


        inner_loop:
                cmp r12, r9
                jge exit_inner_loop
                push r12
                imul r12, r9
                add r12, r11
                imul r12, 8
                add r12, rdi   ;; r12 stores the address of mat1[j][i]
                mov r13, [r12] ;; r13 stores value of mat1[j][i]
                pop r12

                push r12
                imul r12, r9
                add r12, r11
                imul r12, 8
                add r12, rdx   ;; r12 stores the address of mat2[j][i]
                mov r14, [r12] ;; r14 stores value of mat2[j][i]
                pop r12

                imul r13, r14   ;; r13 <-- mat1[j][i]*mat2[j][i]

                push r12
                imul r12, r9
                add r12, r11
                imul r12, 8
                add r12, r8     ;; r12 stores the address of mat3[j][i]
                mov [r12], r13  ;; storing calculated value in mat3 
                pop r12

                add r12, 1
                jmp inner_loop

        exit_inner_loop:
                add r11, 1
                jmp outer_loop

        exit:


; ; End of code to be filled

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r9
        pop r8
        pop rdx
        pop rdi
        ret
