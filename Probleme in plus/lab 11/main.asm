bits 32 ; assembling 
global start        

extern exit, printf , scanf             
import exit msvcrt.dll   
import printf msvcrt.dll    
import scanf msvcrt.dll   
extern base_10_to_16                         

segment data use32 class=data
    ; ...
    format db "%d",0
    n dd 0
    n_h times 17 db 0
    len dd 0
    aux db 0,0,0,0,0,0
    endl db 10,0
    aux_l dd 0
    
; our code starts here
segment code use32 class=code
    start:
        ; ...
        
        ; scanf
        push dword n
        push dword format
        call [scanf]
        add esp , 4*2
        
        push dword n_h
        push dword [n]
        call base_10_to_16
        add esp , 4*2
        
        mov [len] , eax
        
        push dword [len]
        push dword format
        call [printf]
        
        push dword endl
        call [printf]
        add esp , 4*1
        
        
        
        mov ecx , [len]
        loop_main:
            cmp ecx , 0
                je end1
            dec ecx
               
            mov [aux_l] , ecx
                        
            
            mov eax , [aux_l]
            loop_aux:
                cmp eax , -1
                    je out_main
                
                mov bl , [n_h + eax]
                mov [aux] , bl
                
                push dword eax
                
                push dword aux
                call [printf]
                add esp , 4*1
                
                pop eax
                dec eax
            jmp loop_aux
            out_main:
            
            
            
            mov eax , [len]
            dec eax
            loop_aux1:
                cmp eax , [aux_l]
                    je out_main1
                
                mov bl , [n_h + eax]
                mov [aux] , bl
                
                push dword eax
                
                push dword aux
                call [printf]
                add esp , 4*1
                
                pop eax
                dec eax
            jmp loop_aux1
            out_main1:
            
            
            
            push dword endl
            call [printf]
            add esp , 4*1
            
            mov ecx , [aux_l]
            push dword ecx
            push dword format
            call [printf]
            add esp , 4*2
            
            push dword endl
            call [printf]
            add esp , 4*1
            
            mov ecx , [aux_l]
        jmp loop_main
        end1:
    
        ; exit(0)
        push    dword 0     
        call    [exit]       

        
   
        
     
        
        