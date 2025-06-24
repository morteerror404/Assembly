# Manual de Referência: Assembly x86-64 para Windows

Este README fornece uma visão geral das principais instruções e convenções específicas para programação Assembly x86-64 no Windows.

## 📌 Registradores e Convenções do Windows x64

### Registradores Principais (64-bit)
| Registrador | Uso no Windows ABI          |
|-------------|-----------------------------|
| RAX         | Valor de retorno            |
| RCX         | 1º parâmetro                |
| RDX         | 2º parâmetro                |
| R8          | 3º parâmetro                |
| R9          | 4º parâmetro                |
| R10, R11    | Voláteis                    |
| RBX, RBP    | Não voláteis (preservados)  |
| RDI, RSI    | Não voláteis                |
| R12-R15     | Não voláteis                |
| RSP         | Ponteiro de pilha           |
| XMM0-XMM3   | Parâmetros de ponto flutuante|

## 🔧 Instruções Básicas para Windows

### Configuração Inicial (MASM)
```assembly
; Exemplo de estrutura básica para Windows
.CODE
main PROC
    ; Seu código aqui
    ret
main ENDP
END
```

### Chamadas de Sistema no Windows
No Windows, use a API do Windows em vez de syscall diretamente:

```assembly
; Exemplo: MessageBoxA
extern MessageBoxA: PROC
extern ExitProcess: PROC

.DATA
    msg db 'Hello Windows x64!', 0
    title db 'Assembly', 0

.CODE
main PROC
    sub rsp, 28h        ; Shadow space (32 bytes) + 8 para alinhamento
    
    ; MessageBoxA(NULL, msg, title, MB_OK)
    xor rcx, rcx        ; hWnd = NULL
    lea rdx, msg        ; LPCSTR lpText
    lea r8, title       ; LPCSTR lpCaption
    xor r9, r9          ; uType = MB_OK
    call MessageBoxA
    
    ; ExitProcess(0)
    xor rcx, rcx        ; uExitCode = 0
    call ExitProcess
    
    add rsp, 28h        ; Restaura a pilha
    ret
main ENDP
END
```

## 🏗️ Convenção de Chamada (Microsoft x64 ABI)

1. **Primeiros 4 parâmetros**: RCX, RDX, R8, R9 (inteiros), XMM0-XMM3 (ponto flutuante)
2. **Parâmetros adicionais**: Empilhados da direita para a esquerda
3. **Shadow space**: 32 bytes reservados na pilha (mesmo para funções com <4 parâmetros)
4. **Alinhamento**: RSP deve ser 16-byte alinhado antes de CALL
5. **Registros preservados**: RBX, RBP, RDI, RSI, R12-R15, XMM6-XMM15

## 📦 Manipulação da Pilha no Windows

```assembly
; Alocação de espaço para variáveis locais
sub rsp, 20h        ; Aloca 32 bytes (shadow space) + espaço adicional se necessário

; Acesso a parâmetros na pilha
mov rax, [rsp+30h]  ; 5º parâmetro (considerando shadow space)

; Liberação de espaço
add rsp, 20h
```

## 🔍 Exemplo Completo (MASM com API do Windows)

```assembly
; ml64 hello.asm /link /entry:main /subsystem:windows kernel32.lib user32.lib

extrn MessageBoxA: PROC
extrn ExitProcess: PROC

.data
    msg db 'Hello from Windows x64 Assembly!', 0
    caption db 'Assembly Program', 0

.code
main PROC
    ; Reserva shadow space + alinhamento
    sub rsp, 28h
    
    ; Chama MessageBoxA
    xor rcx, rcx        ; hWnd = NULL
    lea rdx, msg        ; Texto
    lea r8, caption     ; Título
    xor r9, r9          ; MB_OK (0)
    call MessageBoxA
    
    ; Chama ExitProcess
    xor rcx, rcx        ; Código de saída 0
    call ExitProcess
    
    ; Nunca chegará aqui
    add rsp, 28h
    ret
main ENDP
END
```

## 🛠️ Ferramentas para Windows

1. **MASM** (Microsoft Macro Assembler) - Incluído no Visual Studio
2. **ML64.EXE** - Compilador MASM para x64
3. **Link.exe** - Linkeditor da Microsoft
4. **Dumpbin.exe** - Para inspecionar arquivos objetos
5. **WinDbg** - Depurador da Microsoft

## 📝 Como Compilar e Ligar

1. Salve o código como `hello.asm`
2. Abra o "x64 Native Tools Command Prompt" do Visual Studio
3. Compile:
   ```
   ml64 hello.asm /link /entry:main /subsystem:windows kernel32.lib user32.lib
   ```

## 🚀 Instruções SSE/AVX (Comuns no Windows)

| Instrução | Descrição                     | Exemplo                     |
|-----------|-------------------------------|-----------------------------|
| MOVAPS    | Move alinhado packed single   | `MOVAPS XMM0, [RCX]`        |
| ADDPS     | Soma packed single            | `ADDPS XMM0, XMM1`          |
| MULPD     | Multiplica packed double      | `MULPD XMM2, XMM3`          |
| VINSERTF128 | Insere 128-bit em YMM        | `VINSERTF128 YMM0, XMM1, 1` |
| AESENC    | Criptografia AES              | `AESENC XMM0, XMM1`         |

## 📚 Recursos Específicos para Windows

1. [Microsoft x64 Calling Convention](https://docs.microsoft.com/en-us/cpp/build/x64-calling-convention)
2. [MASM Reference](https://docs.microsoft.com/en-us/cpp/assembler/masm/microsoft-macro-assembler-reference)
3. [Windows API Documentation](https://docs.microsoft.com/en-us/windows/win32/api/)
4. [Win64 Programming Tutorials](https://www.agner.org/optimize/)

Lembre-se que no Windows x64:
- Não há suporte para INT 0x80 (use API do Windows)
- A pilha deve ser mantida alinhada em 16 bytes
- Shadow space é obrigatório para chamadas de função
- A maioria das APIs usa convenção stdcall (CALLEE cleanup)