bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, scanf, printf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import scanf msvcrt.dll
import printf msvcrt.dll
;Se da un numar natural a (a: dword, definit in segmentul de date). Sa se citeasca un numar natural b si sa se ;calculeze: a + a/b. Sa se afiseze rezultatul operatiei. Valorile vor fi afisate in format decimal (baza 10) cu semn.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a resd 1
    b resd 1
    sum resd 1
    format db "%d",0
    citire_a db "a = ",0
    citire_b db "b = ",0
    plus db " + ",0
    egal db " = ",0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        push dword citire_a
        call [printf]
        
        ;scanf("%d",&a)
        push dword a
        push dword format
        call [scanf]
        
        push dword citire_b
        call [printf]
        
        push dword b
        push dword format
        call [scanf]
        
        mov edx , 0
        mov eax , [a]
        mov dword[sum] , eax
        idiv dword[b] ; eax = edx:eax/b si edx = edx:eax%b
        add dword[sum] , eax
        
        mov [b] , eax
        
        push dword [a]
        push dword format
        call [printf]

        push dword plus  
        call [printf]
        
        mov eax , [b]
        push dword eax
        push dword format
        call [printf]
        
        push dword egal
        call [printf]
        
        push dword [sum]
        push dword format
        call [printf]
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
