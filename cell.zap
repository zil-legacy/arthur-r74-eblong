
	.SEGMENT "CASTLE"


	.FUNCT	RT-RM-CELL:ANY:0:1,CONTEXT,N
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	PRINTI	"You "
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"are"
	JUMP	?CND4
?CCL6:	EQUAL?	CONTEXT,M-F-LOOK \?CCL8
	PRINTI	"crawl through the hole in the wall and plop to the ground on the other side. You find yourself"
	JUMP	?CND4
?CCL8:	PRINTI	"find yourself"
?CND4:	FSET	LG-CELL-DOOR,FL-SEEN
	PRINTI	" in a dank, cramped cell far below Lot's castle. The room was originally used by the Romans for food storage, but someone converted it into a miserable dungeon by bolting chains to the clammy stone walls."
	CRLF	
	CRLF	
	PRINTI	"There is a cell door of stout wood to the north"
	FSET?	TH-CELL-STONE,FL-LOCKED /?CND9
	PRINTI	", and a hole in the wall to the west where a stone has been pushed out"
?CND9:	PRINTC	46
	IN?	CH-PRISONER,RM-CELL \?CND11
	FSET?	CH-PRISONER,FL-LOCKED \?CND11
	FSET	CH-PRISONER,FL-SEEN
	PRINTC	32
	ICALL	RT-PRINT-OBJ,CH-PRISONER,K-ART-A,TRUE-VALUE
	PRINTI	" is chained to the wall."
?CND11:	IN?	CH-CELL-GUARD,RM-CELL \?CND15
	FSET?	CH-CELL-GUARD,FL-ASLEEP \?CND15
	PRINTC	32
	ICALL	RT-PRINT-OBJ,CH-CELL-GUARD,K-ART-A,TRUE-VALUE
	PRINTI	" is lying unconscious on the floor."
?CND15:	CRLF	
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-BEG \?CCL20
	EQUAL?	PRSA,V?YELL \?CCL23
	ZERO?	GL-PLAYER-FORM \FALSE
	CALL1	RT-CALL-GUARD
	RSTACK	
?CCL23:	EQUAL?	PRSA,V?PUT-IN \?CCL28
	EQUAL?	PRSI,LG-WALL \?CCL28
	FSET?	TH-CELL-STONE,FL-LOCKED /?CCL28
	ICALL	PERFORM,PRSA,PRSO,RM-HOLE
	RTRUE	
?CCL28:	EQUAL?	PRSA,V?WAIT \FALSE
	EQUAL?	PRSO,CH-CELL-GUARD \FALSE
	CALL2	RT-IS-QUEUED?,RT-I-ALARM >N
	ZERO?	N /?CCL38
	SUB	N,'GL-MOVES >N
	JUMP	?CND36
?CCL38:	MOD	GL-MOVES,180
	SUB	182,STACK >N
?CND36:	GRTR?	N,0 \FALSE
	SUB	N,1
	ADD	GL-MOVES,STACK >GL-MOVES
	PRINT	K-TIME-PASSES-MSG
	CRLF	
	RTRUE	
?CCL20:	EQUAL?	CONTEXT,M-ENTER \?CCL43
	IN?	CH-PRISONER,RM-CELL \?CCL46
	FSET?	CH-PRISONER,FL-LOCKED \?CCL46
	SET	'GL-PICTURE-NUM,K-PIC-CELL-PRISONER
	JUMP	?CND44
?CCL46:	SET	'GL-PICTURE-NUM,K-PIC-CELL
?CND44:	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL43:	EQUAL?	CONTEXT,M-ENTERED \?CCL52
	IN?	CH-PRISONER,RM-CELL \FALSE
	FSET?	CH-PRISONER,FL-LOCKED /FALSE
	CALL2	RT-SET-PUPPY,CH-PRISONER
	RSTACK	
?CCL52:	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?OPEN \FALSE
	ICALL	PERFORM,PRSA,LG-CELL-DOOR
	RTRUE	


	.FUNCT	RT-CELL-OUT:ANY:0:1,QUIET
	ZERO?	QUIET /?CCL3
	RETURN	RM-HALL
?CCL3:	EQUAL?	GL-HIDING,LG-CELL-DOOR \?CCL5
	SET	'GL-HIDING,FALSE-VALUE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?164
	PRINTI	" out from behind"
	ICALL	RT-PRINT-OBJ,LG-CELL-DOOR,K-ART-THE
	PRINTC	46
	CRLF	
	RFALSE	
?CCL5:	FSET?	LG-CELL-DOOR,FL-OPEN \?CCL7
	RETURN	RM-HALL
?CCL7:	ICALL2	THIS-IS-IT,LG-CELL-DOOR
	ICALL	RT-PRINT-OBJ,LG-CELL-DOOR,K-ART-THE,TRUE-VALUE,STR?25
	PRINTI	"n't open.
"
	RFALSE	


	.FUNCT	RT-TH-BEHIND-DOOR:ANY:0:1,CONTEXT,L
	EQUAL?	CONTEXT,M-BEG \?CCL3
	EQUAL?	PRSA,V?BREAK,V?ATTACK \?CCL6
	EQUAL?	PRSO,CH-CELL-GUARD,TH-HELMET,TH-HUMAN-BODY \?CCL6
	FSET?	CH-CELL-GUARD,FL-ASLEEP \FALSE
?CCL6:	IN?	CH-CELL-GUARD,RM-CELL \?CCL11
	FSET?	CH-CELL-GUARD,FL-ASLEEP /?CCL11
	CALL1	UNHIDE-VERB?
	ZERO?	STACK /?CCL11
	CALL2	RT-SEIZE-MSG,CH-CELL-GUARD
	RSTACK	
?CCL11:	EQUAL?	PRSA,V?PUT-IN \?PRD18
	EQUAL?	PRSI,RM-CELL /?CTR15
?PRD18:	EQUAL?	PRSA,V?THROW \?CCL16
	IN?	PRSI,RM-CELL \?CCL16
?CTR15:	CALL1	PRE-PUT
	ZERO?	STACK \TRUE
	CALL1	IDROP
	ZERO?	STACK /TRUE
	BOR	GL-UPDATE-WINDOW,3 >GL-UPDATE-WINDOW
	MOVE	PRSO,RM-CELL
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?43
	ICALL	RT-PRINT-OBJ,PRSO,K-ART-THE
	PRINTI	" into"
	ICALL	RT-PRINT-OBJ,RM-CELL,K-ART-THE
	PRINTR	"."
?CCL16:	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	LOC	CH-PLAYER >L
	ZERO?	PRSO /?CND30
	EQUAL?	PRSO,ROOMS /FALSE
	LOC	PRSO
	EQUAL?	STACK,GLOBAL-OBJECTS,GENERIC-OBJECTS /FALSE
	CALL	RT-META-IN?,PRSO,L
	ZERO?	STACK \?CND30
	EQUAL?	PRSO,LG-CELL-DOOR /FALSE
	ICALL	RT-CANT-REACH-MSG,PRSO,L
	RTRUE	
?CND30:	ZERO?	PRSI /FALSE
	EQUAL?	PRSI,ROOMS /FALSE
	LOC	PRSI
	EQUAL?	STACK,GLOBAL-OBJECTS,GENERIC-OBJECTS /FALSE
	CALL	RT-META-IN?,PRSI,L
	ZERO?	STACK \FALSE
	EQUAL?	PRSI,LG-CELL-DOOR /FALSE
	CALL	RT-CANT-REACH-MSG,PRSI,L
	RSTACK	
?CCL3:	EQUAL?	CONTEXT,M-END \FALSE
	IN?	CH-CELL-GUARD,RM-CELL \FALSE
	FSET?	CH-CELL-GUARD,FL-ASLEEP /FALSE
	EQUAL?	PRSA,V?TRANSFORM \FALSE
	EQUAL?	GL-PLAYER-FORM,GL-OLD-FORM /FALSE
	ZERO?	GL-PLAYER-FORM \FALSE
	CALL2	RT-SEIZE-MSG,CH-CELL-GUARD
	RSTACK	


	.FUNCT	RT-BEHIND-DOOR:ANY:0:1,QUIET,HIDE
	ZERO?	QUIET \FALSE
	IN?	WINNER,TH-BEHIND-DOOR \?CCL5
	ICALL	RT-ALREADY-MSG,WINNER,STR?226
	RFALSE	
?CCL5:	MOVE	WINNER,TH-BEHIND-DOOR
	SET	'GL-HIDING,LG-CELL-DOOR
	PRINTI	"You flatten yourself up against the cold stone wall"
	ZERO?	GL-PLAYER-FORM \?CCL8
	PRINTC	46
	JUMP	?CND6
?CCL8:	PRINTI	", as much as"
	ICALL2	RT-FORM-MSG,K-ART-A
	PRINTI	" can flatten itself."
?CND6:	CRLF	
	RFALSE	


	.FUNCT	RT-LEAVE-DOOR:ANY:0:1,QUIET
	ZERO?	QUIET /?CCL3
	RETURN	RM-CELL
?CCL3:	IN?	WINNER,TH-BEHIND-DOOR \FALSE
	SET	'GL-HIDING,FALSE-VALUE
	MOVE	WINNER,RM-CELL
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?164
	PRINTI	" out from behind"
	ICALL	RT-PRINT-OBJ,LG-CELL-DOOR,K-ART-THE
	PRINTC	46
	CRLF	
	RFALSE	


	.FUNCT	RT-CH-PRISONER:ANY:0:1,CONTEXT
	EQUAL?	PRSA,V?THANK,V?GOODBYE,V?HELLO \?CCL3
	EQUAL?	CONTEXT,M-WINNER,FALSE-VALUE \?CCL3
	EQUAL?	PRSA,V?HELLO \?CCL8
	PRINTR	"""Hello, enchanted one."""
?CCL8:	EQUAL?	PRSA,V?GOODBYE \?CCL10
	PRINTR	"""Please don't leave me here. They are sure to kill me."""
?CCL10:	EQUAL?	PRSA,V?THANK \FALSE
	PRINTI	"""I've done nothing to earn your thanks, sir. But you're welcome just the same.""
"
	FSET?	CH-PLAYER,FL-AIR /TRUE
	FSET	CH-PLAYER,FL-AIR
	ICALL	RT-SCORE-MSG,10,0,0,0
	RTRUE	
?CCL3:	EQUAL?	CONTEXT,M-WINNER \?CCL16
	EQUAL?	PRSA,V?TELL-ABOUT \?CCL19
	EQUAL?	PRSO,CH-PLAYER /FALSE
?CCL19:	EQUAL?	PRSA,V?WHAT,V?WHO /FALSE
	EQUAL?	HERE,RM-CELL,RM-BOTTOM-OF-STAIRS,RM-HALL /?PRD27
	EQUAL?	HERE,RM-END-OF-HALL,RM-SMALL-CHAMBER \?CCL25
?PRD27:	EQUAL?	PRSA,V?YELL /?CTR24
	EQUAL?	PRSA,V?CALL \?CCL25
	EQUAL?	PRSO,CH-CELL-GUARD,CH-SOLDIERS \?CCL25
?CTR24:	CALL1	RT-CALL-GUARD
	RSTACK	
?CCL25:	EQUAL?	PRSA,V?WEAR,V?TAKE \?CCL35
	EQUAL?	PRSO,TH-HELMET \?CCL35
	CALL1	RT-SMITH-HELMET-MSG
	RSTACK	
?CCL35:	IN?	TH-HELMET,CH-PRISONER \?CCL39
	EQUAL?	PRSA,V?GIVE-SWP,V?GIVE \?CCL39
	EQUAL?	TH-HELMET,PRSO,PRSI \?CCL39
	EQUAL?	CH-PLAYER,PRSO,PRSI \?CCL39
	PRINTI	"The smith"
	PRINT	K-TAKE-SMITH-HELMET-MSG
	RTRUE	
?CCL39:	PRINTI	"The man is so much in awe of you that he gets tongue-tied and can't answer.
"
	RETURN	2
?CCL16:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL49
	EQUAL?	PRSA,V?PUT,V?GIVE,V?SHOW \FALSE
	EQUAL?	PRSO,TH-MASTER-KEY \?CCL55
	FSET?	CH-PRISONER,FL-LOCKED \FALSE
	ICALL	RT-PRINT-OBJ,CH-PRISONER,K-ART-THE,TRUE-VALUE
	PRINTI	" can't use"
	ICALL	RT-PRINT-OBJ,TH-MASTER-KEY,K-ART-THE
	PRINTI	". "
	ICALL	RT-PRINT-OBJ,CH-PRISONER,K-ART-HIS,TRUE-VALUE
	PRINTR	" hands are shackled."
?CCL55:	EQUAL?	PRSO,TH-SHIELD,TH-ARMOUR,TH-BROKEN-DAGGER /?CTR59
	EQUAL?	PRSO,PSEUDO-OBJECT \?CCL60
	EQUAL?	LAST-PSEUDO-LOC,RM-ARMOURY \?CCL60
?CTR59:	CALL2	RT-SMITH-EVALUATE-MSG,PRSO
	RSTACK	
?CCL60:	EQUAL?	PRSO,TH-HELMET \FALSE
	CALL1	RT-SMITH-HELMET-MSG
	RSTACK	
?CCL49:	EQUAL?	PRSA,V?TELL \?CCL68
	ZERO?	P-CONT \FALSE
?CCL68:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL72
	EQUAL?	PRSI,TH-TIME \?CCL75
	CALL	NOUN-USED?,PRSI,W?CHRISTMAS,W?XMAS
	ZERO?	STACK /?CCL75
	PRINTR	"""I really enjoying decking the halls, but I'm not too wild about the gay apparel."""
?CCL75:	EQUAL?	PRSI,GLOBAL-HERE \?PRD81
	EQUAL?	HERE,RM-CELL /?CTR78
?PRD81:	EQUAL?	PRSI,RM-CELL,CH-SOLDIERS,CH-CELL-GUARD /?CTR78
	EQUAL?	PRSI,LG-CELL-DOOR,TH-TIME,TH-MASTER-KEY /?CTR78
	CALL	NOUN-USED?,PRSI,W?FOOD
	ZERO?	STACK /?CCL79
?CTR78:	FSET?	CH-PRISONER,FL-LOCKED /?CCL88
	PRINTR	"""I was blindfolded when they arrested me. I cannot tell you anything more."""
?CCL88:	PRINTR	"""A guard comes to look at me when the bells ring. Or if I shout, sometimes he will come."""
?CCL79:	EQUAL?	PRSI,CH-LOT,TH-SWORD,TH-EXCALIBUR \?CCL90
	PRINTR	"""King Lot came to me and asked me to fashion a sword in the likeness of the famous sword in the stone. He told me it was to be a gift to the new High King, whoever that may be. But when I completed it, he imprisoned me in this cell."""
?CCL90:	EQUAL?	PRSI,CH-PRISONER \?CCL92
	PRINTR	"""I am but a humble craftsman."""
?CCL92:	EQUAL?	PRSI,RM-SMITHY \?CCL94
	PRINTR	"""It must have become abandoned since I was imprisoned."""
?CCL94:	EQUAL?	PRSI,TH-SHIELD,TH-ARMOUR,TH-BROKEN-DAGGER /?CTR95
	EQUAL?	PRSI,PSEUDO-OBJECT \?CCL96
	EQUAL?	LAST-PSEUDO-LOC,RM-ARMOURY \?CCL96
?CTR95:	CALL2	RT-SMITH-EVALUATE-MSG,PRSI
	RSTACK	
?CCL96:	EQUAL?	PRSI,CH-MERLIN \?CCL102
	PRINTR	"""In the town, they say he has made a pact with the devil. But I have never heard of him doing evil."""
?CCL102:	EQUAL?	PRSI,TH-NAME \?CCL104
	PRINTR	"""My name is Casso."""
?CCL104:	EQUAL?	PRSI,TH-MASTER \?CCL106
	PRINTR	"""I have no master."""
?CCL106:	EQUAL?	PRSI,TH-CHAINS,TH-PADLOCK \?CCL108
	FSET?	CH-PRISONER,FL-LOCKED \?CCL111
	PRINTR	"His head droops in despair. ""Finest quality,"" he mumbles. ""Cannot be broken."""
?CCL111:	PRINTR	"The prisoner shudders and says, ""Now that you have freed me, I don't even want to think about such things."""
?CCL108:	EQUAL?	PRSI,TH-PUMICE \?CCL113
	PRINTR	"""I use pumice all the time. There's nothing like it to make an old weapon look like new."""
?CCL113:	EQUAL?	PRSI,TH-HELMET \?CCL115
	FSET?	PRSI,FL-SEEN \?CCL118
	PRINTR	"""It's a perfect disguise. No one will recognize me."""
?CCL118:	PRINTI	"""What "
	ICALL2	NP-PRINT,PRSI-NP
	PRINTR	"?"""
?CCL115:	PRINTI	"""I know nothing about"
	FSET?	PRSI,FL-PERSON \?CCL121
	ICALL	RT-PRINT-OBJ,PRSI,K-ART-HIM
	JUMP	?CND119
?CCL121:	PRINTI	" that"
?CND119:	PRINTR	"."""
?CCL72:	EQUAL?	PRSA,V?ASK-FOR \?CCL123
	EQUAL?	PRSI,TH-HELMET \FALSE
	IN?	TH-HELMET,CH-PRISONER \FALSE
	PRINTI	"The smith"
	PRINT	K-TAKE-SMITH-HELMET-MSG
	RTRUE	
?CCL123:	EQUAL?	PRSA,V?EXAMINE \?CCL130
	FSET	CH-PRISONER,FL-SEEN
	FSET?	CH-PRISONER,FL-LOCKED \?CCL133
	PRINTR	"The prisoner's wrists are crossed and bound together by a chain. The chain is fastened with a large padlock."
?CCL133:	ICALL	RT-PRINT-OBJ,CH-PRISONER,K-ART-THE,TRUE-VALUE,STR?176
	PRINTR	" grateful that you have freed him, but worried about how you will manage your escape from the castle."
?CCL130:	EQUAL?	PRSA,V?RELEASE \?CCL135
	FSET?	CH-PRISONER,FL-LOCKED \FALSE
	IN?	TH-MASTER-KEY,WINNER \?CCL140
	CALL1	RT-FREE-PRISONER-MSG
	RSTACK	
?CCL140:	SET	'CLOCK-WAIT,TRUE-VALUE
	CALL2	RT-AUTHOR-MSG,K-HOW-INTEND-MSG
	RSTACK	
?CCL135:	EQUAL?	PRSA,V?UNLOCK \?CCL142
	FSET?	CH-PRISONER,FL-LOCKED \FALSE
	EQUAL?	PRSI,TH-MASTER-KEY \FALSE
	CALL1	RT-FREE-PRISONER-MSG
	RSTACK	
?CCL142:	EQUAL?	PRSA,V?KNEEL \?CCL149
	PRINTR	"The prisoner bows in return."
?CCL149:	EQUAL?	PRSA,V?TALK-TO \?CCL151
	PRINTR	"The prisoner babbles a few incoherent words in response."
?CCL151:	EQUAL?	PRSA,V?ATTACK \FALSE
	ZERO?	GL-PLAYER-FORM \FALSE
	PRINTI	"You launch an attack against the prisoner, but"
	FSET?	CH-PRISONER,FL-LOCKED \?CND157
	PRINTI	" even though he is chained,"
?CND157:	PRINTI	" you are no match for his superior strength. He"
	FSET?	CH-PRISONER,FL-LOCKED \?CND159
	PRINTI	" wraps a chain around your throat and"
?CND159:	PRINTI	" strangles you to death."
	CRLF	
	CALL1	RT-END-OF-GAME
	RSTACK	


	.FUNCT	RT-FREE-PRISONER-MSG:ANY:0:0
	FCLEAR	TH-CHAINS,FL-LOCKED
	FCLEAR	TH-PADLOCK,FL-LOCKED
	FSET	TH-CHAINS,FL-OPEN
	FSET	TH-PADLOCK,FL-OPEN
	FCLEAR	CH-PRISONER,FL-LOCKED
	ICALL2	RT-SET-PUPPY,CH-PRISONER
	SET	'GL-PICTURE-NUM,K-PIC-CELL
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	PRINTI	"You unlock the padlock. The prisoner struggles to his feet and looks at you gratefully. ""Thank you, kind sir,"" he says. ""Let us escape from here together.""
"
	ICALL	RT-SCORE-MSG,10,0,0,0
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CCL3
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL3:	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \TRUE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RTRUE	


	.FUNCT	RT-SMITH-EVALUATE-MSG:ANY:1:1,OBJ
	FSET?	OBJ,FL-SEEN \?CCL3
	CALL2	VISIBLE?,OBJ
	ZERO?	STACK /?CND4
	PRINTI	"The smith eyes"
	ICALL	RT-PRINT-OBJ,OBJ,K-ART-THE
	PRINTI	" professionally and says, "
?CND4:	EQUAL?	OBJ,PSEUDO-OBJECT \?CCL8
	CALL	NOUN-USED?,PSEUDO-OBJECT,W?SHIELD,W?SHIELDS
	ZERO?	STACK /?CCL11
	PRINTR	"""They're not top quality, but I suppose they're good enough for government work."""
?CCL11:	PRINTR	"""They're imported from Gaul. You can tell by the inferior workmanship along the shafts."""
?CCL8:	EQUAL?	OBJ,TH-SHIELD \?CCL13
	PRINTR	"""It's a perfectly good shield. They just haven't taken very good care of it."""
?CCL13:	EQUAL?	OBJ,TH-ARMOUR \?CCL15
	PRINTR	"""The chap it was made for must be awfully small - about your size, I'd say."""
?CCL15:	EQUAL?	OBJ,TH-BROKEN-DAGGER \FALSE
	PRINTR	"""It's beyond repair. Even I couldn't fix it."""
?CCL3:	PRINTI	"""What "
	EQUAL?	PRSI,OBJ \?CCL20
	ICALL2	NP-PRINT,PRSI-NP
	JUMP	?CND18
?CCL20:	ICALL2	NP-PRINT,PRSO-NP
?CND18:	PRINTR	"?"""


	.FUNCT	RT-SMITH-HELMET-MSG:ANY:0:0
	MOVE	TH-HELMET,CH-PRISONER
	FSET	TH-HELMET,FL-WORN
	PRINTR	"The smith puts on the helmet. It covers enough of his face to make a suitable disguise."

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	RT-TH-CELL-STONE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL7
	FSET	TH-CELL-STONE,FL-SEEN
	PRINTR	"It's an old building stone whose corners are rounded with age."
?CCL7:	EQUAL?	PRSA,V?TAKE /?CTR8
	EQUAL?	PRSA,V?MOVE \?CCL9
	EQUAL?	P-PRSA-WORD,W?PULL \?CCL9
?CTR8:	FSET?	TH-CELL-STONE,FL-LOCKED \FALSE
	EQUAL?	HERE,RM-CELL \FALSE
	ZERO?	GL-PLAYER-FORM /?CCL21
	CALL1	RT-ANIMAL-CANT-MSG
	RSTACK	
?CCL21:	CALL2	RT-DO-TAKE,TH-CELL-STONE
	ZERO?	STACK /FALSE
	FCLEAR	TH-CELL-STONE,FL-LOCKED
	PRINTI	"You pull the loose stone out of the wall.
"
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL9:	EQUAL?	PRSA,V?EXTEND,V?MOVE \?CCL27
	EQUAL?	HERE,RM-CELL \FALSE
	FSET?	TH-CELL-STONE,FL-LOCKED \FALSE
	PRINTR	"You push on the stone, but you can't seem to move it from this side."
?CCL27:	EQUAL?	PRSA,V?CLIMB-ON \?CCL34
	CALL1	RT-WASTE-OF-TIME-MSG
	RSTACK	
?CCL34:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	P-PRSA-WORD,W?DROP,W?THROW,W?HURL \FALSE
	ICALL	PERFORM,V?BREAK,PRSI,PRSO
	RTRUE	

	.ENDSEG

	.SEGMENT "CASTLE"


	.FUNCT	RT-LG-CELL-DOOR:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL5
	FSET	LG-CELL-DOOR,FL-SEEN
	PRINTI	"It is a massive wooden door that is "
	FSET?	LG-CELL-DOOR,FL-OPEN \?CCL8
	PRINTI	"standing open"
	JUMP	?CND6
?CCL8:	PRINTI	"firmly closed"
?CND6:	PRINTR	"."
?CCL5:	EQUAL?	PRSA,V?HIDE-BEHIND \?CCL10
	EQUAL?	HERE,RM-CELL \?CCL10
	ICALL1	RT-BEHIND-DOOR
	RTRUE	
?CCL10:	EQUAL?	PRSA,V?BREAK,V?ATTACK \FALSE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTR	" can't break down the door."


	.FUNCT	RT-TH-CHAINS:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?MOVE,V?TAKE \?CCL5
	ICALL2	THIS-IS-IT,LG-WALL
	ICALL2	THIS-IS-IT,TH-CHAINS
	ICALL	RT-PRINT-OBJ,TH-CHAINS,K-ART-THE,TRUE-VALUE
	PRINTR	" are firmly attached to the wall."
?CCL5:	EQUAL?	PRSA,V?OPEN \?CCL7
	FSET?	TH-CHAINS,FL-LOCKED /?CCL7
	FSET?	CH-PRISONER,FL-LOCKED \?CCL7
	CALL1	RT-FREE-PRISONER-MSG
	RSTACK	
?CCL7:	EQUAL?	PRSA,V?EXAMINE \?CCL12
	FSET	TH-CHAINS,FL-SEEN
	ICALL2	THIS-IS-IT,TH-CHAINS
	PRINTR	"The chains are forged of the strongest iron."
?CCL12:	EQUAL?	PRSA,V?ATTACK,V?BREAK \FALSE
	ICALL2	THIS-IS-IT,TH-CHAINS
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTR	" can't break the chains."


	.FUNCT	RT-TH-PADLOCK:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?MOVE,V?TAKE \?CCL5
	FSET	TH-PADLOCK,FL-SEEN
	ICALL2	THIS-IS-IT,TH-CHAINS
	ICALL2	THIS-IS-IT,TH-PADLOCK
	ICALL	RT-PRINT-OBJ,TH-PADLOCK,K-ART-THE,TRUE-VALUE
	PRINTI	" is firmly attached to"
	ICALL	RT-PRINT-OBJ,TH-CHAINS,K-ART-THE
	PRINTR	"."
?CCL5:	EQUAL?	PRSA,V?OPEN \?CCL7
	FSET?	TH-CHAINS,FL-LOCKED /?CCL7
	IN?	CH-PRISONER,RM-CELL \?CCL7
	FSET?	CH-PRISONER,FL-LOCKED \?CCL7
	CALL1	RT-FREE-PRISONER-MSG
	RSTACK	
?CCL7:	EQUAL?	PRSA,V?EXAMINE \?CCL13
	FSET	TH-CHAINS,FL-SEEN
	ICALL2	THIS-IS-IT,TH-PADLOCK
	ICALL	RT-PRINT-OBJ,TH-PADLOCK,K-ART-THE,TRUE-VALUE
	PRINTR	" is forged of the strongest iron."
?CCL13:	EQUAL?	PRSA,V?ATTACK,V?BREAK \FALSE
	FSET	TH-CHAINS,FL-SEEN
	ICALL2	THIS-IS-IT,TH-PADLOCK
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	PRINTI	" can't break"
	ICALL	RT-PRINT-OBJ,TH-PADLOCK,K-ART-THE
	PRINTR	"."

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	RT-TH-HELMET:ANY:0:1,CONTEXT,L
	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL5
	EQUAL?	PRSA,V?EMPTY,V?PUT-IN \FALSE
	CALL1	RT-WASTE-OF-TIME-MSG
	RSTACK	
?CCL5:	EQUAL?	PRSA,V?BREAK,V?ATTACK \?CCL10
	FSET?	TH-HELMET,FL-WORN \?CCL10
	LOC	TH-HELMET >L
	ZERO?	L /?CCL10
	FSET?	L,FL-PERSON \?CCL10
	CALL	PERFORM,PRSA,L,PRSI
	RSTACK	
?CCL10:	EQUAL?	PRSA,V?WEAR \?CCL16
	PRINTR	"The helmet is much too big for you."
?CCL16:	EQUAL?	PRSA,V?EXAMINE \?CCL18
	PRINTI	"It's a rather large helmet"
	FSET?	TH-HELMET,FL-BROKEN \?CND19
	PRINTI	", with a rather large dent in it"
?CND19:	PRINTR	"."
?CCL18:	EQUAL?	PRSA,V?TAKE \?CCL22
	IN?	TH-HELMET,CH-PRISONER \?CCL22
	PRINTI	"The smith stops you and"
	PRINT	K-TAKE-SMITH-HELMET-MSG
	RTRUE	
?CCL22:	EQUAL?	PRSA,V?FILL \FALSE
	CALL1	RT-WASTE-OF-TIME-MSG
	RSTACK	

	.ENDSEG

	.SEGMENT "CASTLE"


	.FUNCT	RT-TH-GUARD-CLOTHES:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE,V?TAKE,V?WEAR \FALSE
	PRINT	K-UNDRESS-GUARD-MSG
	RTRUE	


	.FUNCT	RT-CH-CELL-GUARD:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-WINNER \?CCL3
	EQUAL?	HERE,RM-BOTTOM-OF-STAIRS /?CTR5
	FSET?	CH-CELL-GUARD,FL-ASLEEP /?CCL6
?CTR5:	CALL2	RT-SEIZE-MSG,CH-CELL-GUARD
	RSTACK	
?CCL6:	CALL2	RT-NO-RESPONSE-MSG,CH-CELL-GUARD
	RSTACK	
?CCL3:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?BREAK,V?ATTACK \?CCL14
	CALL1	RT-KNOCK-OUT-GUARD
	RSTACK	
?CCL14:	EQUAL?	PRSA,V?CALL \?CCL16
	EQUAL?	HERE,RM-CELL,RM-BOTTOM-OF-STAIRS,RM-HALL /?CTR15
	EQUAL?	HERE,RM-END-OF-HALL,RM-SMALL-CHAMBER \?CCL16
?CTR15:	CALL1	RT-CALL-GUARD
	RSTACK	
?CCL16:	EQUAL?	PRSA,V?EXAMINE \?CCL22
	FSET	CH-CELL-GUARD,FL-SEEN
	EQUAL?	HERE,RM-BOTTOM-OF-STAIRS /?CTR24
	FSET?	CH-CELL-GUARD,FL-ASLEEP /?CCL25
?CTR24:	PRINTI	"It's hard to tell what he looks like. His back is turned towards you"
	IN?	TH-HELMET,CH-CELL-GUARD \?CND28
	PRINTI	", and he is wearing a helmet"
?CND28:	PRINTR	"."
?CCL25:	PRINTI	"The guard is lying on the floor, unconscious. It doesn't look as if he will recover anytime soon."
	IN?	TH-HELMET,CH-CELL-GUARD \?CND30
	PRINTR	" He is wearing a helmet."
?CND30:	CRLF	
	RTRUE	
?CCL22:	EQUAL?	PRSA,V?UNDRESS \FALSE
	EQUAL?	HERE,RM-BOTTOM-OF-STAIRS /?CTR35
	FSET?	CH-CELL-GUARD,FL-ASLEEP /?CCL36
?CTR35:	CALL2	RT-SEIZE-MSG,CH-CELL-GUARD
	RSTACK	
?CCL36:	PRINT	K-UNDRESS-GUARD-MSG
	RTRUE	

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	RT-GN-GUARD:ANY:2:2,TBL,FINDER,PTR,N
	ADD	TBL,8 >PTR
	GET	TBL,1 >N
	INTBL?	P-HIM-OBJECT,PTR,N /?CTR2
	RETURN	CH-CELL-GUARD
?CTR2:	RETURN	P-HIM-OBJECT

	.ENDSEG

	.SEGMENT "CASTLE"


	.FUNCT	RT-KNOCK-OUT-GUARD:ANY:0:0
	IN?	CH-CELL-GUARD,HERE \?CCL3
	FSET?	CH-CELL-GUARD,FL-ASLEEP \?CCL3
	PRINTR	"He's already unconscious. There's no need to hit him again."
?CCL3:	IN?	CH-CELL-GUARD,HERE \?CCL7
	EQUAL?	PRSI,TH-CELL-STONE \?CCL7
	FSET	TH-HELMET,FL-BROKEN
	FSET	CH-CELL-GUARD,FL-ASLEEP
	FSET	CH-CELL-GUARD,FL-NO-LIST
	ICALL	RT-MOVE-ALL,CH-CELL-GUARD,HERE
	MOD	GL-MOVES,180
	SUB	GL-MOVES,STACK
	ADD	STACK,225
	ICALL	RT-QUEUE,RT-I-ALARM,STACK,TRUE-VALUE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE
	EQUAL?	GL-HIDING,LG-CELL-DOOR \?CND10
	MOVE	WINNER,RM-CELL
	SET	'GL-HIDING,FALSE-VALUE
	ICALL	RT-PRINT-VERB,WINNER,STR?164
	PRINTI	" out from behind"
	ICALL	RT-PRINT-OBJ,LG-CELL-DOOR,K-ART-THE
	PRINTI	" and"
?CND10:	ICALL2	THIS-IS-IT,CH-CELL-GUARD
	ICALL2	THIS-IS-IT,TH-MASTER-KEY
	ICALL	RT-PRINT-VERB,WINNER,STR?229
	PRINTI	" the guard with the stone. It puts a dent in his helmet and he slumps to the floor, unconscious. As he falls, you notice a key dangling at his side.
"
	ICALL	RT-SCORE-MSG,0,3,3,2
	RTRUE	
?CCL7:	ZERO?	GL-PLAYER-FORM \?CCL14
	PRINTI	"You hit the guard"
	EQUAL?	PRSI,TH-HANDS /?CND15
	PRINTI	" with"
	ICALL	RT-PRINT-OBJ,PRSI,K-ART-THE
?CND15:	PRINTI	", but the blow glances off his helmet. He quickly recovers and"
	PRINT	K-GUARDS-COME-MSG
	ICALL1	RT-OVERPOWER-MSG
	JUMP	?CND12
?CCL14:	PRINTI	"You leave your hiding place, but before you can carry out your plan of attack, the guard says,"
	PRINT	K-LOVERLY-MSG
	ICALL1	RT-FORM-MSG
	PRINT	K-SKEWER-MSG
?CND12:	CALL1	RT-END-OF-GAME
	RSTACK	


	.FUNCT	RT-CALL-GUARD:ANY:0:0
	INC	'GL-GUARD-CNT
	SET	'GL-CALLED-GUARD?,TRUE-VALUE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?234
	PRINTI	" out."
	FSET?	CH-CELL-GUARD,FL-ASLEEP \?CCL3
	CRLF	
	CRLF	
	ICALL2	RT-DEQUEUE,RT-I-ALARM
	CALL1	RT-I-ALARM
	RSTACK	
?CCL3:	CALL2	RT-IS-QUEUED?,RT-I-GUARD-1
	ZERO?	STACK \?CTR4
	CALL2	RT-IS-QUEUED?,RT-I-GUARD-2
	ZERO?	STACK /?CCL5
?CTR4:	CRLF	
	RTRUE	
?CCL5:	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-GUARD-2,STACK
	PRINTI	" Moments later, you"
	PRINT	K-FOOTSTEPS-MSG
	RTRUE	


	.FUNCT	RT-I-GUARD-1:ANY:0:0
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-GUARD-2,STACK
	SET	'GL-CALLED-GUARD?,FALSE-VALUE
	EQUAL?	HERE,RM-CELL \FALSE
	PRINTI	"
You"
	PRINT	K-FOOTSTEPS-MSG
	RTRUE	


	.FUNCT	RT-I-GUARD-2:ANY:0:0,OBJ
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-GUARD-3,STACK
	EQUAL?	HERE,RM-CELL /?CTR2
	EQUAL?	HERE,RM-HOLE \?CCL3
	FSET?	TH-CELL-STONE,FL-LOCKED /?CCL3
?CTR2:	MOVE	CH-CELL-GUARD,RM-CELL
	FSET	CH-CELL-GUARD,FL-SEEN
	FCLEAR	LG-CELL-DOOR,FL-LOCKED
	FSET	LG-CELL-DOOR,FL-OPEN
	ICALL2	RT-CHECK-ADJ,LG-CELL-DOOR
	PRINTI	"
You hear keys fumbling in the lock, and then the door swings back and a guard steps into the cell. He "
	EQUAL?	HERE,RM-HOLE \?CCL10
	MOVE	TH-CELL-STONE,RM-CELL
	FSET	TH-CELL-STONE,FL-LOCKED
	PRINTI	"sees the stone and replaces it in the hole.
"
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL10:	EQUAL?	GL-HIDING,LG-CELL-DOOR \?CCL14
	FIRST?	RM-CELL >OBJ /?PRG16
?PRG16:	ZERO?	OBJ /?REP17
	EQUAL?	OBJ,TH-CELL-STONE /?CND18
	FSET?	OBJ,FL-TAKEABLE \?CND18
	PRINTI	"sees"
	ICALL	RT-PRINT-OBJ,OBJ,K-ART-THE
	PRINTI	" and says, ""Hmmm. Never noticed this before."" He looks around the room. When he "
	ZERO?	GL-PLAYER-FORM \?CCL26
	PRINTI	"sees you he"
	PRINT	K-GUARDS-COME-MSG
	ICALL1	RT-OVERPOWER-MSG
	JUMP	?CND24
?CCL26:	PRINTI	"notices you he says,"
	PRINT	K-LOVERLY-MSG
	ICALL1	RT-FORM-MSG
	PRINT	K-SKEWER-MSG
?CND24:	ICALL1	RT-END-OF-GAME
?CND18:	NEXT?	OBJ >OBJ /?PRG16
	JUMP	?PRG16
?REP17:	FSET?	TH-CELL-STONE,FL-LOCKED /?CND28
	IN?	TH-CELL-STONE,RM-CELL \?CND28
	FSET	TH-CELL-STONE,FL-LOCKED
	FSET	TH-CELL-STONE,FL-NO-DESC
	PRINTI	"sees the stone, replaces it in the hole and then "
?CND28:	ZERO?	GL-CALLED-GUARD? /?CND32
	GRTR?	GL-GUARD-CNT,2 \?CND32
	EQUAL?	GL-GUARD-CNT,3 \?CCL38
	PRINTI	"says, ""Right, mate. That's it! One more scream out of you and the dogs will be eating prisoner casserole for tomorrow's dinner."" He "
	JUMP	?CND32
?CCL38:	PRINTI	"hauls the prisoner away to a fate so gruesome, so bloody, so terrifyingly horrible, that you feel compelled to die also."
	CRLF	
	ICALL1	RT-END-OF-GAME
?CND32:	PRINTI	"stands for a moment with his back to you, looking at the prisoner.
"
	BOR	GL-UPDATE-WINDOW,K-UPD-OBJS >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CCL41
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL41:	EQUAL?	GL-WINDOW-TYPE,K-WIN-MAP \TRUE
	ICALL1	RT-UPDATE-MAP-WINDOW
	RTRUE	
?CCL14:	ZERO?	GL-PLAYER-FORM \?CCL44
	PRINTI	"sees you immediately and"
	PRINT	K-GUARDS-COME-MSG
	ICALL1	RT-OVERPOWER-MSG
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL44:	FSET?	TH-CELL-STONE,FL-LOCKED /?CND45
	PRINTI	"sees the stone, and "
?CND45:	PRINTI	"looks around the room. When he notices you he says,"
	PRINT	K-LOVERLY-MSG
	ICALL1	RT-FORM-MSG
	PRINT	K-SKEWER-MSG
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL3:	FSET?	TH-CELL-STONE,FL-LOCKED /FALSE
	MOVE	CH-CELL-GUARD,RM-CELL
	FCLEAR	LG-CELL-DOOR,FL-LOCKED
	FSET	LG-CELL-DOOR,FL-OPEN
	ICALL2	RT-CHECK-ADJ,LG-CELL-DOOR
	FSET	TH-CELL-STONE,FL-LOCKED
	FSET	TH-CELL-STONE,FL-NO-DESC
	RFALSE	


	.FUNCT	RT-I-GUARD-3:ANY:0:0
	FSET?	CH-CELL-GUARD,FL-ASLEEP /FALSE
	REMOVE	CH-CELL-GUARD
	FSET	LG-CELL-DOOR,FL-LOCKED
	FCLEAR	LG-CELL-DOOR,FL-OPEN
	ICALL2	RT-CHECK-ADJ,LG-CELL-DOOR
	EQUAL?	HERE,RM-CELL \FALSE
	PRINTI	"
The guard leaves the cell and relocks the door.
"
	BOR	GL-UPDATE-WINDOW,K-UPD-OBJS >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CCL9
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL9:	EQUAL?	GL-WINDOW-TYPE,K-WIN-MAP \TRUE
	ICALL1	RT-UPDATE-MAP-WINDOW
	RTRUE	


	.FUNCT	RT-ESCAPE-MSG:ANY:0:0
	PRINTI	" ""There's been an escape"
	FSET?	CH-PRISONER,FL-LOCKED \FALSE
	PRINTI	" attempt"
	RTRUE	


	.FUNCT	RT-OVERPOWER-MSG:ANY:0:0
	PRINTI	" and "
	EQUAL?	HERE,RM-CELL \?CCL3
	PRINTI	"overpower"
	JUMP	?CND1
?CCL3:	PRINTI	"arrest"
	IN?	CH-PRISONER,HERE \?CND1
	PRINTI	" both of"
?CND1:	PRINTI	" you, leaving you to rot in another cell.
"
	CALL1	RT-END-OF-GAME
	RSTACK	


	.FUNCT	RT-ARREST-PRISONER-MSG:ANY:0:0
	ZERO?	GL-PLAYER-FORM \?CCL3
	ZERO?	GL-HIDING /?CND4
	PRINTI	", find you hiding behind"
	ICALL	RT-PRINT-OBJ,GL-HIDING,K-ART-THE
	PRINTC	44
?CND4:	CALL1	RT-OVERPOWER-MSG
	RSTACK	
?CCL3:	PRINTC	32
	PRINT	K-REMOVE-PRISONER-MSG
	PRINTI	" In the process, one of them notices you and says,"
	PRINT	K-LOVERLY-MSG
	ICALL1	RT-FORM-MSG
	PRINT	K-SKEWER-MSG
	CALL1	RT-END-OF-GAME
	RSTACK	


	.FUNCT	RT-I-ALARM:ANY:0:0,CAP?,CALL?
	EQUAL?	HERE,RM-HOLE \?CCL3
	FSET?	TH-CELL-STONE,FL-LOCKED /?CCL3
	PRINTI	"Inside"
	ICALL	RT-PRINT-OBJ,RM-CELL,K-ART-THE
	PRINTC	44
	FSET?	LG-CELL-DOOR,FL-OPEN /?CND6
	FSET	LG-CELL-DOOR,FL-OPEN
	ICALL	RT-PRINT-OBJ,LG-CELL-DOOR,K-ART-THE
	PRINTI	" swings open and you see"
?CND6:	PRINTI	" a"
	IN?	CH-CELL-GUARD,RM-CELL \?CND8
	PRINTI	"nother"
?CND8:	PRINTI	" guard enters. He sees "
	IN?	CH-CELL-GUARD,RM-CELL \?CCL12
	PRINTI	"the unconscious guard"
	JUMP	?CND10
?CCL12:	IN?	CH-PRISONER,RM-CELL \?CCL14
	FSET?	CH-PRISONER,FL-LOCKED /?CCL14
	PRINTI	"the freed prisoner"
	JUMP	?CND10
?CCL14:	PRINTI	"that the prisoner has escaped"
?CND10:	PRINTI	" and immediately"
	PRINT	K-GUARDS-COME-MSG
	IN?	CH-PRISONER,RM-CELL \?CCL19
	REMOVE	CH-PRISONER
	PRINTI	" and "
	PRINT	K-REMOVE-PRISONER-MSG
	CRLF	
	JUMP	?CND1
?CCL19:	IN?	CH-CELL-GUARD,RM-CELL \?CCL21
	PRINTI	" and they remove the unconscious guard.
"
	JUMP	?CND1
?CCL21:	PRINTI	", search the cell briefly, and then leave.
"
	JUMP	?CND1
?CCL3:	EQUAL?	HERE,RM-CELL \?CCL23
	ZERO?	GL-CLK-RUN /?CND24
	CRLF	
?CND24:	SET	'CAP?,TRUE-VALUE
	FSET?	LG-CELL-DOOR,FL-OPEN /?CND26
	ICALL	RT-PRINT-OBJ,LG-CELL-DOOR,K-ART-THE,CAP?
	SET	'CAP?,FALSE-VALUE
	FSET	LG-CELL-DOOR,FL-OPEN
	PRINTI	" swings open and"
?CND26:	ZERO?	CAP? /?CCL30
	PRINTC	65
	JUMP	?CND28
?CCL30:	PRINTI	" a"
?CND28:	IN?	CH-CELL-GUARD,RM-CELL \?CND31
	PRINTI	"nother"
?CND31:	PRINTI	" guard enters the cell. He sees "
	IN?	CH-PRISONER,RM-CELL \?CCL35
	FSET?	CH-PRISONER,FL-LOCKED /?CCL35
	PRINTI	"the freed prisoner"
	JUMP	?CND33
?CCL35:	IN?	CH-CELL-GUARD,RM-CELL \?CCL39
	PRINTI	"the unconscious guard"
	JUMP	?CND33
?CCL39:	PRINTI	"you"
	ZERO?	GL-HIDING /?CND40
	PRINTI	" behind"
	ICALL	RT-PRINT-OBJ,GL-HIDING,K-ART-THE
?CND40:	ZERO?	GL-PLAYER-FORM /?CND33
	PRINTI	" and says,"
	PRINT	K-LOVERLY-MSG
	ICALL1	RT-FORM-MSG
	PRINT	K-SKEWER-MSG
	ICALL1	RT-END-OF-GAME
?CND33:	PRINTI	" and immediately"
	PRINT	K-GUARDS-COME-MSG
	IN?	CH-PRISONER,RM-CELL \?CCL46
	ICALL1	RT-ARREST-PRISONER-MSG
	JUMP	?CND1
?CCL46:	ZERO?	GL-PLAYER-FORM /?CCL48
	PRINTI	". One of them sees you and says,"
	PRINT	K-LOVERLY-MSG
	ICALL1	RT-FORM-MSG
	PRINT	K-SKEWER-MSG
	ICALL1	RT-END-OF-GAME
	JUMP	?CND1
?CCL48:	ICALL1	RT-OVERPOWER-MSG
	JUMP	?CND1
?CCL23:	EQUAL?	HERE,RM-BOTTOM-OF-STAIRS,RM-HALL,RM-END-OF-HALL \?CCL50
	ZERO?	GL-CLK-RUN /?CND51
	CRLF	
?CND51:	PRINTI	"Another guard comes down the corridor, gives you a curious glance and enters the cell. "
	IN?	CH-PRISONER,HERE /?CTR54
	IN?	CH-PRISONER,RM-CELL \?CCL55
?CTR54:	PRINTI	"Seconds later he bursts out again and"
	PRINT	K-GUARDS-COME-MSG
	IN?	CH-PRISONER,HERE \?CCL60
	ICALL1	RT-ARREST-PRISONER-MSG
	JUMP	?CND1
?CCL60:	REMOVE	CH-PRISONER
	PRINTI	" and "
	PRINT	K-REMOVE-PRISONER-MSG
	CRLF	
	JUMP	?CND1
?CCL55:	PRINTI	"Moments later he emerges again and disappears down the hall."
	CRLF	
	JUMP	?CND1
?CCL50:	EQUAL?	HERE,RM-SMALL-CHAMBER \?CCL62
	ZERO?	GL-CALLED-GUARD? /?CCL62
	ZERO?	GL-CLK-RUN \?CCL62
	PRINTI	"Another guard comes down the corridor, gives you a curious glance, and then disappears again."
	CRLF	
	JUMP	?CND1
?CCL62:	EQUAL?	HERE,RM-GREAT-HALL \?CCL67
	PRINT	K-SHOUT-FOOTSTEP-MSG
	PRINTI	"A soldier bursts into the hall and cries,"
	ICALL1	RT-ESCAPE-MSG
	PRINTI	"."" Lot calls out, ""Find the prisoner. He must not be allowed to leave the castle."" The soldier rushes out again."
	CRLF	
	JUMP	?CND1
?CCL67:	EQUAL?	HERE,RM-SMALL-CHAMBER,RM-ARMOURY,RM-CAS-KITCHEN /?PRD70
	EQUAL?	HERE,RM-PARADE-AREA,RM-PASSAGE-1,RM-PASSAGE-2 /?PRD70
	EQUAL?	HERE,RM-PASSAGE-3,RM-BEHIND-THRONE,RM-BEHIND-FIRE \?CND1
?PRD70:	FSET?	CH-SOLDIERS,FL-BROKEN /?CND1
	PRINT	K-SHOUT-FOOTSTEP-MSG
	PRINTI	"Someone calls out,"
	ICALL1	RT-ESCAPE-MSG
	PRINTI	"!"""
	EQUAL?	HERE,RM-SMALL-CHAMBER,RM-ARMOURY,RM-CAS-KITCHEN /?CCL75
	EQUAL?	HERE,RM-PARADE-AREA \?CND74
?CCL75:	PRINTI	" Moments later some guards burst into the "
	EQUAL?	HERE,RM-PARADE-AREA \?CCL80
	PRINTI	"area"
	JUMP	?CND78
?CCL80:	PRINTI	"room"
?CND78:	IN?	CH-PRISONER,HERE \?CCL83
	PRINTI	", see the prisoner,"
	ICALL1	RT-ARREST-PRISONER-MSG
	JUMP	?CND74
?CCL83:	PRINTI	", give you a curious glance, and then leave the way they came."
?CND74:	CRLF	
?CND1:	FSET	CH-SOLDIERS,FL-BROKEN
	REMOVE	CH-CELL-GUARD
	RTRUE	

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	RT-TH-MASTER-KEY:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?UNLOCK \FALSE
	ZERO?	NOW-PRSI /FALSE
	EQUAL?	PRSO,TH-CHAINS,TH-PADLOCK \FALSE
	FSET?	TH-CHAINS,FL-LOCKED \FALSE
	FSET?	CH-PRISONER,FL-LOCKED \FALSE
	CALL1	RT-FREE-PRISONER-MSG
	RSTACK	

	.ENDSEG

	.SEGMENT "TOWN"


	.FUNCT	RT-RM-HOLE:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	EQUAL?	CONTEXT,M-LOOK \?CCL6
	PRINTI	"You are huddled up in"
	JUMP	?CND4
?CCL6:	EQUAL?	OHERE,RM-SMITHY \?CCL9
	PRINTI	"You burrow down into the cold earth. After a while, the tunnel broadens out into"
	JUMP	?CND4
?CCL9:	EQUAL?	OHERE,RM-CELL \?CCL11
	PRINTI	"You crawl into the hole and find yourself in"
	JUMP	?CND4
?CCL11:	PRINTI	"You emerge into"
?CND4:	PRINTI	" a comfortable badger's den that nestles up against the castle wall to the east. The stones in the wall look very old"
	FSET?	TH-CELL-STONE,FL-LOCKED \?CCL14
	PRINTI	", and the mortar around one in particular is cracked and crumbling"
	JUMP	?CND12
?CCL14:	PRINTI	", and there is a hole in the wall where one has been pushed out"
?CND12:	PRINTI	". Some "
	CALL2	RT-TIME-OF-DAY?,K-NIGHT
	ZERO?	STACK /?CCL17
	PRINTI	"moon"
	JUMP	?CND15
?CCL17:	PRINTI	"sun"
?CND15:	FSET	RM-BADGER-TUNNEL,FL-SEEN
	PRINTI	"light filters down from the opening over your head, and another tunnel leads away to the south."
	GETB	K-TUNNEL-CNT-TBL,GL-TUNNEL-NUM
	ZERO?	STACK /?CCL20
	PRINTC	32
	ICALL1	RT-NUM-MARKS-MSG
	RFALSE	
?CCL20:	CRLF	
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-BEG \?CCL22
	EQUAL?	PRSA,V?SCRATCH,V?DIG \FALSE
	EQUAL?	PRSO,FALSE-VALUE,ROOMS,TH-GROUND /?CCL25
	EQUAL?	PRSO,TH-SKY,HERE,GLOBAL-HERE /?CCL25
	EQUAL?	PRSO,LG-WALL \FALSE
?CCL25:	GETB	K-TUNNEL-CNT-TBL,GL-TUNNEL-NUM
	CALL2	RT-MAKE-MARK,STACK
	RSTACK	
?CCL22:	EQUAL?	CONTEXT,M-ENTER \?CCL32
	SET	'GL-PICTURE-NUM,K-PIC-HOLE
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \?CND33
	ICALL1	RT-UPDATE-PICT-WINDOW
?CND33:	SET	'GL-TUNNEL-NUM,0
	RFALSE	
?CCL32:	ZERO?	CONTEXT \FALSE
	EQUAL?	HERE,RM-CELL \?CCL38
	FSET?	TH-CELL-STONE,FL-LOCKED \?CCL38
	ZERO?	NOW-PRSI /?CCL44
	PUSH	2
	JUMP	?CND42
?CCL44:	PUSH	1
?CND42:	CALL2	EVERYWHERE-VERB?,STACK
	ZERO?	STACK \?CCL38
	ICALL2	THIS-IS-IT,TH-CELL-STONE
	PRINTR	"The hole is blocked by a stone."
?CCL38:	ZERO?	NOW-PRSI /?CCL46
	EQUAL?	PRSA,V?PUT-IN \?CCL49
	EQUAL?	HERE,RM-CELL \?CCL49
	EQUAL?	PRSO,TH-CELL-STONE \?CCL49
	IN?	TH-CELL-STONE,WINNER \?CCL49
	MOVE	TH-CELL-STONE,HERE
	FSET	TH-CELL-STONE,FL-LOCKED
	FSET	TH-CELL-STONE,FL-NO-DESC
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?237
	ICALL	RT-PRINT-OBJ,TH-CELL-STONE,K-ART-THE
	PRINTI	" back into the hole.
"
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL49:	EQUAL?	PRSA,V?PUT-IN,V?PUT,V?DROP \FALSE
	EQUAL?	HERE,RM-HOLE /FALSE
	CALL1	RT-WASTE-OF-TIME-MSG
	RSTACK	
?CCL46:	EQUAL?	PRSA,V?EXAMINE \?CCL62
	FSET	RM-HOLE,FL-SEEN
	EQUAL?	HERE,RM-SMITHY \?CCL65
	PRINTR	"It looks like a badger tunnel leading underground."
?CCL65:	EQUAL?	HERE,RM-CELL \FALSE
	PRINTR	"There is a hole in the wall, leading into the badger tunnel."
?CCL62:	EQUAL?	PRSA,V?LOOK-IN,V?LOOK-DOWN \FALSE
	PRINTI	"You peer"
	EQUAL?	HERE,RM-SMITHY \?CND70
	PRINTI	" down"
?CND70:	PRINTR	" into the hole, but can't see very far."


	.FUNCT	RT-PS-MORTAR:ANY:0:3,CONTEXT,ART,CAP?
	FCLEAR	PSEUDO-OBJECT,FL-PLURAL
	FCLEAR	PSEUDO-OBJECT,FL-VOWEL
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,PSEUDO-OBJECT,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	PRINTI	"mortar"
	RTRUE	
?CCL3:	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL16
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	PRINTR	"The mortar is cracked and crumbling. It barely holds the stones together."
?CCL16:	EQUAL?	PRSA,V?TAKE \FALSE
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	PRINTR	"You scratch at the mortar, but you can't seem to remove it."


	.FUNCT	RT-PS-STONES:ANY:0:3,CONTEXT,ART,CAP?
	FSET	PSEUDO-OBJECT,FL-PLURAL
	FCLEAR	PSEUDO-OBJECT,FL-VOWEL
	EQUAL?	CONTEXT,M-OBJDESC \?CCL3
	ZERO?	ART /?CND4
	ICALL	PRINT-ARTICLE,PSEUDO-OBJECT,ART,CAP?
?CND4:	EQUAL?	ART,FALSE-VALUE,K-ART-THE,K-ART-A /?CCL8
	EQUAL?	ART,K-ART-ANY \FALSE
?CCL8:	ZERO?	ART /?CND11
	PRINTC	32
?CND11:	PRINTI	"stones"
	RTRUE	
?CCL3:	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EXAMINE \?CCL16
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	FSET?	TH-CELL-STONE,FL-LOCKED \?CCL19
	CALL	NOUN-USED?,PSEUDO-OBJECT,W?STONE,W?ROCK
	ZERO?	STACK /?CCL19
	FSET	TH-CELL-STONE,FL-SEEN
	ICALL2	THIS-IS-IT,TH-CELL-STONE
	PRINTR	"It's an old building stone whose corners are rounded with age."
?CCL19:	PRINTI	"The stones look very old, and "
	FSET?	TH-CELL-STONE,FL-LOCKED \?CCL24
	ICALL2	THIS-IS-IT,TH-CELL-STONE
	PRINTR	"the mortar around one in particular is cracked and crumbling."
?CCL24:	PRINTR	"there is a hole in the wall where one has been pushed out."
?CCL16:	EQUAL?	PRSA,V?SCRATCH,V?EXTEND,V?MOVE \FALSE
	EQUAL?	GL-PLAYER-FORM,K-FORM-BADGER \?CCL29
	FSET?	TH-CELL-STONE,FL-LOCKED /?CCL32
	ICALL2	THIS-IS-IT,PSEUDO-OBJECT
	PRINTI	"You "
	EQUAL?	PRSA,V?SCRATCH /?CTR34
	EQUAL?	P-PRSA-WORD,W?PULL \?CCL35
?CTR34:	PRINTI	"claw at"
	JUMP	?CND33
?CCL35:	PRINTI	"push on"
?CND33:	PRINTR	" the remaining stones, but none of them are loose."
?CCL32:	FCLEAR	TH-CELL-STONE,FL-LOCKED
	FCLEAR	TH-CELL-STONE,FL-NO-DESC
	PRINTI	"You "
	EQUAL?	PRSA,V?SCRATCH /?CTR39
	EQUAL?	P-PRSA-WORD,W?PULL \?CCL40
?CTR39:	PRINTI	"claw at"
	JUMP	?CND38
?CCL40:	PRINTI	"push on"
?CND38:	PRINTI	" the stone. It wobbles. You give it a"
	EQUAL?	PRSA,V?SCRATCH /?CND43
	EQUAL?	P-PRSA-WORD,W?PULL /?CND43
	PRINTI	"nother"
?CND43:	PRINTI	" push and it falls into the room beyond!
"
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CCL49
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	
?CCL49:	EQUAL?	GL-WINDOW-TYPE,K-WIN-MAP \TRUE
	ICALL1	RT-UPDATE-MAP-WINDOW
	RTRUE	
?CCL29:	ICALL	RT-FORM-MSG,K-ART-A,TRUE-VALUE
	PRINTR	" isn't nearly strong enough to move such a stone."


	.FUNCT	RT-ENTER-HOLE:ANY:0:1,QUIET
	EQUAL?	HERE,RM-CELL \?CCL3
	FSET?	TH-CELL-STONE,FL-LOCKED \?CCL3
	ZERO?	QUIET \FALSE
	PRINTI	"A large stone blocks your path.
"
	RFALSE	
?CCL3:	ZERO?	QUIET /?CCL9
	RETURN	RM-HOLE
?CCL9:	EQUAL?	GL-PLAYER-FORM,K-FORM-BADGER,K-FORM-SALAMANDER \?CCL11
	ICALL1	RT-CLEAR-PUPPY
	RETURN	RM-HOLE
?CCL11:	PRINT	K-TOO-BIG-MSG
	RFALSE	


	.FUNCT	RT-EXIT-HOLE:ANY:0:1,QUIET
	FSET?	TH-CELL-STONE,FL-LOCKED /?CTR2
	RETURN	RM-CELL
?CTR2:	ZERO?	QUIET \FALSE
	PRINTI	"A large stone blocks your path.
"
	RFALSE	

	.ENDSEG

	.ENDI
