TITLE Task 2 - Get Frequencies

; Assembly Programming HW3 Task2
; Student ID : 20171643
; Name : Park Junhyeok

INCLUDE irvine32.inc

Get_frequencies PROTO strArr:DWORD, tableArr:DWORD

.data
target BYTE "AAEBDCFBBC", 0
freqTable DWORD 256 DUP(0)

prompt1 BYTE "String: ", 0
prompt2 BYTE "ASCII[", 0
prompt3 BYTE "         << FreqTable >>", 0dh, 0ah, 0
prompt4 BYTE "] - Index(", 0
prompt5 BYTE "), Freq: ", 0

.code
main PROC
	INVOKE Get_frequencies, ADDR target, ADDR freqTable
	exit
main ENDP

Get_frequencies PROC strArr:DWORD, tableArr:DWORD
	mov edx, strArr
	call SString
	call WriteString
	call STable

	mov esi, strArr
	mov ecx, 0

	mov al, [edx]
.WHILE al > 0
	inc edx
	mov al, [edx]
	inc ecx
.ENDW

L1:	mov al, [esi]
	push ecx
	mov edx, 0
	mov ecx, 256
L2:	cmp al, dl
	jne L3
	mov edi, tableArr
	add edi, edx
	add edi, edx
	add edi, edx
	add edi, edx
	mov ebx, [edi]
	add ebx, 1
	mov [edi], ebx
L3: inc edx
	loop L2
	pop ecx
	add esi, 1
	loop L1 

	mov ecx, 256
	mov eax, 0
	mov edi, tableArr
L4:	mov ebx, [edi]
	cmp ebx, 0
	je L5
	call SAscii
	call WriteChar
	call SIndex
	call WriteHex
	call SFreq
	push eax
	mov eax, ebx
	call WriteDec
	call Crlf
	pop eax
L5:	add edi, 4
	inc eax
	loop L4
	ret
Get_frequencies ENDP

SString PROC USES edx
	mov edx, OFFSET prompt1
	call WriteString
	ret
SString ENDP

STable PROC USES edx
	call Crlf
	call Crlf
	mov edx, OFFSET prompt3
	call WriteString
	ret
STable ENDP

SAscii PROC USES edx
	mov edx, OFFSET prompt2
	call WriteString
	ret
SAscii ENDP

SIndex PROC USES edx
	mov edx, OFFSET prompt4
	call WriteString
	ret
SIndex ENDP

SFreq PROC USES edx
	mov edx, OFFSET prompt5
	call WriteString
	ret
SFreq ENDP

END main