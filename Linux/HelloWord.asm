section .data
mystring db "Hello Word", 0xA
len equ $ - mystring

section .text
global _start
_start:

mov rax, 1 ; syscal number para write
mov rdi, 1 ; so uma saida de leitura
mov rsi, mystring ; endereco da string
mov rdx, len ; leitura da len (leitura do tamanho da string)
syscall

mov rax, 60 ; chamada de exit
xor rdi, rdi ; colocando 0 dentro de RDI
syscall