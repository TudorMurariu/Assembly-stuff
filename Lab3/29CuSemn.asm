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
    a db 16
    b dw -9
    c dd 25
    d dq 5
; our code starts here
segment code use32 class=code
    start:
        ; ... (a+a)-(b+b)-(c+d)+(d+d) = 32 -(-18) - 30 + 10 = 30
        mov al , [a]; al = a = 16
        add al , [a]; al = a+a = 32
        cbw         ; ax = a+a = 32
        
        mov bx , ax ; bx = ax = a+a = 32
        mov ax , [b]; ax = b = -9
        add ax , [b]; ax = b+b = -18
        sub bx , ax ; bx = bx - ax = (a+a)-(b+b) = 32 -(-18) = 50
        mov ax , bx ; ax = (a+a)-(b+b) = 50
        cwde        ; eax = (a+a)-(b+b) = 50
        mov ebx , eax ; ebx = eax = (a+a)-(b+b) = 50
        
        mov eax , [c]; eax = c = 25
        cdq          ; edx:eax = c = 25
        add eax , [d]
        adc edx , [d+4]; edx:eax = (c+d) = 30
        
        mov ecx , eax; ecx = eax
        
        mov eax , ebx; eax = ebx = (a+a)-(b+b) 
        
        mov ebx , edx; ebx:ecx = edx:eax = (c+d) = 30
        cdq          ; edx:eax = eax = (a+a)-(b+b) = 50
        sub eax , ecx
        sbb edx , ebx; edx:eax = (a+a)-(b+b)-(c+d) = 20
        
        mov ecx , [d]
        mov ebx , [d+4] ;ebx:ecx = d = 5
        add ecx , [d]
        adc ebx , [d+4]; ebx:ecx = (d+d) = 10
        
        add eax , ecx
        adc edx , ebx; edx:eax = (a+a)-(b+b)-(c+d)+(d+d) = 20+10 = 30
    
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
