ORG 00H
	P0M1 EQU 0B1H
	P0M2 EQU 0B2H
	P1M1 EQU 0B3H
	P1M2 EQU 0B4H
	P3M1 EQU 0ACH
	P3M2 EQU 0ADH
	ADCCON0 EQU 0E8H
	ADCCON1 EQU 0E1H  
	ADCF EQU 0EFH
	ADCS EQU 0EEH
	ADCRH EQU 0C3H
	ADCRL EQU 0C2H
	ADCEN EQU 0E1H
	
		
	MOV P0M1,#0H       
	MOV P0M2,#0FFH       
	MOV P1M1,#0H        
	MOV P1M2,#0FFH            
	MOV P3M1,#0FFH      
	MOV P3M2,#0H

	
	//ADC PIN ON READ THE DATA
	ORL ADCCON0,#00000001B       
	ORL ADCCON1,#00000001B 
	
MAIN: MOV DPTR,#00H
	  CLR A
	  MOV R0,A
	  MOV R1,A
	  MOV R2,A
	  MOV R3,A
	  MOV R4,#250
	  ACALL ADC_READ0
	  ACALL ADC_READ1
	  ACALL F906_ADDITION
	  ACALL EA6_ADDITION
	  ACALL SEPRATION
	  ACALL ADDITION_1F3E0C
	  ACALL MULTIPLICATION
	  ACALL MEREGE
	  ACALL DIVISION
	  SJMP MAIN
	  

ADC_READ0:  CLR ADCF
		   SETB ADCS
		   ;M1:JNB ADCF,M1
		   MOV A,#0FFH;ADCRH
		   ADD A,R0
		   JNC NEXT0
		   INC R1
NEXT0:	   MOV R0,A
		   MOV A,#0FH;ADCRL
		   ADD A,R2
		   JNC NEXT1
		   INC R3
NEXT1:	   MOV R2,A
		   DJNZ R4,ADC_READ0
		   MOV 32,R0
		   MOV 33,R1
		   MOV 34,R2
		   MOV 35,R3
		   CLR A
		   MOV R0,A
		   MOV R1,A
		   MOV R2,A
		   MOV R3,A
		   MOV R4,#250
		   RET
		   
ADC_READ1:  CLR ADCF
		   SETB ADCS
		   ;M2:JNB ADCF,M2
		   MOV A,#0FFH;ADCRH
		   ADD A,R0
		   JNC NEXT2
		   INC R1
NEXT2:	   MOV R0,A
		   MOV A,#0FH;ADCRL
		   ADD A,R2
		   JNC NEXT3
		   INC R3
NEXT3:	   MOV R2,A
		   DJNZ R4,ADC_READ1
		   MOV 36,R0
		   MOV 37,R1
		   MOV 38,R2
		   MOV 39,R3
		   CLR A
		   MOV R0,A
		   MOV R1,A
		   MOV R2,A
		   MOV R3,A
		   MOV R4,A
		   RET
//FF= R0 ADD 06 32,36
//0F= R2 ADD A6 34,38
//FF= R1 CY F9  33,37
//0F= R3 CY 0E	35,39

F906_ADDITION:
	MOV A,32
	MOV B,36
	ADD A,B
	JNC J1
	INC R0
	MOV 40,R0
J1:	MOV 41,A				;0C
	MOV A,33
	MOV B,37
	ADD A,B
	JNC J2
	INC R1
	MOV 42,R1				;1
J2:	MOV B,40
	ADD A,B
	MOV 43,A				;F2
	CLR A
	MOV R0,A
	MOV R1,A
	RET

EA6_ADDITION:
	MOV A,34
	MOV B,38
	ADD A,B
	JNC J3
	INC R0
	MOV 44,R0
J3:	MOV 45,A				;4C
	MOV A,35
	MOV B,39
	ADD A,B
	JNC J4
	INC R1
	MOV 46,R1
J4:	MOV B,44
	ADD A,B
	MOV 47,A				;1D
	RET
	

SEPRATION:
	//0C
	MOV A,41
	ANL A,#11110000B
	SWAP A
	MOV 48,A				;0
	MOV A,41
	ANL A,#00001111B
	MOV 49,A				;C
	//F2
	MOV A,43
	ANL A,#11110000B
	SWAP A
	MOV 50,A				;0F
	MOV A,43
	ANL A,#00001111B
	MOV 51,A				;02
	//4C
	MOV A,45
	ANL A,#11110000B
	SWAP A
	MOV 52,A			    ;04
	MOV A,45
	ANL A,#00001111B
	MOV 53,A			    ;0C---------------------1F3E0C
	//1D
	MOV A,47
	ANL A,#11110000B
	SWAP A
	MOV 54,A				;01
	MOV A,47
	ANL A,#00001111B
	MOV 55,A				;0D
	RET

ADDITION_1F3E0C:
	
	//C+4
	MOV A,52	;C
	MOV B,49	;4
	ADD A,B		
	MOV 56,A	;10
	ANL A,#11110000B
	SWAP A
	MOV 57,A	;1
	MOV A,56	;10
	ANL A,#00001111B
	MOV 58,A	;0
	//0+D
	MOV A,48	;0
	MOV B,55	;D
	ADD A,B	
	MOV B,57
	ADD A,B		
	MOV 59,A	;E
	ANL A,#11110000B
	SWAP A
	MOV 60,A	;0
	MOV A,59
	ANL A,#00001111B
	MOV 61,A	;E
	//2+1
	MOV A,54	;1
	MOV B,51	;2
	ADD A,B
	MOV B,60
	ADD A,B
	MOV 62,A	;3
	ANL A,#11110000B
	SWAP A
	MOV 63,A	;0
	MOV A,62
	ANL A,#00001111B
	MOV 64,A	;3
	//1F3E0C 42,50,64,61,58,53
/*	MOV A,53 	;C
	MOV B,58	;0
	MOV A,64	;03
	MOV B,61	;0E
	MOV A,42	;01
	MOV B,50	;0F */
	RET
	
MULTIPLICATION:

	//0C X 2
	MOV A,53	;C
	MOV B,#02
	MUL AB
	MOV 65,A	;18
	ANL A,#11110000B
	SWAP A
	MOV 66,A	;1
	MOV A,65
	ANL A,#00001111B
	MOV 67,A	;8--------------------8
	MOV A,58
	MOV B,#02
	MUL AB
	MOV B,66
	ADD A,B
	MOV 68,A	;1
	ANL A,#11110000B
	SWAP A
	MOV 69,A	;0
	MOV A,68
	ANL A,#00001111B
	MOV 70,A	;1--------------------1
	//3E X 2
	MOV A,61
	MOV B,#02
	MUL AB
	MOV 71,A	;1C
	ANL A,#11110000B
	SWAP A
	MOV 72,A	;1
	MOV A,71
	ANL A,#00001111B
	MOV 73,A	;----------------------C
	MOV A,64
	MOV B,#02
	MUL AB
	MOV B,72
	ADD A,B
	MOV 74,A	;7
	ANL A,#11110000B
	SWAP A
	MOV 75,A	;0
	MOV A,74
	ANL A,#00001111B
	MOV 76,A	;----------------------7
	//1F X 2
	MOV A,50
	MOV B,#02
	MUL AB
	MOV 77,A	;1E
	ANL A,#11110000B
	SWAP A
	MOV 78,A	;1
	MOV A,77
	ANL A,#00001111B
	MOV 79,A	;----------------------E
	MOV A,42
	MOV B,#02
	MUL AB
	MOV B,78
	ADD A,B
	MOV 80,A	;-----------------------3

RET
	
MEREGE:
	MOV A,80
	SWAP A
	MOV B,79
	ORL A,B
	MOV 81,A	;3E
	RET

DIVISION:
	MOV A,81
	MOV B,#10
	DIV AB
	MOV 83,A	;6
	MOV 84,B	;2
	MOV A,84
	SWAP A
	MOV B,76
	ORL A,B		;27
	MOV B,#10
	DIV AB
	MOV 85,A	;3
	MOV 86,B	;9
	MOV A,86
	SWAP A
	MOV B,73
	ORL A,B		;9C
	MOV B,#10
	DIV AB
	MOV 87,A	;F
	MOV 88,B	;6
	MOV A,88
	SWAP A
	MOV B,70
	ORL A,B		;61
	MOV B,#10
	DIV AB
	MOV 89,A	;9
	MOV 90,B	;7
	MOV A,90
	SWAP A
	MOV B,67
	ORL A,B		;78
	MOV B,#10
	DIV AB
	MOV 91,A	;C
	MOV 92,B	;0
	RET
	
	








END	   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   
		   