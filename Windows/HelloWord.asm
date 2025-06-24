.DATA
mystring db "Hello Word", 0
len equ $ - mystring - 1
.CODE 
main PROC 
    ; Reserva shadow space (32 bytes) + 8 para alinhamento
    sub rsp, 28h            ; 32 (shadow space) + 8 (alinhamento) = 40 (28h)
    
    ; Obter handle de saída padrão
    mov rcx, -11            ; STD_OUTPUT_HANDLE
    call GetStdHandle
    
    ; Escrever no console
    mov rcx, rax            ; handle
    lea rdx, mystring       ; buffer
    mov r8, len             ; length (sem o terminador nulo)
    xor r9, r9              ; lpNumberOfBytesWritten (NULL)
    push qword 0            ; lpOverlapped (NULL) - 5º parâmetro
    call WriteFile
    add rsp, 8              ; Remove o parâmetro da stack (opcional aqui)
    
    ; Sair do programa
    xor ecx, ecx            ; exit code 0
    call ExitProcess
    
    ; Nunca alcançado
    add rsp, 28h            
    ret
main ENDP

; EU NÃO GOSTEI NENHUM POUCO DE FAZER ESSA ABERRAÇÃO