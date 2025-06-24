# Manual de Referência: Assembly x86-64

Este README fornece uma visão geral das principais instruções do Assembly para arquitetura x86-64 (64 bits).

## 📌 Registradores Principais (64-bit)

### Registradores de Propósito Geral
| Registrador | Uso Principal               |
|-------------|-----------------------------|
| RAX         | Acumulador, valor de retorno|
| RBX         | Registro base               |
| RCX         | Contador (loops)            |
| RDX         | Dados/extensão              |
| RSI         | Ponteiro de origem          |
| RDI         | Ponteiro de destino         |
| RBP         | Ponteiro da base da pilha   |
| RSP         | Ponteiro do topo da pilha   |
| R8-R15      | Registros adicionais 64-bit |

### Registradores de Segmento
- CS (Code Segment)
- DS (Data Segment)
- SS (Stack Segment)
- ES, FS, GS (Segmentos extras)

## 🔧 Instruções Básicas

### Manipulação de Dados
| Instrução | Exemplo           | Descrição                     |
|-----------|-------------------|-------------------------------|
| MOV       | `MOV RAX, RBX`    | Copia valor entre registradores|
| LEA       | `LEA RAX, [RBX]`  | Carrega endereço efetivo       |
| XCHG      | `XCHG RAX, RBX`   | Troca valores                 |

### Aritméticas
| Instrução | Exemplo           | Descrição                     |
|-----------|-------------------|-------------------------------|
| ADD       | `ADD RAX, 5`      | Soma                          |
| SUB       | `SUB RBX, RCX`    | Subtrai                       |
| MUL       | `MUL RDX`        | Multiplica (unsigned)         |
| IMUL      | `IMUL RBX`       | Multiplica (signed)           |
| DIV       | `DIV RCX`        | Divide (unsigned)             |
| IDIV      | `IDIV R8`        | Divide (signed)               |
| INC       | `INC RAX`        | Incrementa                    |
| DEC       | `DEC RBX`        | Decrementa                    |
| NEG       | `NEG RAX`        | Negação (two's complement)    |

### Lógicas e Bitwise
| Instrução | Exemplo           | Descrição                     |
|-----------|-------------------|-------------------------------|
| AND       | `AND RAX, RBX`    | AND lógico                    |
| OR        | `OR RAX, 0xFF`    | OR lógico                     |
| XOR       | `XOR RAX, RAX`    | XOR lógico                    |
| NOT       | `NOT RCX`         | NOT lógico                    |
| SHL/SAL   | `SHL RAX, 2`      | Shift left                    |
| SHR       | `SHR RBX, 3`      | Shift right (unsigned)        |
| SAR       | `SAR RCX, 1`      | Shift right (signed)          |

## 🏗️ Controle de Fluxo

### Saltos
| Instrução | Condição                  |
|-----------|---------------------------|
| JMP       | Incondicional             |
| JE/JZ     | Igual/Zero                |
| JNE/JNZ   | Diferente/Não zero        |
| JG/JNLE   | Maior (signed)            |
| JGE/JNL   | Maior ou igual (signed)   |
| JA/JNBE   | Acima (unsigned)          |
| JAE/JNB   | Acima ou igual (unsigned) |
| JL/JNGE   | Menor (signed)            |
| JLE/JNG   | Menor ou igual (signed)   |
| JB/JNAE   | Abaixo (unsigned)         |
| JBE/JNA   | Abaixo ou igual (unsigned)|

### Chamadas e Retornos
| Instrução | Exemplo           | Descrição                     |
|-----------|-------------------|-------------------------------|
| CALL      | `CALL função`     | Chama subrotina               |
| RET       | `RET`             | Retorna de subrotina          |

## 📦 Manipulação da Pilha

| Instrução | Exemplo           | Descrição                     |
|-----------|-------------------|-------------------------------|
| PUSH      | `PUSH RAX`        | Empilha                       |
| POP       | `POP RBX`         | Desempilha                    |
| PUSHF     | `PUSHF`           | Empilha FLAGS                 |
| POPF      | `POPF`            | Desempilha FLAGS              |

## 🔄 Strings

| Instrução | Exemplo           | Descrição                     |
|-----------|-------------------|-------------------------------|
| MOVSB     | `MOVSB`           | Move byte [RSI] → [RDI]       |
| MOVSW     | `MOVSW`           | Move word                     |
| MOVSD     | `MOVSD`           | Move dword                    |
| MOVSQ     | `MOVSQ`           | Move qword                    |
| CMPSB     | `CMPSB`           | Compara bytes                 |
| SCASB     | `SCASB`           | Escaneia string               |
| LODSB     | `LODSB`           | Carrega byte em AL            |
| STOSB     | `STOSB`           | Armazena byte de AL           |

## 🛡️ Controle do Sistema

| Instrução | Exemplo           | Descrição                     |
|-----------|-------------------|-------------------------------|
| SYSCALL   | `SYSCALL`         | Chamada de sistema (Linux)    |
| SYSENTER  | `SYSENTER`        | Chamada rápida de sistema     |
| SYSEXIT   | `SYSEXIT`         | Retorno rápido de sistema     |
| INT       | `INT 0x80`        | Interrupção (32-bit)          |

## 🔄 Controle de Loop

| Instrução | Exemplo           | Descrição                     |
|-----------|-------------------|-------------------------------|
| LOOP      | `LOOP label`      | Decrementa RCX e salta se ≠0  |
| LOOPE     | `LOOPE label`     | Salta se igual e RCX≠0        |
| LOOPNE    | `LOOPNE label`    | Salta se diferente e RCX≠0    |

## 🛠️ Instruções Avançadas

| Instrução | Descrição                     |
|-----------|-------------------------------|
| CPUID     | Identificação do processador  |
| RDTSC     | Lê contador de tempo          |
| XSAVE     | Salva estado estendido        |
| XRSTOR    | Restaura estado estendido     |
| PCLMUL    | Multiplicação carry-less      |
| AESENC    | Criptografia AES              |

## 📝 Convenção de Chamada (System V AMD64 ABI)

- **Primeiros 6 argumentos**: RDI, RSI, RDX, RCX, R8, R9
- **Retorno**: RAX (e RDX para valores de 128 bits)
- **Registros preservados**: RBX, RBP, R12-R15
- **Registros voláteis**: RAX, RCX, RDX, RSI, RDI, R8-R11

## 🔍 Exemplo Básico (Linux)

```assembly
section .data
    msg db 'Hello, x86-64!', 0xA
    len equ $ - msg

section .text
    global _start

_start:
    ; write(1, msg, len)
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, msg        ; endereço da mensagem
    mov rdx, len        ; tamanho da mensagem
    syscall

    ; exit(0)
    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; status 0
    syscall
```

## 📚 Recursos para Aprender Mais

1. [Intel x86-64 Manual](https://software.intel.com/en-us/articles/intel-sdm)
2. [AMD64 Architecture Manual](https://developer.amd.com/resources/developer-guides-manuals/)
3. NASM Manual: https://www.nasm.us/doc/
4. GAS (GNU Assembler) Manual

Atualizado: 2023 (para NASM em sistemas Linux x86-64)