section .data
    ; resultado esperado 1, 1, 2, 3, 5, 8, 13, 21, 34 ...
    result dq 0,
    len equ $ - result,

section .text
    global _start
_start:
    mov rax, 1              ; Adiciona 1 a RAX
    mov rbx, 1              ; Adiciona 1 a RBX
    mov rcx, 1              ; Adiciona 1 a RCX

    inc rcx, 0  ; altere aqui para mostrar X lugares da sequencia 

    call calc 
    syscall 
calc: 
    ; 1 + 1 = Result 
    add result, rax         ; Result =+ rax 
    add result, rbx         ; Result =+ rbx
    mov rax, result         ; rax = result (2)
    inc rax, rbx            ; rax = rax + rbx ==> 2 + 1 = 3 
    call print
    mov result, 0           ; result = 0 
    inc result, rax         ; result = rax ==> 0 + 3
    dec rcx, 1 
    JE rcx, 0
    loopne calc
    jmp sair 
    ret 

print: 
    mov rdi, 1              ; stdout
    mov rsi, result         ; endereço da mensagem
    mov rdx, len            ; tamanho da mensagem
    ret

sair:
    mov rax, 60             ; Syscall sair
    xor rdi, rdi
    ret 