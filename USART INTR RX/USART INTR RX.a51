ORG 00H
		LJMP MAIN
	P1M1 EQU 0B3H
	P1M2 EQU 0B4H	
ORG 23H
		LJMP SERIAL
ORG 30H
MAIN:	
		MOV P1M1, #0FFH
		MOV P1M2, #00H
		MOV TMOD, #20H
		MOV TH1, #0FDH
		MOV SCON, #50H
		MOV IE, #10010000B
		SETB TR1
BACK:   MOV A, P1;
		MOV SBUF,A;
		MOV P2, A;
SJMP BACK
ORG 100
SERIAL: JB RI, TRANS
        MOV R0, SBUF
		CLR RI
		RETI
TRANS:	CLR TI
		RETI
		END
		

	