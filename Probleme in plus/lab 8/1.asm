bits 32 
global start        

extern exit,printf,scanf , fopen , fread , fclose         
import exit msvcrt.dll    
import printf msvcrt.dll    
import scanf msvcrt.dll   
import fopen msvcrt.dll  
import fread msvcrt.dll   
import fclose msvcrt.dll 

segment data use32 class=data
    ; ...
    text times 101 db 0
    nume_fisier db "text1.txt",0
    mod_aces db "r",0
    descriptor_fis dd 0
    nr_v dd 0
    len dd 100
    format db "%d",0

segment code use32 class=code
    start:
        ; ...
        ; fopen(nume_fisier,mod_aces)
        push dword mod_aces
        push dword nume_fisier
        call [fopen]
        add esp , 4*2
        
        mov [descriptor_fis] , eax
        
        ; fread(text,1,len,descriptor_fis)
        push dword [descriptor_fis]
        push dword [len]
        push dword 1
        push dword text
        call [fread]
        add esp , 4*4
        
        mov esi , text
        loop1:
            lodsb ; al = esi , inc esi
            
            cmp al , 0
                je out1
            ;esle:
            cmp al , 'a' 
            je vocala
            
            cmp al , 'e' 
            je vocala
            
            cmp al , 'i' 
            je vocala
            
            cmp al , 'o' 
            je vocala
            
            cmp al , 'u' 
            je vocala
            
            jmp continue
            vocala:
            
            mov eax , [nr_v]
            inc eax
            mov [nr_v] , eax
            
            continue:
        jmp loop1
        out1:
        
        ;printf
        push dword [nr_v]
        push dword format
        call [printf]
        add esp , 4*2
        
        ;fclose(descriptor_fis)
        push dword [descriptor_fis]
        call [fclose]
        add esp , 4*1
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
