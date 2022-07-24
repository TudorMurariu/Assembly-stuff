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
    a db -8
    b dw -10
    c dd 52
    d dq 10

; our code starts here
segment code use32 class=code
    start:
        ; ... (c+b)-a-(d+d) = (52-10) - (-8) - (10+10) = 50 - 20 = 30
        mov ax , [b] ; ax = b = -10
        cwd          ; dx:ax = b = -10
        push dx
        push ax
        pop ebx      ; mutaxm in ebx valoarea din dx:ax
        add ebx , [c]; ebx += c = b + c = 42
        mov ecx , 0  ; ecx = 0
        
        
        mov al , [a] ; al = a = -8
        cbw          ; ax = a = -8
        cwde         ; eax = a = -8
        
        sub ebx , eax; ebx = ebx - eax = (c+b) - a = 42 -(-8) = 50
        mov eax , ebx; eax = ebx = 50
        cdq          ; edx:eax = eax = 50
        
        mov ecx , [d]
        mov ebx , [d+4]; ebx:ecx = d = 10
        add ecx , [d]
        adc ebx , [d+4]; ebx:ecx = d+d = 20
    
        ;clc          ; seteaza cf la 0
        sub eax , ecx
        sbb edx , ebx; edx:eax = (c+b)-a-(d+d) = 50 - 20 = 30
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
