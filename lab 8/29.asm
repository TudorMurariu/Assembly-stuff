bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll

;Se citesc de la tastatura trei numere a, m si n (a: word, 0 <= m, n <= 15, m > n). Sa se izoleze bitii de la ;m-n ai lui a si sa se afiseze numarul intreg reprezentat de acesti bitii in baza 10.

; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    a dw 0
    n dd 0
    m dd 0
    format db "%d",0
    aux dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ; Citire
        ; scanf("%d",aux)
        push dword aux
        push dword format
        call [scanf]
        add esp, 4 * 2 
        
        mov eax , [aux]
        mov word[a] , ax
                 
        ; scanf("%d",n)
        push dword n
        push dword format
        call [scanf]
        add esp, 4 * 2 
        
        ; scanf("%d",m)
        push dword m
        push dword format
        call [scanf]
        add esp, 4 * 2 
        
        ; Calcul
        mov ax , [a]
        mov cl , [m]
        shr ax , cl
        shl ax , cl
        mov cl , 16
        sub cl , [n]
        ; sterge toti bitii mai sus de al n-lea bit
        shl ax , cl
        shr ax , cl
        mov word[a] , ax
        
        
        ; Afisare
        ; mutam [a] , in eax si apoi in aux pentru a il afisa
        mov ax , [a]
        cwde
        mov [aux] , eax
        
        ; printf("%d",aux)
        push dword [aux]
        push dword format
        call [printf]
        add esp, 4 * 2 
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
