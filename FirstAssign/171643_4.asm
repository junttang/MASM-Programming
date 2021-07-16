TITLE Copy a String in Reverse Order

; Assembly Programming HW1 Task4
; Student ID : 20171643
; Name : Park Junhyeok

INCLUDE irvine32.inc

.data
INCLUDE hw4.inc

.code
main PROC
	mov esi,SIZEOF source - 2
	mov edi,0
	mov ecx,SIZEOF source - 1
	L1:
		mov al,[source + esi]
		mov [target + edi],al
		dec esi
		inc edi
		loop L1
	mov [target + edi], 0
	mov edx, OFFSET target
	call WriteString
	exit
main ENDP
END main