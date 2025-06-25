section .data
    ; equacao F(n) = F(n-1) + F(n-2)
    ; resultado esperado 0, 1, 1, 2, 3, 5, 8, 13, 21, 34 ...
    result dq 0,
    var1 dq 0,
    var2 dq 0,
section .text
    global _start
_start:
    ; Declaracao 
    mov rax, var1       ; Inicia o registrador com var1
    mov rbx, var2       ; Inicia o registrador com var2
    mov rcx, result     ; Atribui o registrador RCX com o valor de result
    mov rax, result     ; Atribui o valor de result a RAX
    mov rbx, result     ; Atribui o valor de result a RBX
    mov rax, var1       ; Move o valor de var1 para RAX
    mov rbx, var2       ; Move o valor de var2 para RBX
    ; Operacao de parenteses a-1 | a-2
    sub rax, 1          ; -1 
    sub rbx, 2          ; -2 
    mov var1, rax       ; var1 recebe RAX
    mov var2, rbx       ; var2 recebe RBX
    ; Operacoes depois do sinal de igual (result = a + b)
    mov var1, rax       ; RAX recebe var1
    mov var2, rbx       ; RBX recebe var2
    mov rcx, 0          ; Limpa o valor de RCX

    add rcx, rax        ; Soma o valor de com RAX (RCX = RCX + RAX)
    add rcx, rbx        ; Soma o valor de com RBX (RCX = RCX + RBX)

    mov result, rcx     ; result recebe o valor de rcx 
    mov rcx, 0          ; Limpa o valor de RXC

    mul rax, rbx        ; Multiplica RAX por RBX e armazena em RAX
    mov result, rax     ; Armazena RAX em result
    mov rax, 0          ; Limpa RAX
    syscall