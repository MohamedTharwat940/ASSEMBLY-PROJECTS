;MOHAMED THARWAT SHAWKY
.MODEL SMALL
.DATA
NUMDIGITS DB 'ENTER NUMBER OF DIGITS :- ','$'
PRINTARRAYSTAT DB 'ENTER ARRAY ELEMENTS','$'
SORTEDARRAY DB 'SORTED ARRAY','$'
AGAIN DB 'WANT ANOTHER OPERATION ( 1 FOR YES || 0 FOR NO ) :- ','$'
LOP DB ?
ARR DB 10 DUP(0)
COUNT DW ?
.CODE
    MAIN PROC FAR
    .STARTUP
W:
    ;PRINT NUMBER OF DIGITS STATEMENT
    LEA DX,NUMDIGITS
    MOV AH,09H
    INT 21H
    ;READ NUMBER OF DIGITS
    CALL READNUM
    SUB AL,30H
    MOV LOP,AL
    CALL NL
    CALL NL
    ;PRINT ARRAY ELEMENTS STATEMENT 
    LEA DX,PRINTARRAYSTAT
    MOV AH,09H
    INT 21H
    CALL NL
    CALL NL
    ;READ ARRAY
    LEA SI,ARR
    MOV BL,LOP
T:
    CALL READNUM
    MOV [SI],AL
    INC SI
    DEC BL
    CMP BL,0
    CALL TAP
    JNE T
    
    CALL NL
    CALL NL
    
    ;PRINT ARRAY ELEMENTS STATEMENT 
    LEA DX,SORTEDARRAY
    MOV AH,09H
    INT 21H
    CALL NL
    CALL NL
    
    MOV AL,LOP
    MOV AH,00
    MOV CX,AX
    DEC AX
    MOV BX,AX
    MOV COUNT,BX
    LEA SI,ARR
B:
    MOV AL,[SI]
    MOV DL,[SI+1]
    CMP AL,DL
    JL A
    XCHG AL,DL
    MOV [SI],AL
    MOV [SI+1],DL
A:
    INC SI
    DEC BX
    CMP BX,0
    JNE B
    MOV BX,COUNT
    LEA SI,ARR
    LOOP B
    
    ;PRINT SORTED ARRAY
    MOV AL,LOP
    MOV AH,00
    MOV CX,AX
    LEA SI,ARR
C:
    MOV DL,[SI]
    MOV AH,02H
    INT 21H
    INC SI
    CALL TAP
    LOOP C
    CALL NL
    CALL NL
    ;PRINT ANOTHER OPERATION STATEMENT
    LEA DX,AGAIN
    MOV AH,09H
    INT 21H
    ;READ 
    CALL READNUM
    SUB AL,30H
    CMP AL,1
    JE M
    JMP STOP
M:
    CALL NL
    CALL NL
    JMP W
STOP:
    .EXIT
    MAIN ENDP
    
    READNUM PROC NEAR
    MOV AH,01
    INT 21H
    RET
    READNUM ENDP
    
    NL PROC NEAR
    MOV DX,10
    MOV AH,02
    INT 21H
    RET
    NL ENDP
    TAP PROC NEAR
    MOV DX,9
    MOV AH,02
    INT 21H
    RET
    TAP ENDP
    
END MAIN 
