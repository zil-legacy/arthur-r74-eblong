
	.SEGMENT "0"


	.FUNCT	FIND-DESCENDANTS:ANY:2:2,PARENT,FLAGS,F,FOBJ
	SET	'F,FINDER
	EQUAL?	PARENT,GLOBAL-HERE \?CND1
	SET	'PARENT,HERE
?CND1:	FIRST?	PARENT >FOBJ \TRUE
?PRG6:	CALL2	VISIBLE?,FOBJ
	ZERO?	STACK /?CND8
	BTST	FLAGS,8 /?CND10
	BTST	FLAGS,1 \?PRF16
	PUSH	1
	JUMP	?PEN14
?PRF16:	PUSH	0
?PEN14:	CALL	MATCH-OBJECT,FOBJ,F,STACK
	ZERO?	STACK /FALSE
?CND10:	BTST	FLAGS,4 \?CND8
	FIRST?	FOBJ \?CND8
	EQUAL?	FOBJ,WINNER /?CND8
	FSET?	FOBJ,SEARCHBIT \?PRD24
	FSET?	FOBJ,OPENBIT /?CCL18
	FSET?	FOBJ,TRANSBIT /?CCL18
?PRD24:	FSET?	FOBJ,SURFACEBIT \?CND8
?CCL18:	BTST	FLAGS,1 \?CCL33
	PUSH	5
	JUMP	?CND31
?CCL33:	PUSH	4
?CND31:	CALL	FIND-DESCENDANTS,FOBJ,STACK
	ZERO?	STACK /FALSE
?CND8:	NEXT?	FOBJ >FOBJ /?PRG6
	RTRUE	


	.FUNCT	EXCLUDED?:ANY:2:2,FOBJ,F,EXC,PHRASE,CT,VEC,VV
	GET	F,8 >EXC
	ZERO?	EXC /FALSE
	GET	EXC,3 >PHRASE
?PRG4:	ZERO?	PHRASE /?CND6
	GET	PHRASE,1 >CT
	ADD	PHRASE,6 >VEC
?PRG8:	DLESS?	'CT,0 \?CND10
	SET	'VV,FALSE-VALUE
	JUMP	?REP9
?CND10:	GET	VEC,0
	EQUAL?	FOBJ,STACK \?CND12
	SET	'VV,TRUE-VALUE
?REP9:	ZERO?	VV \TRUE
?CND6:	GET	EXC,1 >EXC
	ZERO?	EXC /FALSE
	GET	EXC,3 >PHRASE
	JUMP	?PRG4
?CND12:	ADD	VEC,4 >VEC
	JUMP	?PRG8


	.FUNCT	INVALID-OBJECT?:ANY:1:1,OBJ
	RFALSE	


	.FUNCT	MATCH-OBJECT:ANY:3:3,FOBJ,F,INCLUDE?,NOUN,ADJS,APP,TB,RES,TMP,?TMP1
	GET	F,9 >RES
	FSET?	FOBJ,INVISIBLE /TRUE
	GET	F,6 >NOUN
	EQUAL?	NOUN,FALSE-VALUE,W?ONE /?PRD6
	GETPT	FOBJ,P?SYNONYM >TB
	ZERO?	TB /TRUE
	PTSIZE	TB
	DIV	STACK,2
	INTBL?	NOUN,TB,STACK \TRUE
?PRD6:	GET	F,7 >ADJS
	ZERO?	ADJS /?PRD11
	CALL	CHECK-ADJS,FOBJ,F,ADJS
	ZERO?	STACK /TRUE
?PRD11:	GET	F,5 >ADJS
	ZERO?	ADJS /?PRD14
	CALL	CHECK-ADJS,FOBJ,F,ADJS
	ZERO?	STACK /TRUE
?PRD14:	CALL	EXCLUDED?,FOBJ,F
	ZERO?	STACK \TRUE
	GET	F,1
	BTST	STACK,1 /?CTR2
	CALL2	INVALID-OBJECT?,FOBJ
	ZERO?	STACK \TRUE
?CTR2:	ZERO?	INCLUDE? /TRUE
	GET	F,5 >ADJS
	ZERO?	ADJS /?CCL24
	GETPT	FOBJ,P?ADJECTIVE >TMP
	ZERO?	TMP /?CCL24
	GET	ADJS,4 >?TMP1
	PTSIZE	TMP
	DIV	STACK,2
	EQUAL?	?TMP1,STACK \?CCL24
	PUT	RES,1,1
	PUT	RES,2,FALSE-VALUE
	PUT	RES,4,FOBJ
	EQUAL?	FOBJ,HERE \FALSE
	PUT	RES,4,GLOBAL-HERE
	RFALSE	
?CCL24:	GET	F,0 >APP
	ZERO?	APP /?CCL32
	GET	F,1
	BTST	STACK,1 /?CCL32
	GET	RES,1
	ZERO?	STACK /?CTR36
	GET	F,2
	ZERO?	STACK /?CCL37
?CTR36:	CALL	ADD-OBJECT,FOBJ,F
	RSTACK	
?CCL37:	CALL	TEST-OBJECT,FOBJ,APP,F
	ZERO?	STACK /FALSE
	GET	RES,1
	EQUAL?	STACK,1 \?CCL44
	GET	RES,4
	CALL	TEST-OBJECT,STACK,APP,F
	ZERO?	STACK \?CCL47
	PUT	RES,4,FOBJ
	EQUAL?	FOBJ,HERE \TRUE
	PUT	RES,4,GLOBAL-HERE
	RTRUE	
?CCL47:	CALL	ADD-OBJECT,FOBJ,F
	RSTACK	
?CCL44:	CALL	ADD-OBJECT,FOBJ,F
	RSTACK	
?CCL32:	ZERO?	APP \?CCL51
	GET	F,1
	BTST	STACK,1 \?CTR53
	GET	F,2
	ZERO?	STACK /TRUE
?CTR53:	CALL	ADD-OBJECT,FOBJ,F
	RSTACK	
?CCL51:	CALL	TEST-OBJECT,FOBJ,APP,F
	ZERO?	STACK /TRUE
	CALL	ADD-OBJECT,FOBJ,F
	RSTACK	


	.FUNCT	TEST-OBJECT:ANY:3:3,FOBJ,APP,F,N,NN,?TMP1
	BAND	APP,65280
	ZERO?	STACK \?CCL3
	BTST	APP,128 \?CCL6
	BAND	APP,63
	FSET?	FOBJ,STACK /FALSE
	RTRUE	
?CCL6:	FSET?	FOBJ,APP /TRUE
	RFALSE	
?CCL3:	GET	APP,1
	BTST	STACK,256 \?CND12
	GET	APP,1
	BAND	STACK,63
	GETP	FOBJ,STACK >?TMP1
	GET	APP,2
	EQUAL?	?TMP1,STACK /TRUE
	RFALSE	
?CND12:	GET	APP,0 >N
?PRG17:	GET	APP,N >NN
	BTST	NN,128 \?CCL21
	BAND	NN,63
	FSET?	FOBJ,STACK /?CND19
	RTRUE	
?CCL21:	FSET?	FOBJ,NN /TRUE
?CND19:	DLESS?	'N,1 \?PRG17
	RFALSE	


	.FUNCT	ADD-OBJECT:ANY:2:2,OBJ,F,VEC,NC,DOIT?,SYN,WHICH,?TMP1
	GET	F,9 >VEC
	SET	'DOIT?,TRUE-VALUE
	GET	F,3 >SYN
	GET	F,4 >WHICH
	EQUAL?	OBJ,HERE \?CND1
	SET	'OBJ,GLOBAL-HERE
?CND1:	GET	F,2
	ZERO?	STACK \?CND3
	ZERO?	SYN /?CND3
	GET	VEC,1
	EQUAL?	1,STACK \?CND3
	CALL	MULTIPLE-EXCEPTION?,OBJ,SYN,WHICH,F
	ZERO?	STACK /?CCL10
	SET	'DOIT?,FALSE-VALUE
	JUMP	?CND3
?CCL10:	GET	VEC,4
	CALL	MULTIPLE-EXCEPTION?,STACK,SYN,WHICH,F
	ZERO?	STACK /?CND3
	PUT	VEC,4,OBJ
	SET	'DOIT?,FALSE-VALUE
?CND3:	ZERO?	DOIT? /TRUE
	GET	F,2
	ZERO?	STACK /?PRD17
	GET	F,3
	ZERO?	STACK /?PRD17
	GET	F,3 >?TMP1
	GET	F,4
	CALL	MULTIPLE-EXCEPTION?,OBJ,?TMP1,STACK,F
	ZERO?	STACK \TRUE
?PRD17:	CALL	NOT-IN-FIND-RES?,OBJ,VEC >WHICH
	ZERO?	WHICH /TRUE
	GET	VEC,1
	ADD	1,STACK
	PUT	VEC,1,STACK
	PUT	WHICH,0,OBJ
	GET	F,2
	EQUAL?	STACK,NP-QUANT-A /FALSE
	RTRUE	


	.FUNCT	NOT-IN-FIND-RES?:ANY:2:3,OBJ,VEC,NO-CHANGE?,CT,SZ,ANS,NVEC,NEW-OBJECT
	GET	VEC,1 >CT
	GET	VEC,0 >SZ
?PRG1:	ADD	VEC,8 >ANS
	LESS?	CT,1 \?CCL5
	RETURN	ANS
?CCL5:	GRTR?	CT,SZ \?CCL7
	SUB	CT,SZ >CT
	JUMP	?CND3
?CCL7:	SET	'SZ,CT
?CND3:	INTBL?	OBJ,ANS,SZ /FALSE
	GET	VEC,2 >NVEC
	ZERO?	NVEC /?CCL12
	SET	'VEC,NVEC
	SET	'SZ,FIND-RES-MAXOBJ
	JUMP	?PRG1
?CCL12:	LESS?	SZ,FIND-RES-MAXOBJ \?CCL14
	MUL	2,SZ
	ADD	ANS,STACK
	RSTACK	
?CCL14:	ZERO?	NO-CHANGE? \TRUE
	SET	'SZ,FIND-RES-MAXOBJ
	CALL	DO-PMEM-ALLOC,7,9 >NEW-OBJECT
	SET	'NVEC,NEW-OBJECT
	PUT	VEC,2,NVEC
	ADD	NVEC,8
	RSTACK	


	.FUNCT	EVERYWHERE-VERB?:ANY:0:2,WHICH,SYNTAX,SYN
	ASSIGNED?	'WHICH /?CND1
	GET	FINDER,4 >WHICH
?CND1:	ASSIGNED?	'SYNTAX /?CND3
	GET	PARSE-RESULT,3 >SYNTAX
?CND3:	EQUAL?	WHICH,1 \?CCL7
	GETB	SYNTAX,5 >SYN
	JUMP	?CND5
?CCL7:	GETB	SYNTAX,9 >SYN
?CND5:	BTST	SYN,128 \FALSE
	BTST	SYN,64 \TRUE
	RFALSE	


	.FUNCT	MULTIPLE-EXCEPTION?:ANY:4:4,OBJ,SYNTAX,WHICH,F,L,VB
	LOC	OBJ >L
	GET	SYNTAX,0 >VB
	EQUAL?	OBJ,FALSE-VALUE,ROOMS \?CCL3
	INC	'P-NOT-HERE
	RTRUE	
?CCL3:	CALL	EVERYWHERE-VERB?,WHICH,SYNTAX
	ZERO?	STACK \?CCL5
	CALL2	ACCESSIBLE?,OBJ
	ZERO?	STACK /TRUE
?CCL5:	EQUAL?	VB,V?TAKE \?CCL9
	GET	F,6
	ZERO?	STACK \?CCL9
	EQUAL?	WHICH,1 \?CCL9
	FSET?	OBJ,TAKEBIT /?CCL15
	FSET?	OBJ,TRYTAKEBIT \TRUE
?CCL15:	EQUAL?	L,WINNER /TRUE
	RFALSE	
?CCL9:	EQUAL?	VB,V?DROP \FALSE
	IN?	OBJ,WINNER \TRUE
	RFALSE	


	.FUNCT	CHECK-ADJS-THERE?:ANY:1:1,OWNER,TMP
	GET	OWNER-SR-THERE,1 >TMP
	ZERO?	TMP /FALSE
	INTBL?	OWNER,OWNER-SR-THERE+8,TMP /TRUE
	RFALSE	


	.FUNCT	CHECK-ADJS:ANY:3:3,OBJ,F,ADJS,CNT,TMP,OWNER,ID,VEC,CT,ADJ,FL,OADJS,NUM,?TMP1
	GETP	OBJ,P?OWNER >OWNER
	GETB	ADJS,1
	EQUAL?	STACK,2 /?CCL2
	GET	ADJS,2 >TMP
	ZERO?	TMP /?CND1
?CCL2:	SET	'ID,OWNER
	LESS?	0,ID \?CCL7
	SET	'ID,OWNER
	GRTR?	ID,LAST-OBJECT /?CCL7
	EQUAL?	OWNER,TMP /?CND1
	EQUAL?	OWNER,ROOMS \?CCL14
	GET	OWNER-SR-HERE,1
	ZERO?	STACK /?CCL17
	GET	OWNER-SR-HERE,4 >ID
	JUMP	?CND1
?CCL17:	GET	OWNER-SR-THERE,1
	ZERO?	STACK /FALSE
	GET	OWNER-SR-THERE,4 >ID
	JUMP	?CND1
?CCL14:	GET	OWNER-SR-HERE,1 >TMP
	ZERO?	TMP \?CCL21
	CALL2	CHECK-ADJS-THERE?,OWNER
	ZERO?	STACK \?CND1
	RFALSE	
?CCL21:	INTBL?	OWNER,OWNER-SR-HERE+8,TMP /?CND1
	CALL2	CHECK-ADJS-THERE?,OWNER
	ZERO?	STACK \?CND1
	RFALSE	
?CCL7:	ZERO?	OWNER /?CCL28
	GET	OWNER-SR-HERE,1 >CNT
	ZERO?	CNT \?CCL31
	SET	'ID,PLAYER
	JUMP	?CND1
?CCL31:	ADD	OWNER,2 >TMP
	SET	'VEC,OWNER-SR-HERE+8
?PRG33:	DLESS?	'CNT,0 /FALSE
	GET	VEC,0 >?TMP1
	GET	OWNER,0
	INTBL?	?TMP1,TMP,STACK >ID \?CCL39
	GET	ID,0 >ID
	JUMP	?CND1
?CCL39:	ADD	VEC,2 >VEC
	JUMP	?PRG33
?CCL28:	LESS?	0,TMP \?CCL41
	GRTR?	TMP,LAST-OBJECT /?CCL41
	CALL	HELD?,OBJ,TMP
	ZERO?	STACK \?CND1
	RFALSE	
?CCL41:	GET	OWNER-SR-HERE,1 >TMP
	ZERO?	TMP /FALSE
	LOC	OBJ
	INTBL?	STACK,OWNER-SR-HERE+8,TMP >ID \FALSE
?CND1:	EQUAL?	ID,0,OBJ /?CND50
	GET	F,9
	PUT	STACK,3,ID
?CND50:	GETB	ADJS,1
	EQUAL?	STACK,2 /TRUE
	ADD	ADJS,10 >VEC
	GET	ADJS,4 >CT
	GETPT	OBJ,P?ADJECTIVE >OADJS
	PTSIZE	OADJS
	DIV	STACK,2 >NUM
?PRG54:	DLESS?	'CT,0 /TRUE
	GET	VEC,CT >ADJ
	SET	'ID,ADJ
	EQUAL?	ADJ,W?NO.WORD /?PRG54
	INTBL?	ID,OADJS,NUM /?PRG54
	EQUAL?	ID,W?CLOSED,W?SHUT \?CCL63
	FSET?	OBJ,OPENBIT \?PRG54
?CCL63:	EQUAL?	ID,W?OPEN \FALSE
	FSET?	OBJ,OPENBIT /?PRG54
	RFALSE	


	.FUNCT	SEARCH-IN-LG?:ANY:1:1,OBJ
	RFALSE	


	.FUNCT	EXCLUDE-HERE-OBJECT?:ANY:0:0
	RFALSE	


	.FUNCT	FIND-OBJECTS:ANY:0:3,SEARCH,PARENT,NO-ADJACENT,GLBS,CONT?,N,RES,NEW-OBJECT,FLAG,?PR-FLAG,?TMP1,?TMP2
	ASSIGNED?	'SEARCH /?CND1
	GET	FINDER,4
	EQUAL?	1,STACK \?CCL5
	GET	PARSE-RESULT,3
	GETB	STACK,5 >SEARCH
	JUMP	?CND1
?CCL5:	GET	PARSE-RESULT,3
	GETB	STACK,9 >SEARCH
?CND1:	SET	'CONT?,TRUE-VALUE
	GET	FINDER,9 >RES
	PUT	RES,1,0
	PUT	RES,2,FALSE-VALUE
	ZERO?	PARENT /?CCL8
	CALL	FIND-DESCENDANTS,PARENT,7
	ZERO?	STACK /?CND6
	GET	RES,1
	ZERO?	STACK \?CND6
?CCL8:	ZERO?	PARENT /?CND13
	ZERO?	NO-ADJACENT \?CND13
	GET	FINDER,5 >GLBS
	ZERO?	GLBS \?CCL19
	CALL	DO-PMEM-ALLOC,1,8 >NEW-OBJECT
	PUT	NEW-OBJECT,2,PARENT
	SET	'GLBS,NEW-OBJECT
	PUT	FINDER,5,GLBS
	JUMP	?CND13
?CCL19:	GET	GLBS,2
	ZERO?	STACK \?CND13
	PUT	GLBS,2,PARENT
?CND13:	BTST	SEARCH,128 \?CND21
	BTST	SEARCH,64 /?CND21
	FIRST?	GENERIC-OBJECTS \?CND21
	FIRST?	GENERIC-OBJECTS >NEW-OBJECT /?PRG27
?PRG27:	CALL	MATCH-OBJECT,NEW-OBJECT,FINDER,TRUE-VALUE
	ZERO?	STACK /?REP28
	NEXT?	NEW-OBJECT >NEW-OBJECT /?PRG27
?REP28:	GET	RES,1 >CONT?
	ZERO?	CONT? /?CND21
	EQUAL?	CONT?,1 /TRUE
	RFALSE	
?CND21:	SET	'NEW-OBJECT,FALSE-VALUE
?PRG37:	ZERO?	NEW-OBJECT \?PRD42
	BAND	SEARCH,12
	ZERO?	STACK \?CCL40
?PRD42:	ZERO?	NEW-OBJECT /?CND39
?CCL40:	ZERO?	NEW-OBJECT \?CTR46
	BTST	SEARCH,8 \?CCL47
?CTR46:	SET	'?PR-FLAG,6
	JUMP	?CND45
?CCL47:	SET	'?PR-FLAG,2
?CND45:	ZERO?	NEW-OBJECT \?CTR51
	BAND	SEARCH,12
	ZERO?	STACK /?CCL52
?CTR51:	BOR	1,?PR-FLAG >FLAG
	JUMP	?CND50
?CCL52:	BAND	?PR-FLAG,-2 >FLAG
?CND50:	ZERO?	NEW-OBJECT \?CCL57
	BTST	SEARCH,4 /?CCL57
	BOR	8,FLAG
	JUMP	?CND55
?CCL57:	BAND	FLAG,-9
?CND55:	CALL	FIND-DESCENDANTS,WINNER,STACK >CONT?
?CND39:	ZERO?	NEW-OBJECT \?CCL61
	BAND	SEARCH,3
	ZERO?	STACK /?CND60
?CCL61:	ZERO?	NEW-OBJECT \?CTR65
	BAND	SEARCH,3
	ZERO?	STACK /?CCL66
?CTR65:	SET	'?PR-FLAG,3
	JUMP	?CND64
?CCL66:	SET	'?PR-FLAG,2
?CND64:	ZERO?	NEW-OBJECT \?CTR71
	BTST	SEARCH,2 \?CCL72
?CTR71:	BOR	4,?PR-FLAG >FLAG
	JUMP	?CND70
?CCL72:	BAND	?PR-FLAG,-5 >FLAG
?CND70:	ZERO?	NEW-OBJECT \?CCL77
	BTST	SEARCH,1 /?CCL77
	BOR	8,FLAG
	JUMP	?CND75
?CCL77:	BAND	FLAG,-9
?CND75:	CALL	FIND-DESCENDANTS,HERE,STACK >CONT?
?CND60:	GET	RES,1
	ZERO?	STACK \?CND6
	BTST	SEARCH,15 /?CND80
	ZERO?	NEW-OBJECT \?CND80
	GET	TLEXV,0 >GLBS
	ZERO?	GLBS /?CCL88
	GET	GLBS,4
	ZERO?	STACK \?CTR87
	GET	GLBS,3
	ZERO?	STACK /?CCL88
?CTR87:	SET	'NEW-OBJECT,TRUE-VALUE
	JUMP	?PRG37
?CCL88:	BTST	SEARCH,64 \?CND80
	BTST	SEARCH,128 \FALSE
?CND80:	GETPT	HERE,P?GLOBAL >GLBS
	ZERO?	GLBS /?CND96
	PTSIZE	GLBS
	DIV	STACK,2 >N
?PRG99:	DLESS?	'N,0 /?CND96
	GET	GLBS,N >?PR-FLAG
	CALL	MATCH-OBJECT,?PR-FLAG,FINDER,TRUE-VALUE >CONT?
	ZERO?	CONT? /?CND96
	FIRST?	?PR-FLAG \?PRG99
	BTST	SEARCH,2 \?PRG99
	CALL2	SEARCH-IN-LG?,?PR-FLAG
	ZERO?	STACK /?PRG99
	CALL	FIND-DESCENDANTS,?PR-FLAG,FD-INCLUDE? >CONT?
	ZERO?	CONT? \?PRG99
?CND96:	ZERO?	CONT? /?CND113
	CALL1	EXCLUDE-HERE-OBJECT?
	ZERO?	STACK \?CND113
	CALL	MATCH-OBJECT,HERE,FINDER,TRUE-VALUE >CONT?
?CND113:	ZERO?	CONT? /?CND117
	LOC	PLAYER
	EQUAL?	HERE,STACK /?CND117
	LOC	PLAYER
	GETP	STACK,P?THINGS
	ZERO?	STACK /?CND117
	LOC	PLAYER
	CALL	TEST-THINGS,STACK,FINDER >CONT?
?CND117:	ZERO?	CONT? /?CND122
	GETP	HERE,P?THINGS
	ZERO?	STACK /?CND122
	CALL	TEST-THINGS,HERE,FINDER >CONT?
?CND122:	GET	RES,1
	ZERO?	STACK /?CND126
	SET	'CONT?,FALSE-VALUE
?CND126:	ZERO?	CONT? /?CND128
	BTST	SEARCH,2 \?CCL132
	PUSH	5
	JUMP	?CND130
?CCL132:	PUSH	1
?CND130:	CALL	FIND-DESCENDANTS,GLOBAL-OBJECTS,STACK >CONT?
?CND128:	ZERO?	CONT? /?CND133
	GET	RES,1
	ZERO?	STACK \?CND133
	ZERO?	NO-ADJACENT \?CND133
	GETP	HERE,P?ADJACENT >GLBS
	ZERO?	GLBS /?CND133
	GETB	GLBS,0 >N
?PRG139:	GETB	GLBS,N
	ZERO?	STACK /?CCL143
	DEC	'N
	GETB	GLBS,N
	ICALL	FIND-OBJECTS,1,STACK,TRUE-VALUE
	JUMP	?CND141
?CCL143:	DEC	'N
?CND141:	DLESS?	'N,1 \?PRG139
	GET	RES,1
	ZERO?	STACK /?CND133
	SET	'CONT?,FALSE-VALUE
?CND133:	ZERO?	CONT? /?CND6
	GET	RES,1
	ZERO?	STACK \?CND6
	BTST	SEARCH,128 \?PRD154
	BTST	SEARCH,64 \?CCL149
?PRD154:	GET	PARSE-RESULT,1 >?TMP2
	ADD	WORD-FLAG-TABLE,2 >?TMP1
	GET	WORD-FLAG-TABLE,0
	INTBL?	?TMP2,?TMP1,STACK,132 >FLAG \?CCL159
	GET	FLAG,1
	JUMP	?CND157
?CCL159:	PUSH	FALSE-VALUE
?CND157:	BTST	STACK,512 \?CND6
?CCL149:	SET	'?PR-FLAG,1
?PRG160:	CALL	MATCH-OBJECT,?PR-FLAG,FINDER,TRUE-VALUE
	ZERO?	STACK /?CND6
	IGRTR?	'?PR-FLAG,LAST-OBJECT \?PRG160
?CND6:	GET	RES,1
	EQUAL?	STACK,1 /TRUE
	RFALSE	


	.FUNCT	TEST-THINGS:ANY:2:2,RM,F,CT,GLBS,N,NOUN,V,TTBL,MATCH,I,?TMP2,?TMP1
	GETP	RM,P?THINGS >GLBS
	GETB	GLBS,0 >N
	INC	'GLBS
	GET	F,5 >CT
	ZERO?	CT /?CND1
	GET	CT,4 >CT
?CND1:	GET	F,6 >NOUN
	GET	F,5
	ADD	STACK,10 >V
	SET	'MATCH,FALSE-VALUE
?PRG3:	GET	GLBS,1 >TTBL
	ZERO?	TTBL /?CND5
	ADD	TTBL,1 >?TMP1
	GETB	TTBL,0
	INTBL?	NOUN,?TMP1,STACK \?CND5
	ZERO?	CT \?CCL11
	SET	'MATCH,TRUE-VALUE
	JUMP	?CND9
?CCL11:	GET	GLBS,0 >TTBL
	ZERO?	TTBL /?CND9
	SET	'I,0
?PRG13:	GET	V,I >?TMP2
	ADD	TTBL,1 >?TMP1
	GETB	TTBL,0
	INTBL?	?TMP2,?TMP1,STACK \?CCL17
	SET	'MATCH,TRUE-VALUE
	JUMP	?CND9
?CCL17:	SUB	CT,1
	IGRTR?	'I,STACK \?PRG13
?CND9:	ZERO?	MATCH /?CND5
	SET	'LAST-PSEUDO-LOC,RM
	GET	GLBS,2
	PUTP	PSEUDO-OBJECT,P?ACTION,STACK
	ICALL	ADD-OBJECT,PSEUDO-OBJECT,F
	RFALSE	
?CND5:	ADD	GLBS,6 >GLBS
	DLESS?	'N,1 \?PRG3
	RTRUE	

	.ENDSEG

	.ENDI
