# **Repositório de Aprendizado em Assembly** 🖥️  

Este repositório contém exemplos de código **Assembly x86 e x86-64**, desde conceitos básicos até avançados. Inclui:  
- Exemplos para **Windows e Linux**  
- Sintaxe **NASM e MASM**  
- Casos práticos (chamadas de sistema, aritmética, loops, etc.)  
- Noções básicas de **Engenharia Reversa**  

# **Por que criei esse repo?**

Tomei vergonha na cara e quero apreder baixo nível

---

## **📂 Estrutura do Repositório**  

```
Assembly/
│
├── config/
│   ├── Linux.md            # Arquivo de configuração para Linux
│   └── Windows.md          # Arquivo de configuração para Windows
│
├── Markdown/
│   ├── Linux.md            # Cheat Set para pesquisar instruções do Linux
│   └── Windows.md          # Cheat Set para pesquisar instruções do Windows
│   
├── Windows/                # Códigos específicos para Windows (MASM/API calls)
│   ├── hello.asm           # Exemplo básico com MessageBox
│   ├── arithmetic.asm      # Operações matemáticas
│   └── syscalls.asm        # Uso de WinAPI
│
├── Linux/                  # Códigos para Linux (NASM/SYSCALL)
│   ├── hello.asm           # "Hello World" (sys_write)
│   ├── fibonacci.asm       # Cálculo de Fibonacci
│   └── reverse.asm         # Exemplo de engenharia reversa
│   
├── x86/                    # Códigos em 32-bit (modo protegido)
│   └─ bootloader/          # Exemplo simples de bootloader
│       ├── interrupts.asm  # Manipulação de interrupções
│       │
│       ├───stage1/         # Bootloader estágio 1 (16-bit)
│       │   ├── boot.asm    # Código principal do bootloader
│       │   ├── disk.asm    # Rotinas de leitura de disco
│       │   ├── print.asm   # Funções para imprimir na tela
│       │   ├── memory.asm  # Manipulação básica de memória
│       │   └── Makefile    # Para compilação automatizada
│       │
│       ├── stage2/         # Bootloader estágio 2 (32-bit)
│       │   ├── main.asm    # Código principal 32-bit
│       │   ├── gdt.asm     # Configuração da Global Descriptor Table
│       │   ├── a20.asm     # Ativação da linha A20
│       │   ├── pm.asm      # Entrada no modo protegido
│       │   └── Makefile
│       │
│       ├── kernel/         # Kernel mínimo para teste
│       │   ├── kernel.asm  # Kernel básico em 32-bit
│       │   └── link.ld     # Script de linker
│       │
│       └── tools/          # Ferramentas auxiliares
│           ├── makedisk.sh # Script para criar imagem de disco
│           └── qemu-run.sh # Script para executar no QEMU
│
├── x64/                    # Códigos em 64-bit
│   ├── avx.asm             # Instruções AVX (vetorização)
│   └── shellcode.asm       # Shellcode básico
│
├── x32/                    # Códigos 32-bit
│   ├── avx.asm             # Instruções AVX em 32-bit
│   ├── shellcode.asm       # Shellcode 32-bit
│   └── winapi/             # Exemplos de Win32 API
│       ├── messagebox.asm  # Caixa de mensagem básica
│       └── fileio.asm      # Operações com arquivos
│
└── README.md # Este guia
```

---

## **⚙️ Configuração do Ambiente**  

### **🔹 Windows (MASM)**
1. Instale o **Visual Studio** (com suporte a MASM) ou o **MASM32**.
2. Use o `ml64.exe` para compilar:
   ```sh
   ml64 /Fo hello.obj hello.asm
   link /SUBSYSTEM:WINDOWS /ENTRY:main hello.obj
   ```

### **🔹 Linux (NASM)**
1. Instale o NASM:
   ```sh
   sudo apt install nasm
   ```
2. Compile e execute (exemplo 64-bit):
   ```sh
   nasm -f elf64 hello.asm -o hello.o
   ld hello.o -o hello
   ./hello
   ```

---

## **📌 Exemplos Básicos**  

### **1. "Hello World" no Linux (x64)**
```assembly
section .data
    msg db 'Olá, Mundo!', 0xA
    len equ $ - msg

section .text
    global _start

_start:
    mov rax, 1          ; sys_write
    mov rdi, 1          ; stdout
    mov rsi, msg        ; mensagem
    mov rdx, len        ; tamanho
    syscall

    mov rax, 60         ; sys_exit
    xor rdi, rdi        ; status 0
    syscall
```

### **2. MessageBox no Windows (x64)**
```assembly
extrn MessageBoxA: proc
extrn ExitProcess: proc

.data
    titulo db 'Assembly', 0
    msg db 'Olá, Windows!', 0

.code
main proc
    sub rsp, 28h        ; Reserva shadow space

    xor rcx, rcx        ; hWnd = NULL
    lea rdx, msg        ; Texto
    lea r8, titulo      ; Título
    xor r9, r9          ; MB_OK
    call MessageBoxA

    xor rcx, rcx
    call ExitProcess
main endp
end
```

---

## **📚 Recursos para Aprender**  
- [Intel x86 Manual](https://software.intel.com/en-us/articles/intel-sdm)  
- [NASM Tutorial](https://nasm.us/doc/)  
- [Windows API Docs](https://docs.microsoft.com/en-us/windows/win32/api/)  
- [Linux Syscall Table](https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md)  
- [Linux Syscall Simplificada](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)

---

## **🎯 Objetivos do Projeto**  
- [ ] Adicionar exemplos de **SIMD (AVX/SSE)**  
- [ ] Incluir projetos com **interação C/Assembly**  
- [ ] Criar tutoriais de **engenharia reversa**  

---

**Contribuições são bem-vindas!** 👨‍💻  
Se quiser adicionar exemplos ou melhorar os existentes, abra um **PR** ou uma **issue**.  
