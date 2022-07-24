bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, fclose, fopen, fprintf , fread , printf ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll  
import fclose msvcrt.dll
import fprintf msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_fisier db "test.txt", 0 ; numele fisierului care va fi creat
    mod_acces db "a+", 0                                            
    descriptor_fis dd -1; aici vom salva descriptorul fisierului - necesar pt a putea face referire la fisier
    len equ 100                                     
    text times (len+1) db 0 
    format db "Am citit %d caractere din fisier. Textul este: %s",0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
       
        
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]   	; returneaza in EAX - descriptorul de fisier
        add esp, 4*2       
        
        mov [descriptor_fis], eax
        
        push dword [descriptor_fis]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4

        push dword text
        push dword eax
        
        push dword format
        call [printf]
        add esp, 4
        
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4

        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack    
        call    [exit]       ; call exit to terminate the program
