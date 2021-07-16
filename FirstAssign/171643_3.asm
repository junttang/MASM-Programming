TITLE Exponential Power

; Assembly Programming HW1 Task3
; Student ID : 20171643
; Name : Park Junhyeok

INCLUDE irvine32.inc

.data
INCLUDE hw3.inc
powerNum DWORD 1
powerCnt DWORD ?
count DWORD ?

.code
main PROC
	mov edx, X
	mov powerCnt, edx
	mov ecx, Y
	L1:
		mov count, ecx
		mov eax, 0
		mov ecx, powerCnt
	L2:
		add eax, powerNum
		loop L2
		mov powerNum, eax
		mov ecx, count
		loop L1
	mov ecx, X
	mov powerNum, 1
	mov edx, Y
	mov powerCnt, edx
	L3:
		mov count, ecx
		mov ebx, 0
		mov ecx, powerCnt
	L4:
		add ebx, powerNum
		loop L4
		mov powerNum, ebx
		mov ecx, count
		loop L3
	call DumpRegs
	exit
main ENDP
END main