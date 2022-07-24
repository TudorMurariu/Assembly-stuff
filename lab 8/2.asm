bits 32 ; assembling for the 32 bits architecture

; declare the EntryPoint (a label defining the very first instruction of the program)
global start        

; declare external functions needed by our program
extern exit, printf, scanf               ; tell nasm that exit exists even if we won't be defining it
import exit msvcrt.dll    ; exit is a function that ends the calling process. It is defined in msvcrt.dll
                          ; msvcrt.dll contains exit, printf and all the other important C-runtime specific functions
import printf msvcrt.dll
import scanf msvcrt.dll
;Sa se citeasca de la tastatura doua numere a si b (in baza 10) si sa se calculeze a/b. Catul impartirii se va ;salva in memorie in variabila "rezultat" (definita in segmentul de date). Valorile se considera cu semn.
; our data is declared here (the variables needed by our program)
segment data use32 class=data
    ; ...
    mesaj db " rest ",0
    format db "%d",0
    a dd 0
    b dd 0
    reazultat db 0
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ; Citim cele doua numere
        ; scanf("$d",a)
        push dword a
        push dword format
        call [scanf]
        add esp, 4 * 2 
        
        ; scanf("$d",b)
        push dword b
        push dword format
        call [scanf]
        add esp, 4 * 2 
        
        ; mutam in dx:ax pe a
        mov edx , 0
        push dword[a]
        pop ax
        pop dx
        
        ; facem impartirea
        mov bx , [b]
        idiv bx ; ax = dx:ax / bx
        cwde     ; eax = ax
        mov dword [reazultat] , eax ; rezultat = catul impartirii
        mov ebx , edx
        
        ; printf("%d",eax)
        ; afisam catul
        push dword [reazultat]
        push dword format
        call [printf]
        add esp, 4 * 2 
        
        
        ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
        ; afisam " rest " in consola
        ;push dword mesaj
        ;call [printf]
        ;add esp, 4
        
        ; afisam restul in consola
        ;mov edx , ebx
        ;cmp edx , [b] ; restul nu poate fi mai mare deact catul
        ;jng else
            ;sub edx , 65536 ; = 2^16
            ;neg edx
        
        ;else:
        ; printf("%d",edx)
        ;push dword edx
        ;push dword format
        ;call [printf]
        ;add esp, 4 * 2 
        
        ; exit(0)
        push    dword 0      ; push the parameter for exit onto the stack
        call    [exit]       ; call exit to terminate the program
