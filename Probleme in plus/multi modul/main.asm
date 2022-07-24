bits 32 

global start        

extern exit, scanf, printf, gets               
import exit msvcrt.dll    
import scanf msvcrt.dll  
import printf msvcrt.dll    
import gets msvcrt.dll      

extern citire, afisare             
;; Se citeste o propozitie de la tastatura. Sa se numere literele din fiecare cuvant si sa se afiseze aceste numere pe  ;; ecran.
segment data use32 class=data
    ; ...
    format db "%d ",0
    format_string db "%s",10,0
    text times 100 db 0
    nr dd 0
segment code use32 class=code
    start:
        ; ...
        
        push dword text
        call citire
        add esp , 4
        
        
        mov esi , text
        loop1:
            
            lodsb ; al = [esi] , esi++
            cmp al , 0
                je out1
            cmp al , 10
                je out1
            cmp al , ' '
                je afis
            ;; else
                inc dword[nr]
                jmp continue
            afis:
                push dword [nr]
                push dword format
                call afisare
                add esp , 4*2
                mov dword[nr] , 0
            continue:
        jmp loop1
        out1:
        
        cmp dword[nr] , 0
            je ext
        ;;else
            push dword [nr]
            push dword format
            call afisare
            add esp , 4*2
        
        ext:
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
        
        
    
    