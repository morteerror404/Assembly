# **Configuração do Ambiente Assembly para Windows**  

Este guia abrange **3 métodos** para configurar o ambiente de desenvolvimento Assembly no Windows:  

1. **Virtualização (VirtualBox + Linux)** → Ideal para compatibilidade total  
2. **WSL (Windows Subsystem for Linux)** → Leve e integrado ao Windows  
3. **VS Code + Notepad (Puro Windows)** → Sem virtualização  

---

## **1️⃣ VirtualBox + Linux (Recomendado para projetos sérios)**  

### **Passo 1: Instalar o VirtualBox**  
🔹 [Download VirtualBox](https://www.virtualbox.org/)  
🔹 Execute o instalador padrão.  

### **Passo 2: Baixar uma ISO Linux**  
Escolha uma distro (Ubuntu, Debian ou Fedora são boas opções):  
- [Ubuntu](https://ubuntu.com/download/desktop)  
- [Debian](https://www.debian.org/download)  

### **Passo 3: Criar uma Máquina Virtual (VM)**  
1. Abra o **VirtualBox** → **Nova**  
2. Configure:  
   - **Memória RAM**: 2GB+ (recomendado)  
   - **Disco Rígido**: 20GB+ (armazenamento dinâmico)  
3. Inicie a VM e instale o Linux normalmente.  

### **Passo 4: Instalar Ferramentas de Assembly na VM**  
```bash
# Ubuntu/Debian
sudo apt update && sudo apt install -y nasm gcc gdb qemu

# Fedora
sudo dnf install -y nasm gcc gdb qemu

# Arch Linux (se usado)
sudo pacman -S nasm gcc gdb qemu
```

✔ **Pronto!** Agora você pode codar em **NASM** dentro do Linux virtualizado.  

---

## **2️⃣ WSL (Windows Subsystem for Linux)**  

### **Passo 1: Ativar o WSL no Windows**  
1. Abra o **PowerShell como Admin** e execute:  
   ```powershell
   wsl --install
   ```
2. Reinicie o PC.  

### **Passo 2: Instalar uma Distro Linux**  
🔹 Abra a **Microsoft Store** e instale:  
- **Ubuntu** (recomendado)  
- **Debian**  
- **Fedora Remix**  

### **Passo 3: Instalar NASM e Ferramentas**  
Abra o **WSL** (pelo menu Iniciar) e execute:  
```bash
sudo apt update && sudo apt install -y nasm gcc gdb
```

✔ **Pronto!** Agora você pode codar em **NASM** dentro do WSL.  

---

## **3️⃣ VS Code + Notepad (Sem Virtualização)**  

### **Passo 1: Instalar o NASM no Windows**  
1. Baixe o **NASM para Windows**:  
   🔹 [nasm.us/download](https://www.nasm.us/pub/nasm/releasebuilds/)  
2. Extraia e adicione ao **PATH** (variáveis de ambiente).  

### **Passo 2: Instalar o MinGW (GCC para Windows)**  
1. Baixe o **MinGW**:  
   🔹 [mingw-w64.org/doku.php/download](https://mingw-w64.org/doku.php/download)  
2. Instale e adicione `gcc` ao **PATH**.  

### **Passo 3: Configurar o VS Code (Opcional)**  
1. Instale o **VS Code**:  
   🔹 [code.visualstudio.com](https://code.visualstudio.com/)  
2. Extensões recomendadas:  
   - **x86 and x86_64 Assembly**  
   - **Code Runner** (para executar scripts)  

### **Passo 4: Testar o Ambiente**  
Crie `hello.asm`:  
```nasm
section .data
    msg db 'Hello, Windows!', 0

section .text
    global _start

_start:
    ; syscall para escrever (Linux-style, não funciona no Windows puro)
    ; (Apenas para WSL ou VirtualBox)
    mov eax, 4
    mov ebx, 1
    mov ecx, msg
    mov edx, 15
    int 0x80

    ; Exit
    mov eax, 1
    int 0x80
```
Compile e execute (no **WSL** ou **VirtualBox**):  
```bash
nasm -f elf32 hello.asm && ld -m elf_i386 hello.o -o hello && ./hello
```

---

## **📌 Comparação dos Métodos**  

| Método               | ✅ Vantagens                     | ❌ Desvantagens                  |  
|----------------------|----------------------------------|----------------------------------|  
| **VirtualBox + Linux** | ✅ Total compatibilidade        | ❌ Consome mais RAM/CPU          |  
| **WSL**               | ✅ Integrado ao Windows         | ❌ Não roda código nativo Windows|  
| **VS Code + Notepad** | ✅ Sem virtualização            | ❌ Limitado (sem syscalls Linux) |  

---

## **🔧 Qual Escolher?**  
- **Quer compatibilidade total?** → **VirtualBox**  
- **Quer algo leve?** → **WSL**  
- **Só quer brincar?** → **VS Code + Notepad**  

Pronto! Agora você pode codar em **Assembly** no Windows da melhor forma possível. 🚀