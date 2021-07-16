TITLE Summing the Gaps between Array Values

; Assembly Programming HW1 Task1
; Student ID : 20171643
; Name : Park Junhyeok

INCLUDE irvine32.inc

.data
INCLUDE hw1.inc

.code
main PROC
	mov eax,0
	mov esi,0
	mov ecx,SIZEOF array1 / 4 - 1
	L1:
		mov edx, array1[esi]
		add esi, 4
		mov ebx, array1[esi]
		sub ebx, edx
		add eax, ebx
		loop L1
	call DumpRegs
	exit
main ENDP
END main