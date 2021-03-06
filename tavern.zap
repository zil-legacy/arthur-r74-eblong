
	.SEGMENT "TOWN"


	.FUNCT	RT-RM-TAVERN:ANY:0:1,CONTEXT,?TMP1
	EQUAL?	CONTEXT,M-BEG \?CCL3
	EQUAL?	PRSA,V?LISTEN \?CCL6
	EQUAL?	PRSO,FALSE-VALUE,ROOMS,CH-FARMERS \?CCL6
	SET	'GL-MEN-TALK?,TRUE-VALUE
	ICALL1	RT-I-MEN-TALK
	SET	'GL-MEN-TALK?,FALSE-VALUE
	RTRUE	
?CCL6:	SET	'GL-MEN-TALK?,TRUE-VALUE
	EQUAL?	PRSA,V?YELL \FALSE
	PRINT	K-FARMER-CUFFS-MSG
	RTRUE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL13
	SET	'GL-PICTURE-NUM,K-PIC-TAVERN
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL13:	EQUAL?	CONTEXT,M-ENTERED \?CCL17
	ZERO?	GL-PLAYER-FORM /?CCL20
	PRINTI	"
One of the farmers says,"
	PRINT	K-GET-OUT-MSG
	ICALL1	RT-FORM-MSG
	PRINTI	"."" He waves his arms and shoos you out the door into the town square.

"
	ICALL	RT-GOTO,RM-TOWN-SQUARE,TRUE-VALUE
	RFALSE	
?CCL20:	EQUAL?	OHERE,RM-TOWN-SQUARE \FALSE
	ZERO?	GL-MEN-NUM \?CND22
	SET	'GL-MEN-NUM,1
?CND22:	SET	'GL-MEN-START,0
	SET	'GL-MEN-TALK?,TRUE-VALUE
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-MEN-TALK,STACK
	MOVE	CH-COOK,RM-TAV-KITCHEN
	ADD	GL-MOVES,4 >?TMP1
	RANDOM	4
	ADD	?TMP1,STACK
	ICALL	RT-QUEUE,RT-I-COOK,STACK
	RFALSE	
?CCL17:	EQUAL?	CONTEXT,M-EXIT \?CCL25
	EQUAL?	P-WALK-DIR,P?NORTH,P?OUT \FALSE
	ICALL1	RT-RESET-TAVERN
	ICALL1	RT-RESET-KITCHEN
	RFALSE	
?CCL25:	EQUAL?	CONTEXT,M-END \?CCL30
	EQUAL?	PRSA,V?TRANSFORM \FALSE
	EQUAL?	GL-PLAYER-FORM,GL-OLD-FORM /?CCL36
	CRLF	
	PRINTI	"""Sorcery!! Work of the Devil!!"" A farmer picks up a knife and skewers you through the heart."
	PRINT	K-HEEDED-WARNING-MSG
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL36:	ZERO?	GL-FORM-ABORT /FALSE
	PRINTI	"
Fortunately, it all happened so quickly that"
	ICALL	RT-PRINT-OBJ,CH-FARMERS,K-ART-THE
	PRINTR	" didn't notice."
?CCL30:	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL40
	EQUAL?	CONTEXT,M-LOOK \?CCL43
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?25
	ICALL1	RT-STANDING-MSG
	PRINTI	" in"
	JUMP	?CND41
?CCL43:	FSET?	RM-TAVERN,FL-TOUCHED \?CCL46
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?82
	PRINTI	" back into"
	JUMP	?CND41
?CCL46:	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?352
?CND41:	PRINTI	" the gloomy, smoke-filled tavern. "
	MOD	GL-MOVES,1440
	LESS?	STACK,720 \?CCL49
	PRINTI	"Despite the early hour, s"
	JUMP	?CND47
?CCL49:	PRINTC	83
?CND47:	FSET	CH-FARMERS,FL-SEEN
	ICALL2	THIS-IS-IT,CH-FARMERS
	PRINTI	"ome farmers are hunched around the fire in conspiratorial conversation."
	EQUAL?	CONTEXT,M-LOOK /?CND50
	ZERO?	GL-PLAYER-FORM \?CND50
	PRINTI	" They look up in alarm when you come in, then return to their conversation when they see only a boy."
?CND50:	IN?	CH-COOK,RM-TAVERN \?CND54
	PRINTI	"

The cook is here, serving more ale to the farmers."
?CND54:	PRINTI	"

The tavern's kitchen is to the south.
"
	RFALSE	
?CCL40:	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \FALSE
	EQUAL?	HERE,RM-TAVERN,RM-TAV-KITCHEN /FALSE
	FSET	RM-TAVERN,FL-SEEN
	PRINTR	"It is a half-timbered, one-story building with a thatched roof."


	.FUNCT	RT-RESET-TAVERN:ANY:0:0
	ICALL2	RT-DEQUEUE,RT-I-MEN-TALK
	MOVE	CH-COOK,RM-TAV-KITCHEN
	FSET	TH-TAVERN-TABLE,FL-NO-LIST
	FSET	TH-CUPBOARD,FL-NO-LIST
	FSET	TH-CAGE,FL-NO-LIST
	FSET	TH-BIRD,FL-NO-LIST
	FSET	CH-COOK,FL-NO-LIST
	CALL2	RT-DEQUEUE,RT-I-COOK
	RSTACK	


	.FUNCT	RT-PS-SMOKE:ANY:0:3,CONTEXT,ART,CAP?
	FCLEAR	PSEUDO-OBJECT,FL-PLURAL
	FCLEAR	PSEUDO-OBJECT,FL-VOWEL
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,PSEUDO-OBJECT,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	PRINTI	"smoke"
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \FALSE
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	PRINTR	"The smoke curls up and escapes through a hole in the thatched roof."


	.FUNCT	RT-PS-SHADOWS:ANY:0:3,CONTEXT,ART,CAP?
	FSET	PSEUDO-OBJECT,FL-PLURAL
	FCLEAR	PSEUDO-OBJECT,FL-VOWEL
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,PSEUDO-OBJECT,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	PRINTI	"shadows"
	RTRUE	
?CCL3:	EQUAL?	PRSA,V?EXAMINE \FALSE
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	PRINTR	"The shadows dance and leap on the walls."


	.FUNCT	RT-PS-TABLE:ANY:0:3,CONTEXT,ART,CAP?
	FCLEAR	PSEUDO-OBJECT,FL-PLURAL
	FCLEAR	PSEUDO-OBJECT,FL-VOWEL
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,PSEUDO-OBJECT,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	PRINTI	"table"
	RTRUE	
?CCL3:	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	PRINT	K-FARMER-CUFFS-MSG
	RTRUE	


	.FUNCT	RT-TH-TAVERN-FIRE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-CONT \?CCL3
	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	PRINT	K-HOT-MSG
	RTRUE	
?CCL3:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL10
	EQUAL?	PRSA,V?PUT-IN,V?PUT \FALSE
	EQUAL?	PRSO,CH-PLAYER,TH-HANDS,TH-LEGS /?CTR15
	EQUAL?	PRSO,TH-HEAD,TH-MOUTH /?CTR15
	FSET?	PRSI,FL-BODY-PART \?CCL16
	CALL2	GET-OWNER,PRSI
	EQUAL?	STACK,CH-PLAYER \?CCL16
?CTR15:	PRINT	K-HOT-MSG
	RTRUE	
?CCL16:	EQUAL?	PRSO,TH-WHISKY-JUG \?CCL23
	IN?	TH-WHISKY,TH-WHISKY-JUG \?CCL23
	CALL2	RT-PUT-WHISKY-IN-FIRE-MSG,TH-TAVERN-FIRE
	RSTACK	
?CCL23:	FSET?	PRSO,FL-BURNABLE \FALSE
	REMOVE	PRSO
	PRINTI	"The flames leap higher, and soon"
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE
	PRINTR	" is completely consumed."
?CCL10:	EQUAL?	PRSA,V?EXAMINE /?CTR28
	EQUAL?	PRSA,V?LOOK-ON,V?LOOK-IN \?CCL29
	FIRST?	TH-TAVERN-FIRE /?CCL29
?CTR28:	FSET	TH-TAVERN-FIRE,FL-SEEN
	PRINTR	"The fire burns brightly, casting eerie shadows on the walls."
?CCL29:	CALL1	TOUCH-VERB?
	ZERO?	STACK /?CCL35
	EQUAL?	PRSI,FALSE-VALUE,ROOMS,CH-PLAYER /?CTR37
	EQUAL?	PRSI,TH-HANDS,TH-LEGS,TH-HEAD /?CTR37
	EQUAL?	PRSI,TH-MOUTH /?CTR37
	FSET?	PRSI,FL-BODY-PART \?CCL38
	CALL2	GET-OWNER,PRSI
	EQUAL?	STACK,CH-PLAYER \?CCL38
?CTR37:	PRINT	K-HOT-MSG
	RTRUE	
?CCL38:	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?289
	PRINTI	" around in"
	ICALL	RT-PRINT-OBJ,TH-TAVERN-FIRE,K-ART-THE
	PRINTR	" but find nothing of interest."
?CCL35:	EQUAL?	PRSA,V?LISTEN \FALSE
	PRINTR	"The fire snaps, crackles, and pops."


	.FUNCT	RT-LG-THATCH:ANY:0:1,CONTEXT
	EQUAL?	PRSA,V?EXAMINE \?CCL3
	FSET	LG-THATCH,FL-SEEN
	ICALL	RT-PRINT-OBJ,LG-THATCH,K-ART-THE,TRUE-VALUE
	PRINTR	" is densely matted straw."
?CCL3:	EQUAL?	PRSA,V?PUT-IN,V?PUT \?CCL5
	EQUAL?	P-PRSA-WORD,W?THROW,W?TOSS,W?HURL /?CTR4
	EQUAL?	P-PRSA-WORD,W?CHUCK,W?FLING,W?PITCH /?CTR4
	EQUAL?	P-PRSA-WORD,W?HEAVE \?CCL5
?CTR4:	CALL1	RT-WASTE-OF-TIME-MSG
	RSTACK	
?CCL5:	CALL1	TOUCH-VERB?
	ZERO?	STACK \?CCL12
	EQUAL?	PRSA,V?LOOK-IN \FALSE
?CCL12:	CALL2	RT-CANT-REACH-MSG,LG-THATCH
	RSTACK	


	.FUNCT	RT-CH-FARMERS:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-WINNER \?CCL3
	PRINT	K-FARMER-CUFFS-MSG
	RTRUE	
?CCL3:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL7
	EQUAL?	PRSA,V?GIVE,V?SHOW \FALSE
	EQUAL?	PRSO,TH-WHISKY,TH-WHISKY-JUG \FALSE
	PRINTI	"One of the farmers snatches the jug away from you and says, ""Wot's the world comin' to wen they let a child like you run around with sumpn' like this? "
	IN?	TH-WHISKY,TH-WHISKY-JUG \?CCL16
	PRINTI	"He takes a slug of whisky and then passes the jug around the table. Each of the farmers takes a gulp, and then the last one tosses the half-full jug into the fire. The resulting explosion levels the tavern and everything in it, including you."
	CRLF	
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL16:	REMOVE	TH-WHISKY-JUG
	PRINTI	"When he discovers there is no whisky in the jug, he tosses it over his shoulder into the fire, where it shatters."
	CRLF	
	CALL	RT-SCORE-MSG,0,-1,0,0
	RSTACK	
?CCL7:	EQUAL?	PRSA,V?TELL \?CCL18
	ZERO?	P-CONT \FALSE
?CCL18:	CALL1	SPEAKING-VERB?
	ZERO?	STACK /?CCL22
	EQUAL?	HERE,RM-TAVERN \?CCL22
	PRINT	K-FARMER-CUFFS-MSG
	RTRUE	
?CCL22:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	CH-FARMERS,FL-SEEN
	ICALL2	THIS-IS-IT,CH-FARMERS
	PRINTR	"The scraggly farmers are massive, bearded labourers who huddle around the fire for warmth and mutter amongst themselves."


	.FUNCT	RT-NEXT-NUM:ANY:2:3,N,MAX,D
	ASSIGNED?	'D /?CND1
	SET	'D,1
?CND1:	ADD	N,D >N
?PRG3:	GRTR?	N,MAX \?CCL7
	SUB	N,MAX >N
	JUMP	?PRG3
?CCL7:	LESS?	N,1 \?REP4
	ADD	N,MAX >N
	JUMP	?PRG3
?REP4:	RETURN	N


	.FUNCT	RT-I-MEN-TALK:ANY:0:0
	FSET?	CH-PLAYER,FL-ASLEEP \?CCL3
	CALL2	RT-IS-QUEUED?,RT-I-SLEEP
	ADD	STACK,1
	ICALL	RT-QUEUE,RT-I-MEN-TALK,STACK
	RFALSE	
?CCL3:	ZERO?	GL-CLK-RUN /?CND1
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-MEN-TALK,STACK
?CND1:	ZERO?	GL-MEN-TALK? /FALSE
	EQUAL?	HERE,RM-TAVERN \FALSE
	ZERO?	GL-CLK-RUN /?CND10
	CRLF	
?CND10:	ZERO?	GL-MEN-NUM /?CND12
	EQUAL?	GL-MEN-NUM,GL-MEN-START /?CND12
	ZERO?	GL-MEN-START \?CCL18
	PRINTI	"A large farmer says, "
	JUMP	?CND12
?CCL18:	CALL	RT-NEXT-NUM,GL-MEN-START,K-MEN-MAX,1
	EQUAL?	GL-MEN-NUM,STACK \?CCL20
	PRINTI	"Another farmer says, "
	JUMP	?CND12
?CCL20:	CALL	RT-NEXT-NUM,GL-MEN-START,K-MEN-MAX,2
	EQUAL?	GL-MEN-NUM,STACK \?CCL22
	PRINTI	"The first farmer says, "
	JUMP	?CND12
?CCL22:	CALL	RT-NEXT-NUM,GL-MEN-START,K-MEN-MAX,3
	EQUAL?	GL-MEN-NUM,STACK \?CND12
	PRINTI	"A third man speaks up, "
?CND12:	ZERO?	GL-MEN-NUM /?CTR25
	EQUAL?	GL-MEN-NUM,GL-MEN-START \?CCL26
?CTR25:	SET	'GL-MEN-NUM,0
	ICALL2	RT-DEQUEUE,RT-I-MEN-TALK
	PRINTI	"The farmers prudently lower their voices and continue to complain."
	CRLF	
	JUMP	?CND24
?CCL26:	EQUAL?	GL-MEN-NUM,1 \?CCL30
	PRINTI	"""I'll believe in 'is tale of angels when me billy goat stands up on 'is 'ind legs and calls me Chauncey."""
	CRLF	
	JUMP	?CND24
?CCL30:	EQUAL?	GL-MEN-NUM,2 \?CCL32
	PRINTI	"""'E's got 'is nerve, 'e 'as. Closin' up the castle so's nary a man can get in excep'n as 'e knows the word."""
	CRLF	
	JUMP	?CND24
?CCL32:	EQUAL?	GL-MEN-NUM,3 \?CCL34
	PRINTI	"""I've 'eard tell 'ow 'e duz it. 'E's got that one pome that 'e's so proud on. So 'e sits there on 'is throne, an wenever them monks starts in t'prayin, 'e picks a line as strikes 'is fancy, an that's the new word."""
	CRLF	
	JUMP	?CND24
?CCL34:	EQUAL?	GL-MEN-NUM,4 \?CCL36
	PRINTI	"""'E's right greedy, y'know. They say 'is knees gets weak wen 'e sees silver, an 'e'd sell 'is soul for an ounce of gold."""
	CRLF	
	JUMP	?CND24
?CCL36:	EQUAL?	GL-MEN-NUM,5 \?CND24
	PRINTI	"""'E'll get 'is. 'E's no more King of England than me daughter's prize pig."" He glances around and lowers his voice. ""About as 'ansome too."""
	CRLF	
?CND24:	ZERO?	GL-MEN-NUM /TRUE
	ZERO?	GL-MEN-START \?CND40
	SET	'GL-MEN-START,GL-MEN-NUM
?CND40:	CALL	RT-NEXT-NUM,GL-MEN-NUM,K-MEN-MAX >GL-MEN-NUM
	RTRUE	


	.FUNCT	RT-TH-TANKARDS:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	FSET	TH-TANKARDS,FL-SEEN
	FSET	TH-BEER,FL-SEEN
	ICALL2	THIS-IS-IT,TH-TANKARDS
	ICALL2	THIS-IS-IT,TH-BEER
	PRINTR	"The farmers' tankards have ale in them."
?CCL5:	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	PRINT	K-FARMER-CUFFS-MSG
	RTRUE	


	.FUNCT	RT-TH-BEER:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	FSET	TH-BEER,FL-SEEN
	PRINTR	"The ale is dark brown."
?CCL5:	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	PRINT	K-FARMER-CUFFS-MSG
	RTRUE	

	.ENDSEG

	.ENDI
