bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit , printf, scanf ,strtok ,strlen       ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll
import strtok msvcrt.dll 
import strlen msvcrt.dll

segment data use32 class=data
    ; ...
    
    format db "%b",0
    format_ db "%d",0

segment code use32 class=code
    start:
        ; ...
        push dword eax
        push dword format
        call [scanf]
        add esp , 4*2
        
        push dword eax
        push dword format_
        call [printf]
        add esp , 4*2
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
             