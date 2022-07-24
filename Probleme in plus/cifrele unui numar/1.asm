bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf,scanf              
import exit msvcrt.dll 
import printf msvcrt.dll 
import scanf msvcrt.dll    

segment data use32 class=data
    ; ...
    n dd 123
    aux dd 0
    format_afis db "%d",10,0
    format_citire db "%d",0

; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword n
        push dword format_citire
        call [scanf]
        add esp, 4 * 2 
        
        push dword [n]
        push dword format_afis
        call [printf]
        add esp, 4 * 2 
        
        
        mov eax, [n]
        
        loop1:
            cmp eax , 0
            je out1
            cmp eax , 10
            jb afis2
            
            mov edx , 0
            push eax 
            pop ax
            pop dx
            
            mov bx , 10
            div bx
            
            mov ebx , 0
            mov bx , ax
            mov eax , 0
            mov eax , ebx
            mov [aux] , eax
            
            push dword edx
            push dword format_afis
            call [printf]
            add esp, 4 * 2 
            jmp continue
            afis2:
            
            push dword eax
            push dword format_afis
            call [printf]
            add esp, 4 * 2 
            jmp out1
            continue:
            mov eax , [aux]
        
        jmp loop1
        out1:
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
