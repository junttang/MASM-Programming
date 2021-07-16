TITLE Task 2 - Calling Procedure

; Assembly Programming HW2 Task2
; Student ID : 20171643
; Name : Park Junhyeok

INCLUDE irvine32.inc

.data
prompt1 BYTE "Enter a Multiplier : ", 0
prompt2 BYTE "Enter a Multiplicand : ", 0
prompt3 BYTE "Procude : ", 0
prompt4 BYTE "Bye!", 0

lier BYTE 9 DUP(0)		
Dlier DWORD 9 DUP(0)
lierCount DWORD ?
cand BYTE 9 DUP(0)	
Dcand DWORD 9 DUP(0)
candCount DWORD ?

.code
main PROC
L1: call MLier				; read the multiplier
	jz Quit					; terminate if Enter key pressed
	call MLicand			; read the multiplicand
	jz Quit

	mov edx, OFFSET lier
	mov ecx, lierCount
	call Trans				; transform Char Arr to Digit Arr
	mov edx, OFFSET cand
	mov ecx, candCount
	call Trans

	call LShft				; * Multiplication Process *
	mov ebx, 0				; * Multiplication Process *
	call CShft				; * Multiplication Process *
	call Calc				; * Multiplication Process *

	call Prod				; prints out the result
	loop L1

Quit:
	call Bye
	exit
main ENDP

; Prod Procedure : print out the result
Prod PROC USES edx
	mov edx, OFFSET prompt3
	call WriteString
	call WriteHex
	call Crlf
	ret
Prod ENDP

; Calc Procedure : calculate the multiplication
; Multiplication Process - No.3
; The Only "Multiplicating related" operator used : add
Calc PROC
	mov esi, 0
	mov eax, 0
	mov ecx, lierCount
L1:	push ecx
	mov ecx, Dlier[esi]
	cmp ecx, 0
	je L3
L2:	add eax, ebx			; add operator
	loop L2
L3:	pop ecx
	add esi, 4				; add operator
	loop L1
	ret
Calc ENDP

; LShft Procedure : shift the muliplier to the left
; Multiplication Process - No.1
; The Only "Multiplicating related" operator used : add, shl
LShft PROC 
	mov esi, 0
	mov edi, 0
	mov ecx, lierCount
L6:	mov eax, 0
	mov al, lier[esi]
	push ecx
	add ecx, -1;			; add operator
	cmp ecx, 0
	je LA
L7:	shl eax, 4				; shl operator
L9:	loop L7
LA:	pop ecx
	mov Dlier[edi], eax
	add esi, 1				; add operator
	add edi, 4				; add operator
	loop L6	
	ret
LShft ENDP

; CShft Procedure : shift the muliplicand to the left
; Multiplication Process - No.2
; The Only "Multiplicating related" operator used : add, shl
CShft PROC 
	mov esi, 0
	mov edi, 0
	mov ecx, candCount
L6:	mov eax, 0
	mov al, cand[esi]
	push ecx
	add ecx, -1;			; add operator
	cmp ecx, 0
	je LA
L7:	shl eax, 4				; shl operator
L9:	loop L7
LA:	pop ecx
	mov Dcand[edi], eax
	add esi, 1				; add operator
	add edi, 4				; add operator
	add ebx, eax
	loop L6
	ret
CShft ENDP

; Trans Procedure : transform Char to Digit
; Since this procedure isn't related to the multiplication
; directly, subtract operation is used.
Trans PROC USES edx ecx
L2:	mov eax, 0
	mov al, [edx]
	cmp al, "9"
	jg L3
	sub al, "0"
	jmp L5
L3:	cmp al, "Z"
	jg L4
	sub al, "A"
	add al, 10
	jmp L5
L4:	sub al, "a"
	add al, 10
L5: mov [edx], al
	add edx, 1
	loop L2
	ret
Trans ENDP

; MLier Procedure : read the multiplier
MLier PROC USES edx eax
	mov edx, OFFSET prompt1
	call WriteString
	mov edx, OFFSET lier
	mov ecx, LENGTHOF lier
	call ReadString
	mov lierCount, eax
	ret
MLier ENDP

; MLicand Procedure : read the multiplicand
MLicand PROC USES edx eax
	mov edx, OFFSET prompt2
	call WriteString
	mov edx, OFFSET cand
	mov ecx, LENGTHOF cand
	call ReadString
	mov candCount, eax
	ret
MLicand ENDP

; Bye Procedure : print out message when Enter pressed
Bye PROC USES edx
	mov edx, OFFSET prompt4
	call WriteString
	ret
Bye ENDP
END main