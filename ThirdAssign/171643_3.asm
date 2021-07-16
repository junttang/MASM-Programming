TITLE Task 3 - Searching the Word

; Assembly Programming HW2 Task3
; Student ID : 20171643
; Name : Park Junhyeok

INCLUDE irvine32.inc

.data
prompt1 BYTE "TYPE_A_String: ", 0
prompt2 BYTE "A_Word_for_Search: ", 0
prompt3 BYTE "Found", 0dh, 0ah, 0
prompt4 BYTE "Not Found", 0dh, 0ah, 0
prompt5 BYTE "Changed : ", 0
prompt6 BYTE "Bye!", 0dh, 0ah, 0

blank BYTE " "
str1 BYTE 42 DUP(0)
strSize DWORD ?
word1 BYTE 42 DUP(0)
wordSize DWORD ?

.code
main PROC
L0: pushad			; to preserve the initial status
	call InputStr
	push eax
	mov eax, strSize
	cmp eax, 0
	je Quit			; terminate if Enter key pressed
	pop eax
	call InputWord
	push eax
	mov eax, wordSize
	cmp eax, 0
	je Quit
	pop eax
	call Find
	call Crlf
	popad
	loop L0
Quit:
	call Bye
	exit
main ENDP

; Find Procedure : find the corresponding word in string
Find PROC
	mov esi, 0
	mov ecx, strSize
L1:	push ecx
	push esi
	mov edi, 0
	mov eax, 0
	mov ecx, wordSize
L2:	cmp edi, 0
	je L9
	jmp L10
L9: mov bl, str1[esi - 1]
	cmp bl, " "
	jne L3
L10:mov bl, str1[esi]
	cmp bl, word1[edi]
	jne L3
	cmp bl, " "
	je L3
	add eax, 1
	cmp eax, wordSize
	jne L4
	mov dl, str1[esi+1]
	cmp dl, " "
	je L5
	cmp dl, "."
	je L5
	cmp dl, 0
	je L5
	jmp L4
L5: call Minimize
L6:	cmp edi, esi
	jle L7
	cmp edi, ebx
	jg L7
	jmp L8
L7:	mov al, str1[edi]
	call WriteChar
L8:	inc edi
	loop L6
L4:	inc esi
	inc edi
	loop L2
L3:	pop esi
	pop ecx
	inc esi
	loop L1
	cmp edx, 50
	je LQ
	call NoFound
	call Change
	mov edx, OFFSET str1
	call WriteString
LQ:	ret
Find ENDP

; Minimize Procedure : to minimize the code lines in 'Find'
Minimize PROC
	mov ebx, esi
	sub esi, wordSize
	mov ecx, strSize
	mov edi, 0
	inc ebx
	call Found
	call Change
	mov edx, 50
	ret
Minimize ENDP

; InputStr Procedure : read the string
InputStr PROC USES edx eax
Again:
	mov edx, OFFSET prompt1
	call WriteString
	mov edx, OFFSET str1
	mov ecx, SIZEOF str1
	call ReadString
	mov strSize, eax
	cmp eax, 40
	jg Again
	ret
InputStr ENDP

; InputWord Procedure : read the word
InputWord PROC USES edx eax
	mov edx, OFFSET prompt2
	call WriteString
	mov edx, OFFSET word1
	mov ecx, SIZEOF word1
	call ReadString
	mov wordSize, eax
	ret
InputWord ENDP

; Procedure related to printing messages
Change PROC USES edx
	mov edx, OFFSET prompt5
	call WriteString
	ret
Change ENDP

; Procedure related to printing messages
Found PROC USES edx
	mov edx, OFFSET prompt3
	call WriteString
	ret
Found ENDP

; Procedure related to printing messages
NoFound PROC USES edx
	mov edx, OFFSET prompt4
	call WriteString
	ret
NoFound ENDP

; Procedure related to printing messages
Bye PROC USES edx
	mov edx, OFFSET prompt6
	call WriteString
	ret
Bye ENDP
END main