        section .text
        global  alt_sum

alt_sum:
        push rdi                       ; pointer to mat
        push rdx                       ; number of rows/ columns of the matrix (n)
        push r11
        push r12
        push r13
        push r14
        push r15
        
; ; 0-indexing on all matrices
; ; mat1[j][i] = rdi+(r9*j+i)*8
; ; GOAL - Perform matrix alternate summation of elements in matrix and return the sum

; ; TODO - Fill your code here performing the matrix alternate summation in the following order
; ; for(int i = 0; i < n; i++){for(int j = 0; j < n; j++){sum += (-1)^(i+j)*mat1[i][j];}}

        ;; storing i in r11
        ;; storing j in r12
        ;; storing the sum in r14
        ;; storing (-1)^(i+j) in r15

        mov r11, 0
        mov r12, 0
        mov r14, 0
        mov r15, 1  ;; i = j = 0
                    ;; value of r15 has to change only when value of i or j changes
                    ;; so we change r15 when we do i++ or j++
                    ;; because it is equivalent to multiplying r15 by -1


        outer_loop:
                cmp r11, r9
                jge exit
                mov r12, 0
                jmp inner_loop


        inner_loop:
                cmp r12, r9
                jge exit_inner_loop
                push r11
                imul r11, r9
                add r11, r12
                imul r11, 8
                add r11, rdi   ;; r12 stores the address of mat[j][i]
                mov r13, [r11] ;; r13 stores value of mat[j][i]
                pop r11

                imul r13, r15  ;; r13 <-- (-1)^(i+j)*mat[j][i]
                add r14, r13

                add r12, 1   ;; j++
                imul r15, -1 ;; modifying (-1)^(i + j)
                jmp inner_loop

        exit_inner_loop:
                add r11, 1   ;; i++
                imul r15, -1 ;; modifying (-1)^(i + j)
                jmp outer_loop

        exit:
                mov rax, r14

; ; End of code to be filled

        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop rdx
        pop rdi
        ret
