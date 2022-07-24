bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a db 10
    b dw 12 
    c dd 50
    d dq 1000  

; our code starts here
segment code use32 class=code
    start:
        ; ... (b+b)+(c-a)+d = 24 + (50 - 10) + 1000 = 1064
        mov ax , [b] ; ax = b 12
        add ax , [b] ; ax = b+b = 24
        mov dx , 0   ; dx:ax = ax = b+b = 24
        
        push dx      
        push ax
        pop ebx      ; mutaxm in ebx valoarea din dx:ax
        
        mov al , [a] ; al = a = 10
        mov ah , 0   ; ax = al = a = 10
        mov dx , 0   ; dx:ax = ax = al = a = 10
        
        push dx
        push ax
        pop ecx      ; mutaxm in ecx valoarea din dx:ax 
        mov eax , ecx; eax = ecx = 10
        mov ecx , [c]; ecx = c = 50
        sub ecx , eax; ecx = c - a = 40
        
        add ebx , ecx; ebx = ebx + ecx = 64
         
        
        mov eax , [d]
        mov edx , [d+4]  ; mutaxm in edx:eax   d-ul
        
        add eax , ebx; eax = ebx + eax
        adc edx , 0  ; edx = edx + ecx + CF
        ; edx:eax = 1064
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
