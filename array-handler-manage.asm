;Array Handler - Manage
;Katherine Joy Guardiano, 240-3

; ==== Code Area Start ====
global manage
extern fillarray
extern sumarray
extern display
extern scanf ;for calling the function scanf
extern printf ;for calling the function printf

segment .data
; ==== Data Declarations ====
max_size equ 8 ;8 cells in the array

; ==== Format Declarations ====
prefillmsg db "Enter float numbers separated by white space. After last number, enter white space followed by CTRL+D.", 10, 0
postfillmsg db "Thank you for your input. The numbers received in the array are:", 10, 0
postsummsg db "The total sum of these numbers is %lf.", 10 ,0
asmexitmsg db "Thank you for using the Array Management System.", 10, 0
floatform db "%lf", 0 ;8-byte float format
stringform db "%s", 0 ;string format
testmsg db "This is a test output.", 10, 0

segment .bss
nicearray resq max_size ;max_size acts as a constant

align 64
backuparea resq 832 

segment .text
; ==== Start of Code ====
manage:
; ==== Start of Backup ====
push       rbp                                              ;Save a copy of the stack base pointer
mov        rbp, rsp                                         ;We do this in order to be 100% compatible with C and C++.
push       rbx                                              ;Back up rbx
push       rcx                                              ;Back up rcx
push       rdx                                              ;Back up rdx
push       rsi                                              ;Back up rsi
push       rdi                                              ;Back up rdi
push       r8                                               ;Back up r8
push       r9                                               ;Back up r9
push       r10                                              ;Back up r10
push       r11                                              ;Back up r11
push       r12                                              ;Back up r12
push       r13                                              ;Back up r13
push       r14                                              ;Back up r14
push       r15                                              ;Back up r15
pushf                                                       ;Back up rflags
; ==== End of Backup ====

mov rax, 0
mov rdi, stringform
mov rsi, prefillmsg
call printf

;block to call fill array
mov rax, 0
mov rdi, nicearray ;gives address of array
mov rsi, max_size ;gives maximum size for array
call fillarray
mov rbx, rax ;store num elements read in rbx

mov rax, 0
mov rdi, stringform
mov rsi, postfillmsg
call printf

mov rdi, nicearray
mov rsi, rbx
call display

movsd xmm13, xmm0

mov rax, 0
mov rdi, nicearray
mov rsi, rbx
call sumarray

movsd xmm0, xmm13

mov rax, 1
mov rdi, postsummsg
call printf

mov rax, 0
mov rdi, stringform
mov rsi, asmexitmsg
call printf

movsd xmm0, xmm13
; ==== Start of Restore ====
popf
pop     r15
pop     r14
pop     r13
pop     r12
pop     r11
pop     r10
pop     r9
pop     r8
pop     rdi
pop     rsi
pop     rdx
pop     rcx
pop     rbx
pop     rbp
; ==== End of Restore ====
ret
; ==== End of Code ====