bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, fopen, fprintf, fclose, printf ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll 
import fopen msvcrt.dll 
import fprintf msvcrt.dll 
import fclose msvcrt.dll 
import printf msvcrt.dll 
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_fisier db "output.txt",0
    mod_aces db "w",0
    dif dd 0
    sum_p dd 0
    sum_i dd 0
    descriptor_fis dd -1; aici vom salva descriptorul fisierului - necesar pt a putea face referire la fisier
    n dd 0
    format db "%d",0
    format_hexa db "%x ",0
    x dd 0
    aux dd 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        ;scanf("%d",&n)
        push dword n
        push dword format
        call [scanf]
        add esp, 4*2
        
        mov ecx, [n]
        citire:
            mov [aux] , ecx
            
            push dword x
            push dword format
            call [scanf]
            add esp, 4*2
            
            mov eax , [x]
            test eax , 01b
            jz par
                ;; impar:
                add [sum_i] , eax
                jmp continue1
            par:
                add [sum_p] , eax
            
            continue1:
            mov ecx , [aux]
        loop citire
        
        ;fopen(nume,mod_aces)
        push dword mod_aces
        push dword nume_fisier
        call [fopen]
        add esp, 4*2
        
        mov [descriptor_fis] , eax
        
        ;fwrite(descriptor_fis,"%d",sum)
        
        push dword [sum_p]
        push dword format_hexa
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*3
        
        push dword [sum_i]
        push dword format_hexa
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*3
        
        mov eax , [sum_p]
        sub eax , [sum_i]
        mov [dif] , eax
        
        push dword [dif]
        push dword format_hexa
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*3
        
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
