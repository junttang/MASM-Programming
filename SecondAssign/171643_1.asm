TITLE Task 1 - Sorting Pairs

; Assembly Programming HW3 Task1
; Student ID : 20171643
; Name : Park Junhyeok

INCLUDE irvine32.inc

.data
INCLUDE hw3.inc
LenNew = ($-ArrData) / 4
NewArr DWORD LenNew DUP(0)
oddArr DWORD LenNew DUP(0)
oddLen DWORD ?
evenArr DWORD LenNew DUP(0)
evenLen DWORD ?

prompt1 BYTE "Before sort : ", 0
prompt2 BYTE "After sort : ", 0
prompt3 BYTE "Bye!", 0dh, 0ah, 0
prompt4 BYTE ", ", 0

.code
main PROC
	call ExepHandle

	call BeforeS
	call MakeOddArr
	call MakeEvenArr

	call OddSort
	call EvenSort

	call MakeNewArr
	call AfterS
	call Bye
	exit
main ENDP

MakeNewArr PROC USES ecx esi edi eax
	mov ecx, oddLen
	mov esi, 0
	mov edi, 0
L5: mov eax, oddArr[esi]
	mov NewArr[edi], eax
	add esi, 4
	add edi, 8
	loop L5
	mov ecx, evenLen
	mov esi, 0
	mov edi, 4
L6: mov eax, evenArr[esi]
	mov NewArr[edi], eax
	add esi, 4
	add edi, 8
	loop L6
	ret
MakeNewArr ENDP

OddSort PROC USES ecx eax ebx esi
	mov ecx, oddLen
	sub ecx, 1
L5:	push ecx
	mov esi, 0
L1:	mov ax, WORD PTR oddArr[esi+2]
	cmp ax, WORD PTR oddArr[esi+6]
	ja L2
	jb L3
	mov ax, WORD PTR oddArr[esi]
	cmp ax, WORD PTR oddArr[esi+4]
	jb L2
	jmp L3
L2: mov eax, oddArr[esi]
	mov ebx, oddArr[esi+4]
	mov oddArr[esi], ebx
	mov oddArr[esi+4], eax
L3: add esi, 4
	sub ecx, 1
	cmp ecx, 0
	jg L1
	pop ecx
	loop L5
	ret
OddSort ENDP

EvenSort PROC USES ecx eax ebx esi
	mov ecx, evenLen
	sub ecx, 1
L5:	push ecx
	mov esi, 0
L1:	mov ax, WORD PTR evenArr[esi+2]
	cmp ax, WORD PTR evenArr[esi+6]
	jb L2
	ja L3
	mov ax, WORD PTR evenArr[esi]
	cmp ax, WORD PTR evenArr[esi+4]
	ja L2
	jmp L3
L2: mov eax, evenArr[esi]
	mov ebx, evenArr[esi+4]
	mov evenArr[esi], ebx
	mov evenArr[esi+4], eax
L3: add esi, 4
	sub ecx, 1
	cmp ecx, 0
	jg L1
	pop ecx
	loop L5
	ret
EvenSort ENDP

MakeOddArr PROC USES ecx eax esi edi edx
	mov edx, 0
	mov ecx, LenData
	mov eax, 0
	mov esi, 0
	mov edi, 0
L1:	mov eax, ArrData[esi]
	mov oddArr[edi], eax
	add esi, 8
	add edi, 4
	inc edx
	sub ecx, 2
	cmp ecx, 0
	jg L1
	mov oddLen, edx
	ret
MakeOddArr ENDP

MakeEvenArr PROC USES ecx eax esi edi
	mov edx, 0
	mov ecx, LenData
	sub ecx, 1
	mov eax, 0
	mov esi, 4
	mov edi, 0
L1:	mov eax, ArrData[esi]
	mov evenArr[edi], eax
	add esi, 8
	add edi, 4
	inc edx
	sub ecx, 2
	cmp ecx, 0
	jg L1
	mov evenLen, edx
	ret
MakeEvenArr ENDP

BeforeS PROC USES edx esi ecx eax
	mov edx, OFFSET prompt1
	call WriteString
	mov esi, 0
	mov ecx, LenData
	sub ecx, 1
L1:	mov eax, ArrData[esi]
	call WriteHex
	call Comma
	add esi, 4
	loop L1
	mov eax, ArrData[esi]
	call WriteHex
	call Crlf
	ret
BeforeS ENDP

AfterS PROC USES edx
	mov edx, OFFSET prompt2
	call WriteString
	mov esi, 0
	mov ecx, LenNew
	sub ecx, 1
L1:	mov eax, NewArr[esi]
	call WriteHex
	call Comma
	add esi, 4
	loop L1
	mov eax, NewArr[esi]
	call WriteHex
	call Crlf
	ret
AfterS ENDP

Comma PROC USES edx
	mov edx, OFFSET prompt4
	call WriteString
	ret
Comma ENDP

Bye PROC USES edx
	mov edx, OFFSET prompt3
	call WriteString
	ret
Bye ENDP

ExepHandle PROC USES eax edx ebx
	cmp LenData, 1
	je L1
	cmp LenData, 2
	je L2
	cmp LenData, 3
	je L3
	jmp Quit
L1: mov eax, ArrData[0]
	mov edx, OFFSET prompt1
	call WriteString
	call WriteHex
	call Crlf
	mov edx, OFFSET prompt2
	call WriteString
	call WriteHex
	call Crlf
	call Bye
	exit
L2: mov edx, OFFSET prompt1
	call WriteString
	mov eax, ArrData[0]
	call WriteHex
	call Comma
	mov eax, ArrData[4]
	call WriteHex
	call Crlf
	mov edx, OFFSET prompt2
	call WriteString
	mov eax, ArrData[0]
	call WriteHex
	call Comma
	mov eax, ArrData[4]
	call WriteHex
	call Crlf
	call Bye
	exit
L3: mov edx, OFFSET prompt1
	call WriteString
	mov eax, ArrData[0]
	call WriteHex
	call Comma
	mov eax, ArrData[4]
	call WriteHex
	call Comma
	mov eax, ArrData[8]
	call WriteHex
	call Crlf
	mov ax, WORD PTR ArrData[2]
	cmp ax, WORD PTR ArrData[10]
	ja L4
	jb L3
	mov ax, WORD PTR ArrData[0]
	cmp ax, WORD PTR ArrData[8]
	jb L4
	jmp L5
L4: mov eax, ArrData[0]
	mov ebx, ArrData[8]
	mov ArrData[0], ebx
	mov ArrData[8], eax
L5: mov edx, OFFSET prompt2
	call WriteString
	mov eax, ArrData[0]
	call WriteHex
	call Comma
	mov eax, ArrData[4]
	call WriteHex
	call Comma
	mov eax, ArrData[8]
	call WriteHex
	call Crlf
	call Bye
	exit
Quit:
	ret
ExepHandle ENDP

END main