;COAL PROJECT PHASE 1
;ALI IMRAN 20I-1763
;AMEERA HAIDER 20I-0799
;CS E

.model small
.stack 100h
.data

	v1 dw 0
	v2 dw 0
	xCord dw 25
	xCordUpper dw 200
	yCord dw 25
	rand dw 0
	
	r0 db 			"  *******************************  GAME  RULES  ******************************$"
	r1 db 			"  *    1) Swap two adjacent candies                                          *$"
	r2 db 			"  *    2) Make a row or column of at least 3 matching-random candies         *$"
	r3 db 			"  *    3) When Candies are matched, your scrore Increases                    *$"
	r4 db 			"  *    4) The game is split among three levels                               *$"
	r5 db 			"  *    5) Each Level must be Completed before the Next                       *$"
	r6 db 			"  *                                                                          *$"
	r7 db 			"  ****************************************************************************$"
	
	p1 db 			"                                                                **PLAYER NAME**$"
	s1 db 	        "                                                                 ***********  $"
	s2 db 	        "                                                                 *  SCORE  *  $"
	s3 db 	        "                                                                 *         *  $"	
	s4 db 	        "                                                                 ***********  $"
	
	gameName db 	"  ****************************************************************************$"
	gameName1 db 	"  *                             CANDY                                        *$"
	gameName2 db 	"  *                                     CRUSH                                *$"
	gameName3 db 	"  ****************************************************************************$"
	namePrompt db 	"  Please Enter your Name:$"	
	returnPrompt db "  **************************  Press ENTER to Proceed  ************************$"
	nameArray db 0
	
	
.code

;************************************************************************************************************
;*                                                MACROS                                                    *
;************************************************************************************************************


;************************************************* MACRO TO PRINT STRING ************************************
printString macro s

		;Output String
		MOV AH, 09h
		MOV DX, offset s
		INT 21h
endm

;************************************************* COLOUR BOMB ***********************************************
bomb macro x,y

	mov cx, x ;X-axis position
	mov dx, y ;Y-axis position 
	.Repeat
	
		int 10h
		inc cx
	.until (cx==40)
	
	mov cx,40 ;X-axis position
	mov dx,25 ;Y-axis position 
	.Repeat
	
		int 10h
		inc dx
	.until (dx==40)
	
	mov cx,40 ;X-axis position
	mov dx,25 ;Y-axis position  
	.Repeat
	
		int 10h
		inc dx
	.until (dx==40)
	
	mov cx,25 ;X-axis position
	mov dx,25 ;Y-axis position  
	.Repeat
	
		int 10h
		inc dx
	.until (dx==40)
	
	mov cx,25 ;X-axis position
	mov dx,40 ;Y-axis position  
	.Repeat
	
		int 10h
		inc cx
	.until (cx==41)
	
	mov al,05h
	mov cx,20 ;X-axis position
	mov dx,30 ;Y-axis position 
	.Repeat
	
		int 10h
		inc dx
	.until (dx==36)
	
	mov al,05h
	mov cx, 20 ;X-axis position
	mov dx, 36 ;Y-axis position
	.Repeat
	
		int 10h
		inc cx
	.until (cx==25)
	
	mov al,05h
	mov cx,20 ;X-axis position
	mov dx,30 ;Y-axis position
	.Repeat

		int 10h
		inc cx
	.until (cx==25)
	
	mov al,05h
	mov cx,45 ;X-axis position
	mov dx,30 ;Y-axis position
	.Repeat
	
		int 10h
		inc dx
	.until (dx==36)
	
	mov al,05h
	mov cx,40 ;X-axis position
	mov dx,30 ;Y-axis position
	.Repeat
	
		int 10h
		inc cx
	.until (cx==46)
	
	mov al,05h
	mov cx,40 ;X-axis position
	mov dx,30 ;Y-axis position
	.Repeat
	
		int 10h
		inc cx
	.until (cx==46)
	
	mov al,05h
	mov cx,40 ;X-axis position
	mov dx,36 ;Y-axis position
	.Repeat
	
		int 10h
		inc cx
	.until (cx==46)
endm
;************************************************************************************************************
;*                                               MAIN                                                       *
;************************************************************************************************************
main proc

	;Defining Start of Memory
    MOV AX, @DATA 
    MOV DS, AX

	;SETTING TO VIDEO MODE
	MOV AH,00H  ;Video Mode
	MOV AL,00EH ;Selecting Resolution: 320x200 16 color graphics (MCGA,VGA)
	INT 10H
	
;////////////////////////////////////////// Page 1 //////////////////////////////////////////

	;Select Page
		MOV AH, 05H
		MOV AL, 01H
		INT 10H
	
	;Change Background Colour
		MOV AH, 0BH
		MOV BH, 00H
		MOV BL, 03H
		INT 10H  

	;Output Strings
		call nextLine
		call nextLine
		printString gameName
		call nextLine
		printString gameName1
		call nextLine
		printString gameName2
		call nextLine
		printString gameName3
		call nextLine
			
	;Display Prompt
		
		call nextLine
		call nextLine 
		call nextLine 
		call nextLine 
		call nextLine
		
		printString namePrompt
			
	;Input Name
		
		MOV DL, ' '
		MOV AH, 02h
		INT 21h
		
		;Input String
			MOV SI, 0
			nameLoop:
				
				MOV AH, 01h
				INT 21h
				
				CMP AL, 13
				JE nameLoopEnd
				
				MOV nameArray[SI], AL
				INC SI
				JMP nameLoop
				
			nameLoopEnd:
			
			MOV nameArray[SI], '$' ;End String
	
	;Return Prompt
	
		call nextLine
		call nextLine
		call nextLine 
		call nextLine		
		call nextLine
		call nextLine 
		call nextLine 
		call nextLine
		call nextLine 
		call nextLine
		printString returnPrompt
			
	;Take Input For Enter
	enterloop:
	
		MOV AH, 08h
		INT 21h
	
	CMP AL, 13
	JNE enterloop
	
;////////////////////////////////////////// Page 2 //////////////////////////////////////////
	
	;Select Page
		MOV AH, 05H
		MOV AL, 02H
		INT 10H
	
	;Change Background Colour
		MOV AH, 0BH
		MOV BH, 00H
		MOV BL, 03H
		INT 10H  
	
	;Output Strings
		call nextLine
		call nextLine
		printString gameName
		call nextLine
		printString gameName1
		call nextLine
		printString gameName2
		call nextLine
		printString gameName3
		call nextLine
		call nextLine 
		call nextLine 
		call nextLine 
		call nextLine
		printString r0
		call nextLine
		printString r1
		call nextLine
		printString r2
		call nextLine
		printString r3
		call nextLine
		printString r4
		call nextLine
		printString r5
		call nextLine
		printString r6
		call nextLine
		printString r7
		call nextLine
		call nextLine 
		call nextLine 
		call nextLine
		call nextLine
		call nextLine
		printString returnPrompt

	;Take Input For Enter
	enterloop1:
	
		MOV AH, 08h
		INT 21h
	
	CMP AL, 13
	JNE enterloop1
	
;////////////////////////////////////////// Page 3 //////////////////////////////////////////

	;SETTING TO VIDEO MODE
		MOV AH, 00H  
		MOV AL, 013H ;Selecting Resolution: 320x200 16 color graphics (MCGA,VGA)
		INT 10H
	
	;Colour of Whole Sreen
		MOV AH, 06h 
		MOV BH, 00H ;CHANGE TO CHANGE BACK GROUND COLOUR
		XOR AL, AL
		XOR CX, CX
		MOV DX, 184FH
		INT 10h 	;Screen Interrupt		
		
	;Colour of Pixel
		mov ah, 0CH 
		mov al, 0FH ;AL contains color

	;_____________________________________________ DRAWING LINES FOR BOARD _____________________________________________
	
	mov cx, 20	;X-axis position
	mov dx, 12	;Y-axis position 	
	.Repeat
		call delay
		int 10h 
		inc cx
	.until (cx == 195) ;Increase X co ordinate from 20 to 195

	mov cx,20	;X-axis position
	mov dx,12	;Y-axis position 
	.Repeat
	
		int 10h
		inc dx
	.until (dx==187)
	
	mov cx, 20	;X-axis position
	mov dx, 187	;Y-axis position
	.Repeat
		call delay
		int 10h
		inc cx
	.until (cx==195)
	
	mov cx,195	;X-axis position
	mov dx,12	;Y-axis position
	.Repeat
		call delay
		int 10h
		inc dx
	.until (dx==187)
	
	mov cx,20	;X-axis position
	mov dx,37	;Y-axis position
	.Repeat
		int 10h
		inc cx
	.until (cx==195)
	
	mov cx,20	;X-axis position
	mov dx,62	;Y-axis position
	.Repeat
		int 10h
		inc cx
	.until (cx==195)
	
	mov cx,20	;X-axis position
	mov dx,87	;Y-axis position
	.Repeat
		int 10h
		inc cx
	.until (cx==195)
	
	mov cx,20	;X-axis position
	mov dx,112	;Y-axis position
	.Repeat
		int 10h
		inc cx
	.until (cx==195)
	
	mov cx,20	;X-axis position
	mov dx,137	;Y-axis position	
	.Repeat
		int 10h
		inc cx
	.until (cx==195)
	
	mov cx,20	;X-axis position
	mov dx,162	;Y-axis position
	.Repeat
		int 10h
		inc cx
	.until (cx==195)
	
	mov cx, 20	;X-axis position
	mov dx, 187	;Y-axis position
	.Repeat
		int 10h
		inc cx
	.until (cx==195)
	
	mov cx, 45	;X-axis position
	mov dx, 12	;Y-axis position
	.Repeat
		int 10h
		inc dx
	.until (dx==187)
	
	mov cx, 70	;X-axis position
	mov dx, 12	;Y-axis position
	.Repeat
		int 10h
		inc dx
	.until (dx==187)
	
	mov cx, 95	;X-axis position
	mov dx, 12	;Y-axis position
	.Repeat
	
		int 10h
		inc dx
	.until (dx==187)
	
	mov cx, 120	;X-axis position
	mov dx, 12	;Y-axis position
	.Repeat
		int 10h
		inc dx
	.until (dx==187)
	
	mov cx, 145	;X-axis position
	mov dx, 12	;Y-axis position
	.Repeat
		int 10h
		inc dx
	.until (dx==187)
	
	mov cx, 170	;X-axis position
	mov dx, 12	;Y-axis position
	.Repeat
	
		int 10h
		inc dx
	.until (dx==187)
	
	mov cx, 195	;X-axis position
	mov dx, 12	;Y-axis position
	.Repeat
		int 10h
		inc dx
	.until (dx==187)
	
	;_____________________________________________ CANDIES _____________________________________________
	
	;Row 1
	MOV xCord, 25 ;X-axis position
	MOV yCord, 25 ;Y-axis position
	call fillRow
	
	;Row 2
	MOV xCord, 25 ;X-axis position
	MOV yCord, 50 ;Y-axis position
	call fillRow
	
	;Row 3
	MOV xCord, 25 ;X-axis position
	MOV yCord, 75 ;Y-axis position
	call fillRow
	
	;Row 4
	MOV xCord, 25  ;X-axis position
	MOV yCord, 100 ;Y-axis position
	call fillRow
	
	;Row 5
	MOV xCord, 25  ;X-axis position
	MOV yCord, 125 ;Y-axis position
	call fillRow
		
	;Row 6
	MOV xCord, 25 ;X-axis position
	MOV yCord, 150
	call fillRow
	
	;Row 7
	MOV xCord, 25  ;X-axis position
	MOV yCord, 175 ;Y-axis position
	call fillRow
	
exit:
MOV AH, 4ch
INT 21h
	
main endp

;************************************************************************************************************
;*                                                PROCEDURES                                                *
;************************************************************************************************************


;************************************************* PRINT EMPTY LINE *************************************************
nextLine proc

	;Next Line
		MOV DL, 10
		MOV AH, 02h
		INT 21H
		ret
nextLine endp

;************************************************* GENERATE RANDOM NUMBER *************************************************
random proc

	call Delay
	mov ah,0h
	int 01ah
	
	mov ax,dx
	mov dx,0
	mov bx,6
	div bx
	mov rand, dx
	
	
ret
random endp
	
;****************************************************** DELAY ******************************************************
Delay proc

	push ax
	push bx
	push cx
	push dx

	mov cx, 1000
	ll0:
	mov bx, 10;Delay factor 
	ll1:
	dec bx
	jnz ll1
	loop ll0

	pop dx
	pop cx
	pop bx
	pop ax

ret
Delay endp

;************************************************* PINK DIAMOND *************************************************
diamond1 proc

mov cx, xCord; CX contains X-axis position means Column #
mov dx, yCord; DX contains Y-axis position # ROW # 
		
;lower triangle
nextline1:
	
		mov bx,15 ;stopping condition
		mov si,cx
		mov v1,cx
		mov v2,dx
		add v2,2
		
	lines1:
	
		mov cx,si
		mov bp,bx
		inc dx
		inc si
		
		cmp bx,00
		jle nextline2
		
		sub bx,2
	
	lines2:
	
		mov ah,0ch
		mov al,0Dh
		mov cx,cx
		mov dx,dx
		int 10h
		inc cx  ;to move line
		dec bp  ;to end loop
		cmp bp,00
		je lines1
		JMP lines2

nextline2:
	
		mov bx,15 ;stopping condition
		mov si,v1
		mov dx,v2
	
    lines3:
	
		mov cx,si
		mov bp,bx
		dec dx
		inc si
		
		cmp bx,00
		jle exit2
		
		sub bx,2
	
	lines4:
	
		mov ah,0ch
		mov al,0Dh
		mov cx,cx
		mov dx,dx
		int 10h
		inc cx  ;to move line
		dec bp  ;to end loop
		cmp bp,00
		je lines3
		JMP lines4
exit2:		
ret
diamond1 endp

;************************************************* BLUE DIAMOND *************************************************
diamond2 proc

mov cx, xCord; CX contains X-axis position means Column #
mov dx, yCord; DX contains Y-axis position # ROW # 
		
;lower triangle
nextline11:
	
		mov bx,15 ;stopping condition
		mov si,cx
		mov v1,cx
		mov v2,dx
		add v2,2
		
	lines11:
	
		mov cx,si
		mov bp,bx
		inc dx
		inc si
		
		cmp bx,00
		jle nextline22
		
		sub bx,2
	
	lines22:
	
		mov ah,0ch
		mov al,01h
		mov cx,cx
		mov dx,dx
		int 10h
		inc cx  ;to move line
		dec bp  ;to end loop
		cmp bp,00
		je lines11
		JMP lines22

nextline22:
	
		mov bx,15 ;stopping condition
		mov si,v1
		mov dx,v2
	
    lines33:
	
		mov cx,si
		mov bp,bx
		dec dx
		inc si
		
		cmp bx,00
		jle exit22
		
		sub bx,2
	
	lines44:
	
		mov ah,0ch
		mov al,01h
		mov cx,cx
		mov dx,dx
		int 10h
		inc cx  ;to move line
		dec bp  ;to end loop
		cmp bp,00
		je lines33
		JMP lines44
exit22:		
ret
diamond2 endp

;************************************************* BLUE DIAMOND *************************************************
diamond3 proc

mov cx, xCord; CX contains X-axis position means Column #
mov dx, yCord; DX contains Y-axis position # ROW # 
		
;lower triangle
nextline111:
	
		mov bx,15 ;stopping condition
		mov si,cx
		mov v1,cx
		mov v2,dx
		add v2,2
		
	lines111:
	
		mov cx,si
		mov bp,bx
		inc dx
		inc si
		
		cmp bx,00
		jle nextline222
		
		sub bx,2
	
	lines222:
	
		mov ah,0ch
		mov al,0Ch
		mov cx,cx
		mov dx,dx
		int 10h
		inc cx  ;to move line
		dec bp  ;to end loop
		cmp bp,00
		je lines111
		JMP lines222

nextline222:
	
		mov bx,15 ;stopping condition
		mov si,v1
		mov dx,v2
	
    lines333:
	
		mov cx,si
		mov bp,bx
		dec dx
		inc si
		
		cmp bx,00
		jle exit222
		
		sub bx,2
	
	lines444:
	
		mov ah,0ch
		mov al,0Ch
		mov cx,cx
		mov dx,dx
		int 10h
		inc cx  ;to move line
		dec bp  ;to end loop
		cmp bp,00
		je lines333
		JMP lines444
exit222:		
ret
diamond3 endp

;************************************************* GREEN TRIANGLE *************************************************
triangle1 proc
	
	mov cx, xCord; CX contains X-axis position means Column #
	mov dx, yCord; DX contains Y-axis position # ROW # 
		
	Tnextline2:
	
		mov bx,18 ;stopping condition
		mov si,cx
	
	Tlines1:
	
		mov cx,si
		mov bp,bx
		dec dx
		inc si
		
		cmp bx,00
		jle exitT
		
		sub bx,2
	
	Tlines2:
	
		mov ah,0ch
		mov al,02h
		mov cx,cx
		mov dx,dx
		int 10h
		inc cx  ;to move line
		dec bp  ;to end loop
		cmp bp,00
		je Tlines1
		JMP Tlines2
		
	exitT:
	ret
triangle1 endp

;************************************************* YELLOW TRIANGLE *************************************************
triangle2 proc
	
	mov cx, xCord; CX contains X-axis position means Column #
	mov dx, yCord; DX contains Y-axis position # ROW # 
		
	Tnextline22:
	
		mov bx,18 ;stopping condition
		mov si,cx
	
	Tlines11:
	
		mov cx,si
		mov bp,bx
		dec dx
		inc si
		
		cmp bx,00
		jle exitTT
		
		sub bx,2
	
	Tlines22:
	
		mov ah,0ch
		mov al,0Eh
		mov cx,cx
		mov dx,dx
		int 10h
		inc cx  ;to move line
		dec bp  ;to end loop
		cmp bp,00
		je Tlines11
		JMP Tlines22
		
	exitTT:
	ret
triangle2 endp

;************************************************* YELLOW TRIANGLE *************************************************
triangle3 proc
	
	mov cx, xCord; CX contains X-axis position means Column #
	mov dx, yCord; DX contains Y-axis position # ROW # 
		
	Tnextline222:
	
		mov bx,18 ;stopping condition
		mov si,cx
	
	Tlines111:
	
		mov cx,si
		mov bp,bx
		dec dx
		inc si
		
		cmp bx,00
		jle exitTTT
		
		sub bx,2
	
	Tlines222:
	
		mov ah,0ch
		mov al,05h
		mov cx,cx
		mov dx,dx
		int 10h
		inc cx  ;to move line
		dec bp  ;to end loop
		cmp bp,00
		je Tlines111
		JMP Tlines222
		
	exitTTT:
	ret
triangle3 endp

;************************************************* FILL ROW WITH SHAPES *************************************************
fillRow proc

	.Repeat
		call random
		call Delay
		call Delay
		call Delay
		call Delay
		call Delay
		
		MOV AX, 0
		MOV DX, 0
		MOV BX, 0
		
		.if rand == 0

			call delay
			call diamond1
			
		.elseif rand == 1

			call delay
			call triangle1
			
		.elseif rand == 2

			call delay
			call diamond2
			
		.elseif rand == 3

			call delay
			call triangle2
			
		.elseif rand == 4

			call delay
			call triangle3
			
		.elseif rand == 5
		
			call delay
			call diamond3
			
		.endif
		
		ADD xCord, 25
		MOV DX, xCord
		
	.until(DX == xCordUpper)
	
ret
fillRow endp

END