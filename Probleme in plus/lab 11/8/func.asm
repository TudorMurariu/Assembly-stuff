bits 32
global afis
extern printf
import printf msvcrt.dll

segment data use32 class=data
    ; ...
    format8 db "%o ",0
    formatC db "%c",10,0

segment code use32 class=code
    afis: 
        mov eax , [esp + 4]
        
        push dword eax
        push dword format8
        call [printf]
        add esp , 4*2
        
        mov eax , [esp + 4]
        
        push dword eax
        push dword formatC
        call [printf]
        add esp , 4*2
        
        ret