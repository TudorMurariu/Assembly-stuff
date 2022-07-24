bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit , fclose , fopen , printf ,fread ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll  
import fclose msvcrt.dll
import printf msvcrt.dll
import fread msvcrt.dll
;Se da un fisier text. Sa se citeasca continutul fisierului, sa se contorizeze numarul de consoane si sa se ;afiseze aceasta valoare. Numele fisierului text este definit in segmentul de date.

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_fisier db "problema2.txt", 0 ; numele fisierului care va fi creat
    mod_acces db "r", 0                                            
    descriptor_fis dd -1; aici vom salva descriptorul fisierului - necesar pt a putea face referire la fisier
    len equ 100                                     
    text times (len+1) db 0 ; + 1 pentru null
    format db "Numarul de consoane este : %d",0
    numar_consoane dd 0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ; fopen(nume_fisier, mod_acces)
        push dword mod_acces     
        push dword nume_fisier
        call [fopen]   	; returneaza in EAX - descriptorul de fisier
        add esp, 4*2 
        
        mov [descriptor_fis], eax
        
        ; fread(text, 1, len, descriptor_fis)
        push dword [descriptor_fis]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4
        
        mov ecx , eax
        mov esi , text
        
        repeta:
            LODSB    ; al = [esi] , inc esi
            
            ; Pentru litere mici
            cmp al , 'z'
                jge continue
            ;elif
            cmp al , 'a'
                jle continue
            ;elif
            cmp al , 'e'
                je continue
            ;elif 
            cmp al , 'i'
                je continue
            ;elif 
            cmp al , 'o'
                je continue
            ;elif 
            cmp al , 'u'
                je continue
            ;else
            inc dword[numar_consoane]
            continue:
            
            ; Pentru litere mari
            cmp al , 'Z'
                jge continue1
            ;elif
            cmp al , 'A'
                jle continue1
            ;elif
            cmp al , 'E'
                je continue1
            ;elif 
            cmp al , 'I'
                je continue1
            ;elif 
            cmp al , 'O'
                je continue1
            ;elif 
            cmp al , 'U'
                je continue1
            ;else
            inc dword[numar_consoane]
            continue1:
            
        loop repeta
        
        ; printf("%d",numar_consoane)
        push dword [numar_consoane]
        push dword format
        call [printf]
        
        ; fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        add esp, 4
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
