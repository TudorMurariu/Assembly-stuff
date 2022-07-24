bits 32 

global start        

extern exit,fopen,fclose,fprintf,scanf,printf            
import exit msvcrt.dll    
import fopen msvcrt.dll
import fprintf msvcrt.dll
import fclose msvcrt.dll
import scanf msvcrt.dll
import printf msvcrt.dll

segment data use32 class=data
    ; ...
    nume_fisier db "output.txt",0
    mod_acces db "w",0
    descriptor_fis dd -1
    format_citire db "%d",0
    format_afisare db "%d ",0
    n resd 1
    x resd 1
    suma dd 0

segment code use32 class=code
    start:
        ; ...
        
        ; deschidem fisierul
        ;fopen(nume_fisier,mod_aces) -> returneaza in eax desc_dis
        push dword mod_acces
        push dword nume_fisier
        call [fopen]
        add esp , 4*2
        
        cmp eax,0 
            je final
            
        mov [descriptor_fis] , eax
        
        ; citim n
        ;scanf(format,&n)
        push dword n
        push dword format_citire
        call [scanf]
        add esp , 4*2
        
        mov ecx , [n]
        
        ; citim intr-un loop toate cele n numere in x pe rand
        loop1:
            push ecx
            
            ;citim un numar in x
            ;scanf(format,&x)
            push dword x
            push dword format_citire
            call [scanf]
            add esp , 4*2
            
            
            mov ebx , [x] ; ebx = [x]
            ; verificam daca x este intre -99 si -111111
            cmp ebx , -99
                jg continue ; daca ebx este mai mare decat -99 sarim la urmatorul numar
            cmp ebx , -111111
                jl continue ; daca ebx este mai mic decat -111111 sarim la urmatorul numar
            
            mov edx , ebx
            ; verificam bitii numarului citit pentru a vedea daca e div cu 4
            and edx , 011b
            cmp edx , 0b
                jne continue
            ;else
                
                ; daca numarul verifica cerintele atuncti il adunam in suma si il scriem in fisier
                add dword[suma] , ebx
            
                
                ; fprintf(descriptor_fis , format , x)
                push dword [x]
                push dword format_afisare
                push dword [descriptor_fis]
                call [fprintf]
                add esp , 4*3
                
            continue:
                
            pop ecx
        loop loop1
        
        ; afisam suma
        push dword [suma]
        push dword format_afisare
        call [printf]
        add esp , 4*2
        
        ; inchidem fisierul 
        ; fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        add esp , 4
        
        final:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
