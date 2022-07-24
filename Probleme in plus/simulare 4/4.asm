bits 32 

global start        

extern exit,scanf,fopen,fprintf,fclose,printf
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                   
import scanf msvcrt.dll
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import printf msvcrt.dll
                   
segment data use32 class=data
    ; ...
    nume_fisier db "output.txt",0
    descriptor_fis dd -1
    mod_acces db "w",0
    x resd 1
    r dq 0
    format_citire db "%d",0
    format_afisare db "%d ",0
    maxim dd 0
    minim dd 100000
    
segment code use32 class=code
    start:
        ; ...
        
        ;deschidem fisierul
        ;fopen(nume_fisier,mod_acces) RETURNEAZXA IN EAX descriptor_fis
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp , 4*2
        
        cmp eax , 0
            je final
            
        mov [descriptor_fis] , eax
        
        loop1:
            push dword x
            push dword format_citire
            call [scanf]
            add esp , 4*2
            
            mov eax , [x]
            cmp eax , -1
                je afara
            
            cmp eax , [maxim]
                jg schimb_max
            cmp eax , [minim]
                jl schimb_min
            jmp continua
            schimb_max:
                mov [maxim] , eax
                jmp continua
            schimb_min:
                mov [minim] , eax
                
            continua:
        jmp loop1
        afara:
        
        ;fprintf(descriptor_fis,format_afisare,maxim)
        push dword [maxim]
        push dword format_afisare
        push dword [descriptor_fis]
        call [fprintf]
        add esp , 4*3
        
        ;fprintf(descriptor_fis,format_afisare,minim)
        push dword [minim]
        push dword format_afisare
        push dword [descriptor_fis]
        call [fprintf]
        add esp , 4*3
        
        mov eax , [maxim]
        mov ebx , [minim]
        
        imul ebx ; edx:eax = eax*ebx , r e de tip quad
        mov [r + 0] , eax
        mov [r + 4] , edx
        
        ;push dword eax
        ;push dword format_afisare
        ;push dword [descriptor_fis]
        ;call [fprintf]
        ;add esp , 4*3
        
        ;fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
