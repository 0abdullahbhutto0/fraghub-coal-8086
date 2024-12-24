;all the macros for the project


;macro for printing string
println macro str
    lea dx, str
    mov ah, 9
    int 21h
endm

;macro for newline
newline macro
    mov dl, 10
    mov ah, 2 
    int 21h
    mov dl, 13
    mov ah, 2
    int 21h
endm

;macro for user input in char
scanc macro
    mov ah, 1
    int 21h
endm


;macro for writing the final amount in file
println_receipt macro str
    mov ah, 40h
    mov bx, FHANDLE
    lea dx, str
    mov cx, 15
    int 21h
    jc IF_ERROR
endm    


;macro to creating a new file named reciept
create_receipt macro
    mov ah, 3ch   ;3ch to create a file
    lea dx, FNAME ;dx is storing the file name stored in the data
    mov cl, 0 
    int 21h
    JC IF_ERROR
    mov FHANDLE, ax
    println_receipt RECIEPT_PROMPT2
    println_receipt RECIEPT_PROMPT
    println_receipt RECIEPT_PROMPT1 
    mov ah, 40h    ;
    mov bx, FHANDLE
    lea dx, RECEIPT_BUFFER
    mov cx, COUNT_RECEIPT
    int 21h
    jc IF_ERROR
    println_receipt RECIEPT_PROMPT
    MOV AH, 3EH
    MOV BX, FHANDLE
    INT 21H
    JC IF_ERROR
    JMP END
endm    






.MODEL SMALL
.STACK 100H
.DATA       

;all the variables being used in this project

INTRO DB '                               |FRAGRANCE SHOP|                                 $',10,13
INTRO2 DB '-----------------------------------------------------------------------------$',10,13

ENTER DB 10,13,'PLEASE ENTER THE KEYS FOR THE FRAGRANCES YOU WANT TO BUY: $'

INFO DB 10,13,'KEYS           FRAGRANCES                 PRICE$'

Chanel DB 10,13,' 1            CHANEL NO. 5               150 USD $'
Dior DB 10,13,' 2            DIOR SAUVAGE               140 USD $'
Gucci DB 10,13,' 3            GUCCI BLOOM                210 USD $'
Armani DB 10,13,' 4            ARMANI CODE                350 USD $'
Ysl DB 10,13,' 5            YSL BLACK OPIUM            140 USD $'
Versace DB 10,13,' 6            VERSACE EROS               220 USD $'
CK DB 10,13,' 7            CALVIN KLEIN ETERNITY      310 USD $'
Bvlgari DB 10,13,' 8            BVLGARI MAN IN BLACK       180 USD $'
TomFord DB 10,13,' 9            TOM FORD OMBRE LEATHER     225 USD $'

EXIT DB 10,13,' E/e  EXIT                     $'

;index to store prices of the frag
PRICES DW 150, 140, 210, 350, 140, 220, 310, 180, 225

E_QUANTITY DB 10,13,'ENTER QUANTITY: $'

AGAIN DB 10,13,'DO YOU WANT TO BUY MORE? (1.YES || 2.NO): $'

ER_MSG DB 10,13,'ERROR INPUT$'  

CHOICE DB 10,13,'ENTER YOUR CHOICE:$'    

FT DB 10,13,'TOTAL AMOUNT IS :$' 
 
ERR DB 0DH,0AH,'WRONG INPUT! START FROM THE BEGINNING $'   

ERR2 DB 0DH,0AH,'WRONG INPUT.PRESS Y/Y OR N/N $' 

R DB 0DH,0AH,'PRESENT AMOUNT IS : $' 

E_DISCOUNT DB 10,13,'ENTER DISCOUNT(IF NOT AVAILABLE ENTER 0 ): $' 

ERASK DB 10,13,'START FROM THE BEGINNING $'

EN_DIS DB 10,13,'AGAIN ENTER DISCOUNT: $'

RECIEPT_PROMPT DB 10, 13, '=================$'

RECIEPT_PROMPT1 DB 10, 13, 'FINAL AMOUNT: $'

RECIEPT_PROMPT2 DB 'THANK YOU!!!!', 10, 13, '$' 

ERR_RECEIPT DB 10,13,'Error creating Receipt$'

FNAME DB 'Receipt.txt',0

FHANDLE DW ?

RECEIPT_BUFFER DB 100 DUP('$')

COUNT_RECEIPT DW 0

RECEIPT_INPUT DW 0  

;variables to store temp data
A DW ?                           
B DW ?
S DW 0,'$'                                

 
.CODE
  
     MOV AX, @DATA               
     MOV DS, AX
         
     
     println INTRO2             ;using printing macro to print intro2 var
     
     newline
     
     println INTRO              ;using printing macro to print intro var
     
     println INTRO2             ;using printing macro to print intro2 var
          
     newline
            

     JMP BEGINTOP               ;jump unconditional to begintop label 

 ERROR121:  
                  
     println ER_MSG               ;using printing macro to print Error var  
                                 
                                 ;if user gives other input it will print error message 
     println ERASK
     
                
 
 ;initializing begintop variable
 BEGINTOP:   
 
     newline
    
                                               
      
     println INFO                 ;print info message

     println Chanel              ;print chanel option

     newline
    
     println Dior              ;print dior option

     newline
           
     println Gucci            ;print Gucci option

     newline
            
     println Armani              ;print Armani option

     newline
            
     println Ysl            ;print ysl option
     
     newline
           
     println Versace          ;print versasce option

     newline
     
     println CK              ;print ck option

     newline

     println Bvlgari              ;print bvlgari option

     newline

     println TomFord                ;print tomford option

     newline
     
     println EXIT
     
     newline
            
     println ENTER                  
        
     
     scanc                        ;INPUT CHOICE FROM USER 
     
     
     ;comparing input variables to see what user choosed                             
     CMP AL,49                   
     JE ChanelB
     
     CMP AL,50                   
     JE DiorB
     
     CMP AL,51                   
     JE GucciB
     
     CMP AL,52                   
     JE ArmaniB
     
     CMP AL,53                   
     JE YslB
     
     CMP AL,54                   
     JE VersaceB
     
     CMP AL,55                   
     JE CKB
     
     CMP AL,56                   
     JE BvlgariB
     
     CMP AL,57                   
     JE TomFordB
      
      ;checking to see if user presses capital E or small e
     CMP AL,69                  
     JE END
     
     CMP AL,101                  
     JE END
     
    
     
     
     JMP ERROR121                ;unconditional jump to error121 lable if user presses other key 
     


;declaring label according to the frag names in which the prices is moved to a temp var from index  
ChanelB:

MOV AX, PRICES[0]                                 
MOV A,AX                        

JMP QUANTITY

DiorB:

MOV AX, PRICES[2]                                 
MOV A, AX                        

JMP QUANTITY 

GucciB:

MOV AX, PRICES[4]                                 
MOV A,AX                       

JMP QUANTITY 

ArmaniB: 

MOV AX, PRICES[6]                                 
MOV A,AX                       

JMP QUANTITY 

YslB: 

MOV AX, PRICES[8]                                 
MOV A,AX                       

JMP QUANTITY 

VersaceB:

MOV AX, PRICES[10]                                 
MOV A,AX                        

JMP QUANTITY 

CKB:   

MOV AX, PRICES[12]                                 
MOV A,AX                        

JMP QUANTITY 

BvlgariB:   

MOV AX, PRICES[14]                                 
MOV A,AX                       

JMP QUANTITY 

TomFordB:      

MOV AX, PRICES[16]                                 
MOV A,AX                        

JMP QUANTITY                          ;unconditional jump to quantity                    

    
 
 ;quantity label
QUANTITY:  

    println E_QUANTITY             
    
    JMP MULTI                     ;unconditional jump to multi where we calculate the total amount

 
 ;declaring ask label to see if user wants to buy other frag as well
ASK: 

    
    println AGAIN                  
    
    scanc
    
    CMP AL,49                    
    JE BEGINTOP
    
    CMP AL,50
    JE OUTPUT2                   
    
    println ER_MSG
    
    JMP ASK                      
    


;error label to print message
ERROR:
    
    println ER_MSG                 
    
    JMP QUANTITY                  
    

;error discount label to print error generated in discount func
ER_DISCOUNT:   

    println ER_MSG                ;
    
    newline
    
    println EN_DIS                 
    
    JMP INPUT_SUB                T 
    
IF_ERROR:
    println ERR_RECEIPT
    JMP END
    

;multi label to multiply the amounts        
MULTI:            

;indec3 or input decimal 3 proc to multiply the quantity with the original amoun
INDEC3 PROC                        

    ;clears the bx register
    XOR BX,BX                                      
    
    scanc                          

    ;repeat label 
    REPEAT4: 
    
    
    ;cmp to see if user is not inserting the values below 0 in ascii                                 
    CMP AL,48                       
    JL ERROR
    
    ;cmp to see if user is not inserting the values greater 9 in ascii
    CMP AL,57                       ; 
    JG ERROR


    AND AX,00FH                     ;using and logic to convert into digit
    
   
    PUSH AX                         ;save the value of AX in stack 
    
    MOV AX,10                       ;moving 10 in ax
    MUL BX                          ;ax=total*10
    POP BX                          ;get the total back from stack
    ADD BX,AX                       ;total = total * 10 + digit
    
    
    ;defining limit if user selects quantity of below 0 or greater than 52
    CMP BX, 0
    JLE ERROR
    CMP BX, 52
    JG ERROR
    
    scanc
    
    
    CMP AL,0DH                      ;to see if user pressed enter key
    JNE REPEAT4                     ;if user did not pressed enter it will repeat the process
    
    MOV AX,BX                       ;move the total in ax
    
    
    JMP MUL_
    
    RET                             ;ret
    
    

INDEC3 ENDP                         ;end of indec3 

;sub label to minus discount from total
SUB_: 


    ;mov the discount value in B variable
    MOV B,AX 
     
     println R                      ;print current amount string
    
    
    XOR AX,AX                        ;clear AX register
    
    MOV AX,B                         ;again mov 
    SUB A,AX                         ;subtract the discount from original price
    
    
    MOV AX,A                         ;mov value stores in a to ax
    
    
    ADD S,AX                         ;add values with S (initially S is empty)
                                      
    JMP OUTPUT

MUL_: 


    ;SECOND VALUE STORED IN B
    MOV B,AX             
    
     println E_DISCOUNT              ;print Enter discount String
    
    XOR AX,AX                        ;clear AX
    
    MOV AX,B
    
    MUL A                            ;multiply AX with A
    
    
    MOV A,AX 
   
                                     
    JMP INPUT_SUB                    ;jump unconditionaly to INP1UT_SUB
    
    
    
    JMP OUTPUT                       ;jump unconditionally to output label
                                            

;label to take input for discount
INPUT_SUB:
 
;input decimal or indec procedure
INDEC2 PROC
    
  
    
    XOR BX,BX                        ;clear BX which holds total
                    

    scanc                    
    
    
    ;label to repeat the procedure
    REPEAT3: 
    
    CMP AL,48                        ;IF AL<0, PRINT ERROR MESSAGE 
    JL ER_DISCOUNT
    
    CMP AL,57                        ;IF AL>9, PRINT ERROR MESSAGE 
    JG ER_DISCOUNT


    AND AX,00FH                      ;using AND logic to convert the user input to single char 
    PUSH AX                          ;save to stack temp
    
    MOV AX,10                        ;move 10 to 
    MUL BX                           ;AX=TOTAL * 10
    POP BX                           ;get the original digit back
    ADD BX,AX                        ;TOTAL = TOTAL X 10 +DIGIT
    
     scanc
     
     ;comparing to see if user pressed enter key
    CMP AL,0DH                       
    JNE REPEAT3                      ;if not then jump to repeat
    
    MOV AX,BX                        ;store in AX the total
    
    CMP AX, A                        ;compares to check if user inserted the discount greater than the actual price
    JGE ER_DISCOUNT                   ;generates error if greater 
    
    
    JMP SUB_                          ;jumps to sub to minus the discount from total

    RET                              ;RETURN
                            


INDEC2 ENDP 
    
OUTPUT:         

;output procedure is to print the total amount

OUTDEC PROC
    

    XOR CX,CX                        ;clear CX to save the counts
    MOV BX,10D                       ;BX has the divisor
    
    REPEAT1:
    
    XOR DX,DX                        ;clears the DX register cuz it stores the remainder during div func
    DIV BX                           ;AX = QUOTIENT, DX=REMAINDER
    
    PUSH DX                          ;sav remainder in stack
    INC CX                           ;count = count +1
    
    OR AX,AX                         ;quoteint is not 0
    JNE REPEAT1                      ;if not equal then repeat to print upto 4 digits 
    
    MOV AH,2                         ;to print char
    
    
    ;initializing print loop to print digits of totak amount
    PRINT_LOOP:
    
    POP DX                           ;pop the remainders pushed in stack back to dx
    OR DL,30H                        ;convert to char
    INT 21H                          ;print the digits 
    LOOP PRINT_LOOP                  ;LOOP UNTILL DONE
    
    
    JMP ASK
    
    RET
    OUTDEC ENDP 

OUTPUT2: 
     
     println FT                     ;macro to print final total
    
    
    XOR AX,AX                        ;CLEAR AX
    
    MOV AX,S                         ;SET AX TO THE CURRENT TOTAL
    
    
    ;OUTDEC2 IS FOR GIVING THE TOTAL OUTPUT OF THE AMOUNT
    
                                     
OUTDEC2 PROC
    

    XOR CX,CX                        ;CX COUNTS DIGITS
    MOV BX,10D                       ;BX HAS DIVISOR
    
    REPEAT12:
    
    XOR DX,DX                        ;PREP HIGH WORD
    DIV BX                           ;AX = QUOTIENT, DX=REMAINDER
    
    PUSH DX                          ;SAVE REMAINDER ON STACK
    INC CX                           ;COUNT = COUNT +1
    
    OR AX,AX                         ;QUOTIENT = 0?
    JNE REPEAT12                     ;NO, KEEP GOING 
    
    MOV AH,2                         ;PRINT CHAR FUNCTION
    MOV BX, 0
    LEA SI, RECEIPT_BUFFER
    PRINT_LOOP2:
    
    POP DX                           ;DIGIT IN DL
    OR DL,30H                        ;CONVERT TO CHAR
    INT 21H                          ;PRINT DIGIT
    MOV [SI], DL                     ; adding the current digit to receipt buffer through SI
    INC SI
    INC BX                           ;incrementing count to be passed in cx in the receipt macro
    LOOP PRINT_LOOP2                 ;loop until done
    
    MOV COUNT_RECEIPT, BX            ;mov the length of the final amount to the count receipt var 


    OUTDEC2 ENDP 
 
    create_receipt
         
;end label to terminate the prog
END:
MOV AH, 4CH                  
INT 21H