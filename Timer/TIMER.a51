ORG 00H

  MOV TMOD, #01H
AGAIN1:	MOV P1,#0FFH
		ACALL DELAY
		MOV P1,#00H
		ACALL DELAY
		SJMP AGAIN1

//5ms Delay 
// DELAY/TIME PERIOD 0.75
// (655336-COUNT OF DELAY) CONVERT HEX LOAD 
//EX E5F6 TH=E5 AND TL=F6

DELAY:	MOV TL0, #0F6H
		MOV TH0,#0E5H
		SETB TR0
  AGAIN:	JNB TF0, AGAIN
		CLR TR0
		CLR TF0
		RET
		END