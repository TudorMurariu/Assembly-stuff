bits 32
global start 

extern exit, printf, scanf
import exit msvcrt.dll
import printf msvcrt.dll
import scanf msvcrt.dll

segment data use32 class=data
    ;...
    a dd 0
    m dd 0
    n dd 0
    format db "%d",0
    format_hexa db " %x",0
    
segment code use32 class=code
    start:
        ;...
        push dword a
        push dword format
        call [scanf]
        add esp , 4*2
        
        push dword m
        push dword format
        call [scanf]
        add esp , 4*2
        
        push dword n
        push dword format
        call [scanf]
        add esp , 4*2
        
        mov eax , [a]
        mov ebx , [m]
        mov ecx , 32
        sub ecx , ebx
        mov ebx , ecx
        
        mov cl , bl
        shl eax , cl
        shr eax , cl
        
        mov ebx , [n]
        mov cl , bl
        shr eax , cl
        
        push dword eax
        push dword eax
        push dword format
        call [printf]
        add esp , 4*2
        
        pop eax
        
        push dword eax
        push dword format_hexa
        call [printf]
        add esp , 4*2
        
        push dword [a]
        push dword format_hexa
        call [printf]
        add esp , 4*2
        
        ;exit
        push dword 0
        call [exit]