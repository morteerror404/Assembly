# **Configuração do Ambiente Linux para Assembly** 🐧

Aqui está um guia completo para configurar o ambiente de desenvolvimento Assembly nas principais distribuições Linux:

## 📋 **Pré-requisitos Comuns**
- Terminal com acesso root (sudo)
- Gerenciador de pacotes da sua distro
- 100MB de espaço livre

## 🛠️ **Configuração por Distribuição**

### **1. Debian/Ubuntu (apt)**
```bash
# Atualizar sistema
sudo apt update && sudo apt upgrade -y

# Instalar dependências
sudo apt install -y nasm gcc gdb make ld binutils git

# Opcional: QEMU para emulação
sudo apt install -y qemu qemu-system-x86

# Verificar instalação
nasm -v && gdb --version
```

### **2. Arch Linux (pacman)**
```bash
# Atualizar sistema
sudo pacman -Syu

# Instalar pacotes essenciais
sudo pacman -S --noconfirm nasm gcc gdb make binutils git

# Para emulação
sudo pacman -S --noconfirm qemu-full

# Verificar
nasm -v
```

### **3. Fedora (dnf)**
```bash
# Atualizar sistema
sudo dnf update -y

# Instalar ferramentas
sudo dnf install -y nasm gcc gdb make binutils git

# QEMU
sudo dnf install -y qemu qemu-kvm

# Verificar
rpm -q nasm gcc
```

### **4. Gentoo (emerge)**
```bash
# Atualizar sistema
emerge --sync

# Instalar pacotes (pode demorar)
sudo emerge -av dev-lang/nasm sys-devel/gcc sys-devel/gdb sys-devel/make sys-devel/binutils dev-vcs/git

# Para QEMU
sudo emerge -av app-emulation/qemu

# Verificar
equery list nasm gcc
```

## 🔧 **Configuração Adicional para Todas as Distros**

### **1. Editor de Código Recomendado**
```bash
# VS Code (todas as distros)
curl -L https://aka.ms/install-vscode-linux.sh | sh
code --install-extension maziac.asm-code-lens
```

### **2. Configurar Aliases Úteis**
Adicione ao seu `~/.bashrc` ou `~/.zshrc`:
```bash
# Aliases para Assembly
alias asmrun='nasm -f elf32 $1.asm && ld -m elf_i386 $1.o -o $1 && ./$1'
alias asmdebug='nasm -f elf32 -g $1.asm && ld -m elf_i386 -g $1.o -o $1 && gdb $1'
```

### **3. Testar Ambiente**
Crie `test.asm`:
```nasm
section .text
global _start

_start:
    mov eax, 1        ; sys_exit
    mov ebx, 42       ; status
    int 0x80
```

Compile e execute:
```bash
nasm -f elf32 test.asm && ld -m elf_i386 test.o -o test && ./test
echo $?  # Deve retornar 42
```

## 🌐 **Links Úteis**
- [NASM Manual](https://nasm.us/doc/)
- [Syscall Table](https://chromium.googlesource.com/chromiumos/docs/+/master/constants/syscalls.md)
- [GDB Cheat Sheet](https://darkdust.net/files/GDB%20Cheat%20Sheet.pdf)

## ⚠️ **Problemas Comuns**
- **Erro de permissão**: Use `chmod +x` nos scripts
- **Falta de dependências**: Verifique mensagens de erro do gerenciador de pacotes
- **Arquitetura errada**: Use `-f elf64` para 64-bit ou `-f elf32` para 32-bit

Pronto! Seu ambiente está configurado para começar a programar em Assembly no Linux. 🚀