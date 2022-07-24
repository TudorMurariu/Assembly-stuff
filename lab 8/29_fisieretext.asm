bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit ,fopen ,fread ,fprintf ,fclose ,printf ,strtok             
; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import fopen msvcrt.dll  
import fclose msvcrt.dll
import fprintf msvcrt.dll
import fread msvcrt.dll
import printf msvcrt.dll
import strtok msvcrt.dll               
;Se da un fisier text. Fisierul contine numere (în baza 10) separate prin spatii. Sa se citeasca continutul ;acestui fisier, sa se determine maximul numerelor citite si sa se scrie rezultatul la sfarsitul fisierului.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    nume_fisier db "problema29.txt", 0 ; numele fisierului care va fi creat
    mod_acces db "a+", 0                                            
    descriptor_fis dd -1; aici vom salva descriptorul fisierului - necesar pt a putea face referire la fisier
    len equ 100                                     
    text times (len+1) db 0 
    max dd -2147483648 ; definim maximul(-2^31)
    format db "%d",0
    linie_noua db 10,0
    lungime_txt dd 0
    auxb db 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ; Descidem fisierul cu modul de acces a+ 
        ; fopen(nume_fisier, mod_acces)
        push dword mod_acces
        push dword nume_fisier
        call [fopen] 
        mov [descriptor_fis], eax        
        add esp, 4*2 
        
        ; Citim textul
        ; fread(text, 1, len, descriptor_fis)
        push dword [descriptor_fis]
        push dword len
        push dword 1
        push dword text        
        call [fread]
        add esp, 4*4
        
        mov dword [lungime_txt] , eax
        
        ; trecem prin fiecare caracter din text
        mov ecx , [lungime_txt]
        mov ebx , 0
        mov esi , text
        
        repeta:
            cmp esi , 0 
        
            ; extragem primul caracter
            mov eax , 0
            mov al , [esi]
            
            ; Verificam daca caracterul este o cifra
            cmp al , '0'
            jl next_number 
            
            cmp al , '9'
            jg next_number 
            
            ; Daca e cifra o adaugam la numar
            sub al , '0'
            
            
            mov [auxb] , al
            mov eax , ebx
            mov dx , 10
            mul dx ; dx:ax = ax*10
            
            mov ebx , edx
            shl ebx , 8 ; facem loc pt ax
            mov bx , ax 
            mov eax , 0
            mov al , [auxb]
            
            add ebx , eax 
            
            jmp continua
            
            next_number:
            
            cmp ebx , [max]
            jle else1
            mov dword[max] , ebx
            else1:
            mov ebx , 0
            
            continua:
            
            add esi , 1
            
            dec ecx
            cmp ecx , 0
            jz afara
        jmp repeta
        
        afara:
        cmp ebx , [max]
        jle continua1
        mov dword[max] , ebx
        continua1:
        
        ; fprintf(descriptor_fis, text)
        push dword linie_noua
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*2
        
        ; fprintf(descriptor_fis, text)
        push dword [max]
        push dword format
        push dword [descriptor_fis]
        call [fprintf]
        add esp, 4*3
        
        ; Afisare
        push dword text
        call [printf]
        add esp, 4*1
        
        push dword linie_noua
        call [printf]
        add esp, 4*1
        
        push dword [max]
        push dword format
        call [printf]
        add esp, 4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
