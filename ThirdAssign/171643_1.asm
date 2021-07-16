TITLE Task 1 - Septenary to Decimal

; Assembly Programming HW2 Task1
; Student ID : 20171643
; Name : Park Junhyeok

INCLUDE irvine32.inc

.data
var1 BYTE "65",0
seven DWORD 7

.code
main PROC
	mov esi, LENGTHOF var1 - 2
	mov ecx, LENGTHOF var1 - 1
	mov eax, 1
	mov ebx, 0
	mov edx, 0
L1: mov dl, var1[esi]
	sub dl, 48
	push eax
	mul edx
	add ebx, eax
	pop eax
	mul seven
	sub esi, TYPE var1
	loop L1
	mov eax, ebx
	call DumpRegs
	exit
main ENDP
END main