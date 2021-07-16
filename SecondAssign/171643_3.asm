TITLE Task 3 - Boolean Calculator

; Assembly Programming HW3 Task3
; Student ID : 20171643
; Name : Park Junhyeok

INCLUDE irvine32.inc

AND_op PROTO
OR_op PROTO
NOT_op PROTO
XOR_op PROTO
ShowResult PROTO strAddr:DWORD

.data
prompt1 BYTE "1. x AND y", 0dh, 0ah
		BYTE "2. x OR y", 0dh, 0ah
		BYTE "3. NOT x", 0dh, 0ah
		BYTE "4. x XOR y", 0dh, 0ah
		BYTE "5. Exit program", 0dh, 0ah, 0
prompt2 BYTE "Choose Calculation Mode : ", 0
prompt3 BYTE "Do you want to change the mode(Y/N)? : ", 0
prompt4 BYTE "Enter x : ", 0
prompt5 BYTE "Enter y : ", 0
prompt6 BYTE "Result of x AND y : ", 0
prompt7 BYTE "Result of x OR y : ", 0
prompt8 BYTE "Result of NOT x : ", 0
prompt9 BYTE "Result of x XOR y : ", 0
prompt10 BYTE "Bye!", 0dh, 0ah, 0

CaseTable	DWORD 1
			DWORD AND_op
			EntrySize = ($ - CaseTable)
			DWORD 2
			DWORD OR_op
			DWORD 3
			DWORD NOT_op
			DWORD 4
			DWORD XOR_op
			DWORD 5
			DWORD Exit_op
NumberOfEntries = ($ - CaseTable) / EntrySize

hexaStr BYTE 9 DUP(0)		
hexaArr DWORD 9 DUP(0)
hexaSize DWORD ?
ErrFlag DWORD 0

.code
main PROC
L1:	call Menu
	call ModeSelect
	jmp L1
	exit
main ENDP

Menu PROC USES edx
	mov edx, OFFSET prompt1
	call WriteString
	call Crlf
	call Crlf
	ret
Menu ENDP

ModeSelect PROC USES edx ecx ebx
L1:	mov edx, OFFSET prompt2
	call WriteString
	call ReadDec
	cmp eax, 5
	jg L1
	cmp eax, 0
	jle L1

	mov ecx, NumberOfEntries
	mov ebx, OFFSET CaseTable
L2:	cmp eax, [ebx]
	jne L3
L5:	call NEAR PTR [ebx + 4]
	jmp L4
L3:	add ebx, EntrySize
	loop L2
L4: call Crlf
	call Crlf
	call Crlf
L7:	call ChangeMode
	cmp al, "Y"
	je Quit
	cmp al, "y"
	je Quit
	cmp al, "N"
	je L6
	cmp al, "n"
	je L6
	jmp L7
L6: call Crlf
	call Crlf
	jmp L5
Quit:
	call Crlf
	call Crlf
	ret
ModeSelect ENDP

ChangeMode PROC USES edx
	mov edx, OFFSET prompt3
	call WriteString
	call ReadChar
	call WriteChar
	call Crlf
	ret
ChangeMode ENDP

AND_op PROC USES edx ebx eax
L1:	mov edx, OFFSET prompt4
	call WriteString
	call ReadHexa
	cmp ErrFlag, 1
	je L1
	mov ebx, eax
	mov edx, OFFSET prompt5
	call WriteString
	call ReadHexa
	cmp ErrFlag, 1
	je L1
	and eax, ebx
	INVOKE ShowResult, OFFSET prompt6
	call WriteHex
	ret
AND_op ENDP

OR_op PROC USES edx ebx eax
L1:	mov edx, OFFSET prompt4
	call WriteString
	call ReadHexa
	cmp ErrFlag, 1
	je L1
	mov ebx, eax
	mov edx, OFFSET prompt5
	call WriteString
	call ReadHexa
	cmp ErrFlag, 1
	je L1
	or eax, ebx
	INVOKE ShowResult, OFFSET prompt7
	call WriteHex
	ret
OR_op ENDP

NOT_op PROC USES edx ebx eax
L1:	mov edx, OFFSET prompt4
	call WriteString
	call ReadHexa
	cmp ErrFlag, 1
	je L1
	mov ebx, eax
	not eax
	INVOKE ShowResult, OFFSET prompt8
	call WriteHex
	ret
NOT_op ENDP

XOR_op PROC USES edx ebx eax
L1:	mov edx, OFFSET prompt4
	call WriteString
	call ReadHexa
	cmp ErrFlag, 1
	je L1
	mov ebx, eax
	mov edx, OFFSET prompt5
	call WriteString
	call ReadHexa
	cmp ErrFlag, 1
	je L1
	xor eax, ebx
	INVOKE ShowResult, OFFSET prompt9
	call WriteHex
	ret
XOR_op ENDP

Exit_op PROC
	call Crlf
	call Crlf
	mov edx, OFFSET prompt10
	call WriteString
	exit
Exit_op ENDP

ShowResult PROC strAddr:DWORD 
	push edx
	mov edx, strAddr
	call WriteString
	pop edx
	ret
ShowResult ENDP

; The Procedures below are designed to satisfy the NOTE no.3 
; in the pdf mannual : If a user enters improper input as a
; value of an x(or y), then get the value again.
; Since ReadHex procedure in Irvine32 libaray cannot handle
; error inputs, I used the previous handmade algorithm to read
; hexadecimal as string and translate it into a real hexadecimal
; value while handling error inputs. This algorithm is the same
; algorithm which is used in the previous homework HW2 - task2
ReadHexa PROC USES edx ecx ebx
	mov edx, OFFSET hexaStr
	mov ecx, LENGTHOF hexaStr
	call ReadString
	jz EnterPress
	mov hexaSize, eax

	mov edx, OFFSET hexaStr
	mov ecx, hexaSize
	mov ErrFlag, 0
	call ErrorCheck
	call Trans
	mov ebx, 0
	call Shft
	mov eax, ebx
	ret
EnterPress:
	mov ErrFlag, 1
	ret
ReadHexa ENDP

ErrorCheck PROC USES ecx ebx esi
	mov esi, 0
	mov ecx, hexaSize
L1: mov bl, hexaStr[esi]
	cmp bl, "0"
	jb Err
	cmp bl, "9"
	jbe NoErr
	cmp bl, "A"
	jb Err
	cmp bl, "F"
	jbe NoErr
	cmp bl, "a"
	jb Err
	cmp bl, "f"
	ja Err
NoErr:
	inc esi
	loop L1
	ret
Err:
	mov ErrFlag, 1
	ret
ErrorCheck ENDP

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

Shft PROC USES esi edi ecx eax
	mov esi, 0
	mov edi, 0
	mov ecx, hexaSize
L6:	mov eax, 0
	mov al, hexaStr[esi]
	push ecx
	sub ecx, 1
	cmp ecx, 0
	je LA
L7:	shl eax, 4	
L9:	loop L7
LA:	pop ecx
	add esi, 1		
	add edi, 4		
	add ebx, eax
	loop L6
	ret
Shft ENDP

END main