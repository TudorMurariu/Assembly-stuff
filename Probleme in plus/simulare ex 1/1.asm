bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, fopen, fread          ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import fopen msvcrt.dll
import fread msvcrt.dll
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_fisier db "input.txt",0
    mod_aces db "r",0
    descriptor_fis dd -1; aici vom salva descriptorul fisierului - necesar pt a putea face referire la fisier
    len equ 100
    text times (len+1) db 0 ; +1 e pentru null
    Sir_nou times len db -1
    n dd 0
    i db 0
    format db "%d",0
    new_line db 10,0
    space db " ",0
    aux dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;fopen(nume_fisier, mod_aces)
        push dword mod_aces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2 
        
        mov [descriptor_fis] , eax
        
        ;fread(text, 1, len, descriptor_fis)
        push dword [descriptor_fis]
        push dword len
        push dword 1
        push dword text
        call [fread]
        add esp, 4*4 
        
        ;; citim prima linie 
        mov esi , text
        first_loop:
            lodsb ; al = [esi] , inc esi
            cmp al , 10
                je out1
            cmp al , '0'
                jl continue1
            cmp al , '9'
                jg continue1
            ; else
                mov ebx , 0
                mov bl , al
                sub bl , '0'
                
                mov eax , [n]
                mov edx , 10
                mul edx ; edx:eax = n * 10 adica parctic doar eax fiindca n este int
                
                add eax , ebx
                mov [n] , eax
                
            continue1:
        jmp first_loop
        out1:
        
        
        mov ecx , [n]
        mov edi , Sir_nou
        
        loop2:
            lodsb ; al = [esi] , inc esi
            cmp al , ' '
                je space_
            cmp al , '0'
                jl continue2
            cmp al , '9'
                jl add1
            cmp al , 'A'
                jl continue2
            cmp al , 'Z'
                jg continue2
            ;; esle
            add2:
                sub al , 'A'
                add al , 10
                mov bl , [edi]
                cmp bl , -1
                    je prima_cfrA
                cmp bl , al
                    jl continue2
                
                prima_cfrA:
                    mov [edi] , al
                jmp continue2
                
            add1:
                sub al , '0'
                mov bl , [edi]
                cmp bl , -1
                    je prima_cfr0
                cmp bl , al
                    jl continue2
                
                prima_cfr0:
                    mov [edi] , al
                jmp continue2
            space_:
                inc edi
                dec ecx
            continue2:
            jecxz out2
        jmp loop2
        out2:
        
        push dword [n]
        push dword format
        call [printf]
        add esp, 4*2 
        
        push dword new_line
        call [printf]
        add esp , 4
        
        
        mov ecx , [n]
        mov esi , Sir_nou
        
        afisare_loop:
            mov eax , 0 
            lodsb
            mov [aux] , ecx
            
            push dword eax 
            push dword format
            call [printf]
            add esp, 4*2
            
            push dword space
            call [printf]
            add esp, 4*1
            
            mov ecx , [aux]
        loop afisare_loop
        
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
