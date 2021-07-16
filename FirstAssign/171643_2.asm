TITLE Fibonacci Numbers

; Assembly Programming HW1 Task2
; Student ID : 20171643
; Name : Park Junhyeok

INCLUDE irvine32.inc

.data
INCLUDE hw2.inc

; 1 1 2 3 5 8 13 21
.code
main PROC
	mov ebx,1	;Fib(1)
	mov edx,1	;Fib(2)
	dec fib
	mov ecx,fib
	L1:
		mov eax,0
		add eax,ebx
		add eax,edx
		xchg edx,eax
		mov ebx,eax
		loop L1
	call DumpRegs
	exit
main ENDP
END main