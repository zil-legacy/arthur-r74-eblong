
	.SEGMENT "TOWN"


	.FUNCT	RT-RM-TAV-KITCHEN:ANY:0:1,CONTEXT
	EQUAL?	CONTEXT,M-F-LOOK,M-V-LOOK,M-LOOK \?CCL3
	IN?	CH-COOK,RM-TAV-KITCHEN \?CCL6
	FSET	CH-COOK,FL-SEEN
	FSET	TH-CUPBOARD,FL-SEEN
	PRINTI	"The kitchen is dominated by a mean-looking cook who is working at a table with his back to a"
	ICALL2	RT-OPEN-MSG,TH-CUPBOARD
	PRINTI	" cupboard."
	IN?	TH-BIRD,TH-CAGE \?CND7
	FSET	TH-BIRD,FL-SEEN
	FSET	TH-CAGE,FL-SEEN
	PRINTI	" Above his head is a beautiful caged bird who "
	EQUAL?	CONTEXT,M-LOOK \?CCL11
	PRINTI	"is chattering frantically at you"
	JUMP	?CND9
?CCL11:	PRINTI	"starts to chatter as soon as you come in"
?CND9:	PRINTC	46
?CND7:	IN?	TH-CHEESE,TH-TAVERN-TABLE \?CND12
	FSET?	TH-CHEESE,FL-NO-LIST \?CND12
	PRINTI	" Near the edge of the table is a small, stale piece of cheese."
?CND12:	CRLF	
	RFALSE	
?CCL6:	PRINTI	"You are in the small kitchen that is tucked away in the back of the tavern. The only exit lies to the north.
"
	RFALSE	
?CCL3:	EQUAL?	CONTEXT,M-ENTER \?CCL17
	IN?	CH-COOK,RM-TAV-KITCHEN \?CCL20
	SET	'GL-PICTURE-NUM,K-PIC-COOK
	JUMP	?CND18
?CCL20:	SET	'GL-PICTURE-NUM,K-PIC-TAV-KITCHEN
?CND18:	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \FALSE
	ICALL1	RT-UPDATE-PICT-WINDOW
	RFALSE	
?CCL17:	EQUAL?	CONTEXT,M-ENTERED \?CCL24
	IN?	CH-COOK,RM-TAV-KITCHEN \FALSE
	IN?	TH-BIRD,TH-CAGE \FALSE
	PRINTR	"
The cook takes a backhanded swipe at the bird and mutters, ""Sharrup."""
?CCL24:	EQUAL?	CONTEXT,M-END \?CCL32
	EQUAL?	PRSA,V?TRANSFORM \FALSE
	IN?	CH-COOK,RM-TAV-KITCHEN \?CCL38
	EQUAL?	GL-PLAYER-FORM,GL-OLD-FORM /?CCL41
	CRLF	
	PRINTI	"""Sorcery!! Work of the Devil!!"" The cook picks up a knife and skewers you through the heart."
	PRINT	K-HEEDED-WARNING-MSG
	CALL1	RT-END-OF-GAME
	RSTACK	
?CCL41:	ZERO?	GL-FORM-ABORT /FALSE
	PRINTI	"
Fortunately, it all happened so quickly that"
	ICALL	RT-PRINT-OBJ,CH-COOK,K-ART-THE
	PRINTR	" didn't notice."
?CCL38:	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \FALSE
	EQUAL?	GL-PLAYER-FORM,GL-OLD-FORM /FALSE
	FSET?	TH-BIRD,FL-LOCKED /FALSE
	FSET	TH-BIRD,FL-LOCKED
	PRINTI	"
The bird watches your transformation without surprise. Its chattering suddenly becomes intelligible to you. ""Mon dieu, but you are slow! I know you must 'ate zat man because of ze way ee cooks. In my country we would 'ave 'im killed. But ee 'as some spices 'idden away in ze cupboard, and ze key to ze cupboard ees 'idden in ze thatch. "
	IN?	TH-BIRD,TH-CAGE \?CCL51
	PRINTR	"Queekly now, before ze sadist returns. Open ze cage and I weel get ze key for you."""
?CCL51:	PRINTI	"Would you like me to get eet for you?""
"
	CALL2	YES?,TRUE-VALUE
	ZERO?	STACK /?CCL54
	MOVE	TH-CUPBOARD-KEY,RM-TAV-KITCHEN
	PRINT	K-BIRD-GETS-KEY-MSG
	JUMP	?CND52
?CCL54:	PRINTI	"""No? Non? You do not want ze spices?"" He shakes his head. ""I will never understand ze English. Au revoir, mon ami."" "
	ICALL	RT-PRINT-OBJ,TH-BIRD,K-ART-THE,TRUE-VALUE
?CND52:	REMOVE	TH-BIRD
	MOVE	TH-DROPPING,TH-TAVERN-TABLE
	PRINT	K-DROPPING-MSG
	RTRUE	
?CCL32:	ZERO?	CONTEXT \FALSE
	RFALSE	


	.FUNCT	RT-RESET-KITCHEN:ANY:0:0
	IN?	TH-BIRD,RM-TAV-KITCHEN \?CCL3
	MOVE	TH-BIRD,TH-CAGE
	JUMP	?CND1
?CCL3:	LOC	TH-BIRD
	ZERO?	STACK \?CND1
	FSET	TH-BIRD,FL-ASLEEP
?CND1:	IN?	TH-SPICE-BOTTLE,RM-TAV-KITCHEN /?CCL6
	IN?	TH-SPICE-BOTTLE,TH-TAVERN-TABLE /?CCL6
	IN?	TH-SPICE-BOTTLE,TH-CAGE \?CND5
?CCL6:	MOVE	TH-SPICE-BOTTLE,TH-CUPBOARD
	FCLEAR	TH-CUPBOARD,FL-LOCKED
?CND5:	IN?	TH-CUPBOARD-KEY,RM-TAV-KITCHEN /?CCL11
	IN?	TH-CUPBOARD-KEY,TH-TAVERN-TABLE /?CCL11
	IN?	TH-CUPBOARD-KEY,TH-CAGE \?CND10
?CCL11:	MOVE	TH-CUPBOARD-KEY,TH-CUPBOARD
	FCLEAR	TH-CUPBOARD,FL-LOCKED
?CND10:	FCLEAR	TH-CAGE,FL-OPEN
	FCLEAR	TH-CUPBOARD,FL-OPEN
	RTRUE	


	.FUNCT	RT-CH-COOK:ANY:0:1,CONTEXT,OBJ
	EQUAL?	CONTEXT,M-WINNER,FALSE-VALUE \?CCL3
	EQUAL?	PRSA,V?THANK,V?GOODBYE,V?HELLO \?CCL3
	PRINT	K-COOK-IGNORES-MSG
	EQUAL?	PRSA,V?THANK \TRUE
	FSET?	CH-PLAYER,FL-AIR /TRUE
	FSET	CH-PLAYER,FL-AIR
	ICALL	RT-SCORE-MSG,10,0,0,0
	RTRUE	
?CCL3:	EQUAL?	CONTEXT,M-WINNER \?CCL11
	IN?	CH-COOK,RM-TAVERN \?CCL14
	PRINT	K-NOT-NOW-MSG
	RTRUE	
?CCL14:	EQUAL?	PRSA,V?TELL-ABOUT \?CCL16
	EQUAL?	PRSO,CH-PLAYER /FALSE
?CCL16:	EQUAL?	PRSA,V?WHAT,V?WHO /FALSE
	EQUAL?	PRSA,V?WHERE \?CCL22
	EQUAL?	PRSO,TH-CUPBOARD-KEY \?CCL25
	PRINTR	"""None o' yer business."""
?CCL25:	EQUAL?	PRSO,CH-FARMERS \?CCL27
	PRINTR	"""Sittin' out there with their noses in their ale. Same as always."""
?CCL27:	EQUAL?	PRSO,TH-SPICE-BOTTLE,TH-SPICE \?CCL29
	PRINT	K-NO-SPICE-MSG
	RTRUE	
?CCL29:	PRINTI	"""Don't know nuthin' 'bout no "
	ICALL2	NP-PRINT,PRSO-NP
	PRINTR	"."""
?CCL22:	EQUAL?	PRSA,V?OPEN \?CCL31
	EQUAL?	PRSO,TH-CUPBOARD,TH-CAGE \?CCL34
	PRINT	K-FAT-CHANCE-MSG
	RTRUE	
?CCL34:	PRINT	K-COOK-IGNORES-MSG
	RTRUE	
?CCL31:	PRINT	K-COOK-IGNORES-MSG
	RTRUE	
?CCL11:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI /?CCL38
	EQUAL?	PRSA,V?GIVE,V?SHOW \FALSE
	EQUAL?	PRSO,TH-SPICE-BOTTLE,TH-SPICE,TH-CUPBOARD-KEY \?CCL44
	EQUAL?	PRSO,TH-SPICE \?CCL47
	SET	'OBJ,TH-SPICE-BOTTLE
	JUMP	?CND45
?CCL47:	SET	'OBJ,PRSO
?CND45:	MOVE	OBJ,TH-CUPBOARD
	FCLEAR	TH-CUPBOARD,FL-OPEN
	FCLEAR	TH-CUPBOARD,FL-LOCKED
	ICALL	RT-PRINT-OBJ,CH-COOK,K-ART-THE,TRUE-VALUE
	PRINTI	" snatches"
	ICALL	RT-PRINT-OBJ,OBJ,K-ART-THE
	PRINTI	" away from you and says, ""'Ow did you get that?"" He cuffs you on the side of the head"
	EQUAL?	HERE,RM-TAV-KITCHEN \?CCL50
	PRINTI	", replaces"
	ICALL	RT-PRINT-OBJ,OBJ,K-ART-THE
	PRINTR	" in the cupboard, and closes the door."
?CCL50:	MOVE	CH-COOK,RM-TAV-KITCHEN
	IN?	TH-CHEESE,TH-TAVERN-TABLE \?CND51
	FSET	TH-CHEESE,FL-NO-LIST
?CND51:	FSET	TH-TAVERN-TABLE,FL-NO-LIST
	FSET	TH-CUPBOARD,FL-NO-LIST
	FSET	TH-CAGE,FL-NO-LIST
	FSET	TH-BIRD,FL-NO-LIST
	ICALL2	RT-DEQUEUE,RT-I-COOK
	RANDOM	4
	ADD	4,STACK
	ADD	GL-MOVES,STACK
	ICALL	RT-QUEUE,RT-I-COOK,STACK
	PRINTR	" and returns to the kitchen."
?CCL44:	EQUAL?	PRSO,TH-WHISKY,TH-WHISKY-JUG \?CCL54
	MOVE	TH-WHISKY-JUG,TH-CUPBOARD
	FCLEAR	TH-CUPBOARD,FL-OPEN
	ICALL	RT-PRINT-OBJ,CH-COOK,K-ART-THE,TRUE-VALUE
	PRINTI	" snatches the jug away from you and says, ""A young lad like you shouldn't be messin with the likes of that. """
	EQUAL?	HERE,RM-TAV-KITCHEN \?CCL57
	PRINTI	"He puts the jug in the cupboard and closes the door."
	CRLF	
	JUMP	?CND55
?CCL57:	MOVE	CH-COOK,RM-TAV-KITCHEN
	IN?	TH-CHEESE,TH-TAVERN-TABLE \?CND58
	FSET	TH-CHEESE,FL-NO-LIST
?CND58:	FSET	TH-TAVERN-TABLE,FL-NO-LIST
	FSET	TH-CUPBOARD,FL-NO-LIST
	FSET	TH-CAGE,FL-NO-LIST
	FSET	TH-BIRD,FL-NO-LIST
	ICALL2	RT-DEQUEUE,RT-I-COOK
	RANDOM	4
	ADD	4,STACK
	ADD	GL-MOVES,STACK
	ICALL	RT-QUEUE,RT-I-COOK,STACK
	PRINTI	"He glances at the jug and returns to the kitchen."
	CRLF	
?CND55:	CALL	RT-SCORE-MSG,0,-1,0,0
	RSTACK	
?CCL54:	EQUAL?	PRSO,TH-CHEESE \?CCL61
	REMOVE	TH-CHEESE
	PRINTI	"The cook snatches the cheese away from you and pops it into his mouth. ""Why you little thief!"" he says. ""I should have you thrown in Lot's dungeon. But instead I'll settle for this."" He gives you a swift kick in the rear end."
	CRLF	
	CALL	RT-SCORE-MSG,0,-1,0,0
	RSTACK	
?CCL61:	EQUAL?	PRSO,TH-BRACELET,TH-GOLD-KEY,TH-SILVER-KEY /?CCL63
	EQUAL?	PRSO,TH-RAVEN-EGG \FALSE
?CCL63:	PRINTR	"""Where did the likes of you get the likes of that? I want no part of your stolen loot."""
?CCL38:	EQUAL?	PRSA,V?TELL \?CCL67
	ZERO?	P-CONT \FALSE
?CCL67:	EQUAL?	PRSA,V?ASK-FOR \?CCL71
	PRINT	K-FAT-CHANCE-MSG
	RTRUE	
?CCL71:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL73
	IN?	CH-COOK,RM-TAVERN \?CCL76
	PRINT	K-NOT-NOW-MSG
	RTRUE	
?CCL76:	EQUAL?	PRSI,CH-FARMERS \?CCL78
	PRINTR	"""Mangy bunch of lie-abouts."""
?CCL78:	EQUAL?	PRSI,TH-PASSWORD \?CCL80
	PRINTR	"""How should I know? I don't read poetry."""
?CCL80:	EQUAL?	PRSI,CH-LOT,TH-MASTER \?CCL82
	PRINTR	"""How would I know anything about Lot, him with his castles and passwords and such?"""
?CCL82:	EQUAL?	PRSI,TH-BIRD \?CCL84
	IN?	TH-BIRD,TH-CAGE \?CCL87
	PRINTR	"""A proper nuisance, he is. But come Lot's coronation, his goose will be cooked. Heh Heh."""
?CCL87:	PRINTR	"The cook fixes you with a viscious stare and says, ""If I ever find out who opened that cage, I'll throttle him with my own hands."""
?CCL84:	EQUAL?	PRSI,TH-SPICE \?CCL89
	PRINT	K-NO-SPICE-MSG
	RTRUE	
?CCL89:	EQUAL?	PRSI,TH-CUPBOARD-KEY \?CCL91
	PRINTR	"""None o' yer business."""
?CCL91:	EQUAL?	PRSI,TH-CUPBOARD \?CCL93
	PRINTR	"""Keep yer hands off. There's nothing in there."""
?CCL93:	EQUAL?	PRSI,RM-TAVERN,RM-TAV-KITCHEN,GLOBAL-HERE \?CCL95
	ICALL	RT-PRINT-OBJ,CH-COOK,K-ART-THE,TRUE-VALUE
	PRINTR	" shrugs his shoulders and mumbles, ""It's a livin'."""
?CCL95:	EQUAL?	PRSI,TH-CHEESE \?CCL97
	IN?	TH-CHEESE,TH-TAVERN-TABLE \?CCL100
	PRINTR	"""Keep yer hands off."""
?CCL100:	PRINTR	"""Somebody nicked it, and I'd better not find out who it was"""
?CCL97:	EQUAL?	PRSI,CH-COOK \?CCL102
	PRINTR	"""I prepare plain food for plain people. Nothin' fancy about me."""
?CCL102:	EQUAL?	PRSI,TH-BEER,TH-TANKARDS \?CCL104
	PRINTR	"""Come back when you're older."""
?CCL104:	EQUAL?	PRSI,CH-MERLIN \?CCL106
	PRINTR	"""Don't get too many wizards in here. They don't drink much, you know."""
?CCL106:	EQUAL?	PRSI,CH-PLAYER \?CCL108
	PRINTR	"""You're nowt but a meddlesome lad. Go away before I box your ears."""
?CCL108:	EQUAL?	PRSI,CH-IDIOT \?CCL110
	PRINTR	"""He's just here on holiday. Monday he goes back to his regular job at the Post Office."""
?CCL110:	EQUAL?	PRSI,TH-CAGE \?CCL112
	PRINTR	"""If you was just a little smaller, I'd pop you in there and keep you for a pet. Har har."""
?CCL112:	EQUAL?	PRSI,TH-EXCALIBUR \?CCL114
	PRINTR	"""Having it right across the way was good for business. I'm sorry to see it gone."""
?CCL114:	PRINTI	"""Don't know nuthin' 'bout no "
	ICALL2	NP-PRINT,PRSI-NP
	PRINTR	"."""
?CCL73:	EQUAL?	PRSA,V?EXAMINE \?CCL116
	FSET	CH-COOK,FL-SEEN
	PRINTR	"He is a fat, nasty-looking ruffian."
?CCL116:	EQUAL?	PRSA,V?CALL \?CCL118
	EQUAL?	HERE,RM-TAVERN,RM-TAV-KITCHEN \?CCL118
	IN?	CH-COOK,HERE /?CCL118
	ICALL	RT-PRINT-OBJ,CH-COOK,K-ART-THE,TRUE-VALUE,STR?361
	PRINTC	32
	EQUAL?	HERE,RM-TAVERN \?CCL124
	PRINTI	"out of"
	JUMP	?CND122
?CCL124:	PRINTI	"into"
?CND122:	PRINTI	" the kitchen. When he sees it is you who has disturbed him, he cuffs you on the head and throws you out of the tavern.

"
	ICALL1	RT-RESET-TAVERN
	ICALL1	RT-RESET-KITCHEN
	CALL	RT-GOTO,RM-TOWN-SQUARE,TRUE-VALUE
	RSTACK	
?CCL118:	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	ICALL	RT-PRINT-OBJ,CH-COOK,K-ART-THE,TRUE-VALUE
	PRINTR	" cuffs you on the head and says, ""Quit your silly games, boy. Else I'll thrash you proper."""


	.FUNCT	RT-I-COOK:ANY:0:0,?TMP1
	FSET?	CH-PLAYER,FL-ASLEEP \?CCL3
	MOVE	CH-COOK,RM-TAV-KITCHEN
	IN?	TH-CHEESE,TH-TAVERN-TABLE \?CND4
	FSET	TH-CHEESE,FL-NO-LIST
?CND4:	FSET	TH-TAVERN-TABLE,FL-NO-LIST
	FSET	TH-CUPBOARD,FL-NO-LIST
	FSET	TH-CAGE,FL-NO-LIST
	FSET	TH-BIRD,FL-NO-LIST
	SET	'GL-PICTURE-NUM,K-PIC-COOK
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \?CCL8
	ICALL1	RT-UPDATE-PICT-WINDOW
	JUMP	?CND6
?CCL8:	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CND6
	ICALL1	RT-UPDATE-DESC-WINDOW
?CND6:	ICALL1	RT-RESET-KITCHEN
	CALL2	RT-IS-QUEUED?,RT-I-SLEEP >?TMP1
	RANDOM	4
	ADD	3,STACK
	ADD	?TMP1,STACK
	ICALL	RT-QUEUE,RT-I-COOK,STACK
	RFALSE	
?CCL3:	IN?	CH-COOK,RM-TAV-KITCHEN \?CCL11
	SET	'GL-COOK-NUM,0
	MOVE	CH-COOK,RM-TAVERN
	IN?	TH-CHEESE,TH-TAVERN-TABLE \?CND12
	FCLEAR	TH-CHEESE,FL-NO-LIST
?CND12:	FCLEAR	TH-TAVERN-TABLE,FL-NO-LIST
	FCLEAR	TH-CUPBOARD,FL-NO-LIST
	FCLEAR	TH-CAGE,FL-NO-LIST
	FCLEAR	TH-BIRD,FL-NO-LIST
	RANDOM	4
	ADD	3,STACK
	ADD	GL-MOVES,STACK
	ICALL	RT-QUEUE,RT-I-COOK,STACK
	EQUAL?	HERE,RM-TAVERN \?CCL16
	PRINTR	"
One of the customers calls for more ale, and the cook comes out of the kitchen."
?CCL16:	EQUAL?	HERE,RM-TAV-KITCHEN \FALSE
	SET	'GL-PICTURE-NUM,K-PIC-TAV-KITCHEN
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \?CCL21
	ICALL1	RT-UPDATE-PICT-WINDOW
	JUMP	?CND19
?CCL21:	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CND19
	ICALL1	RT-UPDATE-DESC-WINDOW
?CND19:	PRINTR	"
The cook leaves the room in response to a shout from a thirsty customer."
?CCL11:	ZERO?	GL-COOK-NUM \?CCL24
	SET	'GL-COOK-NUM,1
	ADD	GL-MOVES,1
	ICALL	RT-QUEUE,RT-I-COOK,STACK
	EQUAL?	HERE,RM-TAV-KITCHEN \FALSE
	PRINTR	"
You hear footfalls outside. The cook is returning."
?CCL24:	SET	'GL-COOK-NUM,0
	MOVE	CH-COOK,RM-TAV-KITCHEN
	IN?	TH-CHEESE,TH-TAVERN-TABLE \?CND28
	FSET	TH-CHEESE,FL-NO-LIST
?CND28:	FSET	TH-TAVERN-TABLE,FL-NO-LIST
	FSET	TH-CUPBOARD,FL-NO-LIST
	FSET	TH-CAGE,FL-NO-LIST
	FSET	TH-BIRD,FL-NO-LIST
	ADD	GL-MOVES,4 >?TMP1
	RANDOM	4
	ADD	?TMP1,STACK
	ICALL	RT-QUEUE,RT-I-COOK,STACK
	EQUAL?	HERE,RM-TAVERN \?CCL32
	PRINTI	"
The cook disappears into the kitchen."
	CRLF	
	JUMP	?CND30
?CCL32:	EQUAL?	HERE,RM-TAV-KITCHEN \?CND30
	SET	'GL-PICTURE-NUM,K-PIC-COOK
	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-PICT \?CCL36
	ICALL1	RT-UPDATE-PICT-WINDOW
	JUMP	?CND34
?CCL36:	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \?CND34
	ICALL1	RT-UPDATE-DESC-WINDOW
?CND34:	PRINTI	"
The cook comes into the kitchen"
	ZERO?	GL-PLAYER-FORM \?CCL40
	IN?	TH-BIRD,RM-TAV-KITCHEN \?CCL43
	PRINTI	" and sees that the bird has escaped. He chases it around the room for several minutes before finally catching it. He stuffs it back into the cage, gives you a suspicious glance,"
	PRINT	K-COOK-RESUMES-WORK-MSG
	JUMP	?CND30
?CCL43:	FSET?	TH-CUPBOARD,FL-OPEN /?CTR44
	LOC	TH-BIRD
	ZERO?	STACK \?CCL45
	FSET?	TH-BIRD,FL-ASLEEP /?CCL45
?CTR44:	PRINTI	" and sees that"
	FSET?	TH-CUPBOARD,FL-OPEN \?CND50
	ICALL	RT-PRINT-OBJ,TH-CUPBOARD,K-ART-THE
	PRINTI	" is open"
?CND50:	LOC	TH-BIRD
	ZERO?	STACK \?CND52
	FSET	TH-BIRD,FL-ASLEEP
	FSET?	TH-CUPBOARD,FL-OPEN \?CND54
	PRINTI	" and"
?CND54:	ICALL	RT-PRINT-OBJ,TH-BIRD,K-ART-THE
	PRINTI	" is gone"
?CND52:	PRINTI	", he cuffs you on the side of the head and boots you out the door, saying,"
	PRINT	K-GET-OUT-MSG
	PRINTI	" brat.""

"
	ICALL	RT-GOTO,RM-TAVERN,TRUE-VALUE
	JUMP	?CND30
?CCL45:	IN?	TH-BIRD,TH-CAGE \?CND56
	PRINTI	", takes a backhanded swipe at the bird, mutters, ""Sharrup."""
?CND56:	PRINT	K-COOK-RESUMES-WORK-MSG
	JUMP	?CND30
?CCL40:	EQUAL?	GL-PLAYER-FORM,K-FORM-TURTLE \?CCL60
	PRINTI	", sees you on the floor, and picks you up. He carries you out of the tavern and drops you in the town square."
	JUMP	?CND58
?CCL60:	PRINTI	". He sees you and says"
	PRINT	K-GET-OUT-MSG
	ICALL1	RT-FORM-MSG
	PRINTI	"."" He shoos you out into the tavern, and the farmers shoo you out into the town square."
?CND58:	CRLF	
	CRLF	
	ICALL1	RT-RESET-TAVERN
	ICALL	RT-GOTO,RM-TOWN-SQUARE,TRUE-VALUE
?CND30:	CALL1	RT-RESET-KITCHEN
	RSTACK	


	.FUNCT	RT-TH-CAGE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	CALL1	TOUCH-VERB?
	ZERO?	STACK /?CCL5
	IN?	CH-COOK,RM-TAV-KITCHEN \?CCL5
	PRINT	K-HANDS-OFF-MSG
	RTRUE	
?CCL5:	CALL1	TOUCH-VERB?
	ZERO?	STACK /?CCL9
	ZERO?	GL-PLAYER-FORM /?CCL9
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL14
	PRINTR	"You flutter around the cage for a few moments, but don't make any progess."
?CCL14:	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER \?CCL16
	PRINTR	"You try to scope out a route that will take you up the wall, across the roof, and down towards the cage - but it looks like such a long journey that you decide to stay where you are."
?CCL16:	CALL2	RT-CANT-REACH-MSG,TH-CAGE
	RSTACK	
?CCL9:	EQUAL?	PRSA,V?OPEN \?CCL18
	FSET?	TH-CAGE,FL-OPEN \?CCL21
	CALL	RT-ALREADY-MSG,TH-CAGE,STR?143
	RSTACK	
?CCL21:	IN?	TH-BIRD,TH-CAGE \FALSE
	CALL1	RT-FREE-BIRD-MSG
	RSTACK	
?CCL18:	EQUAL?	PRSA,V?ENTER \?CCL25
	EQUAL?	GL-PLAYER-FORM,K-FORM-SALAMANDER /FALSE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?25
	PRINTI	" too big to fit in"
	ICALL	RT-PRINT-OBJ,TH-CAGE,K-ART-THE
	PRINTR	"."
?CCL25:	EQUAL?	PRSA,V?LISTEN \FALSE
	FSET?	TH-BIRD,FL-LOCKED /FALSE
	ICALL2	THIS-IS-IT,TH-BIRD
	PRINT	K-BIRD-SOUNDS-MSG
	RTRUE	


	.FUNCT	RT-TH-BIRD:ANY:0:1,CONTEXT
	EQUAL?	PRSA,V?THANK,V?GOODBYE,V?HELLO \?CCL3
	EQUAL?	CONTEXT,M-WINNER,FALSE-VALUE \?CCL3
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL8
	EQUAL?	PRSA,V?HELLO \?CCL11
	PRINTR	"""'Allo."""
?CCL11:	EQUAL?	PRSA,V?GOODBYE \?CCL13
	PRINTR	"""Mon Dieu! You can not leeve me 'ere. Zis man intends to COOK me. And with no spices!!! You cannot be so cruel."""
?CCL13:	EQUAL?	PRSA,V?THANK \FALSE
	PRINTI	"""Mais non. It is I who will be thanking you.""
"
	FSET?	CH-PLAYER,FL-AIR /TRUE
	FSET	CH-PLAYER,FL-AIR
	ICALL	RT-SCORE-MSG,10,0,0,0
	RTRUE	
?CCL8:	PRINT	K-BIRD-CHATTERS-MSG
	RTRUE	
?CCL3:	EQUAL?	CONTEXT,M-WINNER \?CCL19
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL22
	EQUAL?	PRSA,V?TELL-ABOUT \?CCL25
	EQUAL?	PRSO,CH-PLAYER /FALSE
?CCL25:	EQUAL?	PRSA,V?WHAT,V?WHO /FALSE
	EQUAL?	PRSA,V?WHERE \?CCL31
	EQUAL?	PRSO,TH-CUPBOARD-KEY \?CCL34
	PRINTR	"""I 'ave already told you thees. Ze key is in ze thatch."""
?CCL34:	EQUAL?	PRSO,TH-SPICE,TH-SPICE-BOTTLE \FALSE
	PRINTR	"""Ze spices, zey are 'idden away in ze cupboard."""
?CCL31:	PRINT	K-LET-OUT-MSG
	RTRUE	
?CCL22:	PRINT	K-BIRD-CHATTERS-MSG
	RTRUE	
?CCL19:	ZERO?	CONTEXT \FALSE
	ZERO?	NOW-PRSI \FALSE
	EQUAL?	PRSA,V?TELL \?CCL42
	ZERO?	P-CONT \FALSE
?CCL42:	EQUAL?	PRSA,V?ASK-ABOUT \?CCL46
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL49
	EQUAL?	PRSI,TH-BIRD \?CCL52
	PRINTR	"""I 'ave just flown in from ze coast, and mon dieu are my arms tired."""
?CCL52:	EQUAL?	PRSI,TH-CUPBOARD-KEY \?CCL54
	PRINTR	"""I 'ave already told you thees. Ze key is in ze thatch."""
?CCL54:	EQUAL?	PRSI,CH-COOK \?CCL56
	PRINTR	"""Ee ees a barbarian. 'Ow do I know thees? Ee overcooks ze food and ee 'as no knowledge of ze sauces. But I suppose eet ees not 'is fault - Ee ees English."""
?CCL56:	EQUAL?	PRSI,TH-SPICE-BOTTLE,TH-SPICE \?CCL58
	PRINTR	"""In thees country, ze spice is rare. Eet ees why I only come 'ere on 'olidays."""
?CCL58:	EQUAL?	PRSI,CH-MERLIN \?CCL60
	PRINTR	"""Eef 'ee ees such a great weezard, why does 'ee not make 'eemself ze gourmet dejeuner, instead of all ze time eating ze nuts and berries?"""
?CCL60:	EQUAL?	PRSI,CH-LOT \?CCL62
	PRINTR	"""Bah! I weel not speak of 'eem. 'Ee drinks red wine with ze feesh and white wine with ze meats. Surely when 'ee dies 'ee weel go to hell."""
?CCL62:	PRINT	K-LET-OUT-MSG
	RTRUE	
?CCL49:	PRINT	K-BIRD-CHATTERS-MSG
	RTRUE	
?CCL46:	CALL1	TOUCH-VERB?
	ZERO?	STACK /?CCL64
	IN?	CH-COOK,RM-TAV-KITCHEN \?CCL64
	PRINT	K-HANDS-OFF-MSG
	RTRUE	
?CCL64:	CALL1	TOUCH-VERB?
	ZERO?	STACK /?CCL68
	ZERO?	GL-PLAYER-FORM /?CCL68
	CALL2	RT-CANT-REACH-MSG,TH-CAGE
	RSTACK	
?CCL68:	EQUAL?	PRSA,V?EXAMINE \?CCL72
	FSET	TH-BIRD,FL-SEEN
	FSET?	TH-BIRD,FL-LOCKED \?CCL75
	ICALL	RT-PRINT-OBJ,TH-BIRD,K-ART-THE,TRUE-VALUE
	PRINTR	" is looking at you quizzically, waiting for you to make up your mind."
?CCL75:	IN?	TH-BIRD,TH-CAGE \?CCL77
	ICALL	RT-PRINT-OBJ,TH-BIRD,K-ART-THE,TRUE-VALUE
	PRINTR	" is hopping up and down in the cage, chattering at you."
?CCL77:	ICALL	RT-PRINT-OBJ,TH-BIRD,K-ART-THE,TRUE-VALUE
	PRINTR	" is flying around and chattering at you as if it is trying to tell you something."
?CCL72:	EQUAL?	PRSA,V?LISTEN \?CCL79
	FSET?	TH-BIRD,FL-LOCKED /?CCL79
	PRINT	K-BIRD-SOUNDS-MSG
	RTRUE	
?CCL79:	CALL1	SPEAKING-VERB?
	ZERO?	STACK /?CCL83
	EQUAL?	HERE,RM-TAV-KITCHEN \?CCL83
	EQUAL?	GL-PLAYER-FORM,K-FORM-OWL \?CCL88
	PRINT	K-LET-OUT-MSG
	RTRUE	
?CCL88:	PRINT	K-BIRD-CHATTERS-MSG
	RTRUE	
?CCL83:	EQUAL?	PRSA,V?TAKE \?CCL90
	IN?	TH-BIRD,TH-CAGE /?CCL90
	ICALL	RT-PRINT-OBJ,TH-BIRD,K-ART-THE,TRUE-VALUE
	PRINTR	" flutters just out of your reach."
?CCL90:	EQUAL?	PRSA,V?RELEASE \FALSE
	IN?	TH-BIRD,TH-CAGE \FALSE
	CALL1	RT-FREE-BIRD-MSG
	RSTACK	


	.FUNCT	RT-FREE-BIRD-MSG:ANY:0:0
	FSET	TH-CAGE,FL-OPEN
	FSET?	TH-BIRD,FL-LOCKED \?CCL3
	REMOVE	TH-BIRD
	MOVE	TH-CUPBOARD-KEY,RM-TAV-KITCHEN
	MOVE	TH-DROPPING,TH-TAVERN-TABLE
	PRINT	K-BIRD-GETS-KEY-MSG
	PRINT	K-DROPPING-MSG
	JUMP	?CND1
?CCL3:	MOVE	TH-BIRD,RM-TAV-KITCHEN
	ICALL	RT-PRINT-OBJ,TH-BIRD,K-ART-THE,TRUE-VALUE
	PRINTI	" comes out and flies around and around the room, pecking at your head and chattering as if it is trying to tell you something."
	CRLF	
?CND1:	FSET?	TH-BIRD,FL-BROKEN /?CND4
	FSET	TH-BIRD,FL-BROKEN
	ICALL	RT-SCORE-MSG,10,0,0,0
?CND4:	BOR	GL-UPDATE-WINDOW,K-UPD-DESC >GL-UPDATE-WINDOW
	EQUAL?	GL-WINDOW-TYPE,K-WIN-DESC \TRUE
	ICALL1	RT-UPDATE-DESC-WINDOW
	RTRUE	

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	RT-GN-BIRD:ANY:2:2,TBL,FINDER
	RETURN	TH-BIRD

	.ENDSEG

	.SEGMENT "TOWN"


	.FUNCT	RT-TH-CUPBOARD:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	CALL1	TOUCH-VERB?
	ZERO?	STACK /?CCL5
	IN?	CH-COOK,RM-TAV-KITCHEN \?CCL5
	PRINT	K-HANDS-OFF-MSG
	RTRUE	
?CCL5:	EQUAL?	PRSA,V?EXAMINE \FALSE
	FSET	TH-CUPBOARD,FL-SEEN
	PRINTI	"It's an old wooden cupboard that's"
	ICALL2	RT-OPEN-MSG,TH-CUPBOARD
	PRINTR	"."

	.ENDSEG

	.SEGMENT "0"


	.FUNCT	RT-TH-CUPBOARD-KEY:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?UNLOCK \FALSE
	EQUAL?	PRSO,TH-CUPBOARD \FALSE
	FSET?	TH-CUPBOARD,FL-LOCKED /?CCL10
	PRINTR	"The cupboard isn't locked."
?CCL10:	FCLEAR	TH-CUPBOARD,FL-LOCKED
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?367
	ICALL	RT-PRINT-OBJ,TH-CUPBOARD,K-ART-THE
	PRINTI	" with"
	ICALL	RT-PRINT-OBJ,TH-CUPBOARD-KEY,K-ART-THE
	PRINTR	"."


	.FUNCT	RT-TH-SPICE-BOTTLE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	CALL	NOUN-USED?,TH-SPICE-BOTTLE,W?SPICE
	ZERO?	STACK /?CCL5
	IN?	TH-SPICE,TH-SPICE-BOTTLE /?CCL5
	ZERO?	NOW-PRSI /?CCL11
	PUSH	2
	JUMP	?CND9
?CCL11:	PUSH	1
?CND9:	CALL2	EVERYWHERE-VERB?,STACK
	ZERO?	STACK \?CCL5
	CALL1	NP-CANT-SEE
	RSTACK	
?CCL5:	ZERO?	NOW-PRSI /?CCL13
	EQUAL?	PRSA,V?EMPTY,V?PUT-IN \FALSE
	PRINTR	"The neck is too narrow."
?CCL13:	EQUAL?	PRSA,V?DRINK-FROM \?CCL18
	IN?	TH-WATER,TH-SPICE-BOTTLE \?CCL21
	ICALL	PERFORM,V?DRINK,TH-WATER
	RTRUE	
?CCL21:	PRINTI	"There is nothing to drink in"
	ICALL	RT-PRINT-OBJ,TH-SPICE-BOTTLE,K-ART-THE
	PRINTR	"."
?CCL18:	EQUAL?	PRSA,V?READ,V?LOOK-ON,V?EXAMINE \?CCL23
	FSET	TH-SPICE-BOTTLE,FL-SEEN
	PRINTR	"The label on the bottle says ""Oriental Spices."""
?CCL23:	EQUAL?	PRSA,V?FILL \?CCL25
	EQUAL?	PRSI,TH-BARREL \?CCL28
	IN?	TH-BARREL-WATER,TH-BARREL /?CCL28
	PRINTI	"There isn't any "
	ICALL2	RT-PRINT-DESC,TH-WATER
	PRINTI	" in"
	ICALL	RT-PRINT-OBJ,TH-BARREL,K-ART-THE
	PRINTR	"."
?CCL28:	EQUAL?	PRSI,LG-LAKE,RM-SHALLOWS,LG-RIVER /?CCL32
	EQUAL?	PRSI,RM-FORD,TH-BARREL-WATER,TH-BARREL /?CCL32
	EQUAL?	PRSI,TH-WATER \FALSE
?CCL32:	IN?	TH-SPICE,TH-SPICE-BOTTLE /?CTR37
	IN?	TH-WATER,TH-SPICE-BOTTLE \?CCL38
?CTR37:	ICALL	RT-PRINT-OBJ,TH-SPICE-BOTTLE,K-ART-THE,TRUE-VALUE
	PRINTI	" is already filled with "
	FIRST?	TH-SPICE-BOTTLE /?BOGUS41
?BOGUS41:	ICALL2	RT-PRINT-DESC,STACK
	PRINTR	"."
?CCL38:	MOVE	TH-WATER,TH-SPICE-BOTTLE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?344
	ICALL	RT-PRINT-OBJ,TH-SPICE-BOTTLE,K-ART-THE
	PRINTI	" with "
	ICALL2	RT-PRINT-DESC,TH-WATER
	PRINTR	"."
?CCL25:	EQUAL?	PRSA,V?EMPTY \?CCL43
	IN?	TH-SPICE,TH-SPICE-BOTTLE \?CCL46
	REMOVE	TH-SPICE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?345
	PRINTI	" the spice out of the bottle, but it scatters in the breeze before it reaches"
	EQUAL?	PRSI,FALSE-VALUE,ROOMS,GLOBAL-HERE \?CCL49
	ICALL	RT-PRINT-OBJ,TH-GROUND,K-ART-THE
	JUMP	?CND47
?CCL49:	ICALL	RT-PRINT-OBJ,PRSI,K-ART-THE
?CND47:	PRINTC	46
	CRLF	
	CALL	RT-SCORE-MSG,0,-1,0,0
	RSTACK	
?CCL46:	IN?	TH-WATER,TH-SPICE-BOTTLE \FALSE
	REMOVE	TH-WATER
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?345
	ICALL	RT-PRINT-OBJ,TH-WATER,K-ART-THE
	PRINTI	" out of"
	ICALL	RT-PRINT-OBJ,TH-SPICE-BOTTLE,K-ART-THE
	PRINTC	46
	FSET?	HERE,FL-WATER \?CCL54
	PRINTR	" It disappears into the water."
?CCL54:	PRINT	K-EVAPORATES-MSG
	CRLF	
	RTRUE	
?CCL43:	EQUAL?	PRSA,V?OPEN \?CCL56
	CALL	RT-ALREADY-MSG,TH-SPICE-BOTTLE,STR?143
	RSTACK	
?CCL56:	EQUAL?	PRSA,V?BREAK \FALSE
	REMOVE	TH-SPICE-BOTTLE
	PRINTI	"You smash"
	ICALL	RT-PRINT-OBJ,TH-SPICE-BOTTLE,K-ART-THE
	PRINTI	", and it shatters into a thousand pieces."
	CRLF	
	CALL	RT-SCORE-MSG,0,-3,0,0
	RSTACK	


	.FUNCT	RT-GN-SPICE:ANY:2:2,TBL,FINDER
	GET	PARSE-RESULT,4
	EQUAL?	STACK,V?DROP /?CTR2
	RETURN	TH-SPICE
?CTR2:	RETURN	TH-SPICE-BOTTLE


	.FUNCT	RT-TH-SPICE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?EAT \?CCL5
	PRINTI	"Carefully,"
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,FALSE-VALUE,STR?368
	PRINTR	" a little of the spice. It tastes like pepper."
?CCL5:	EQUAL?	PRSA,V?TAKE \?CCL7
	IN?	TH-SPICE-BOTTLE,WINNER \?CCL10
	REMOVE	TH-SPICE
	ICALL	RT-PRINT-OBJ,WINNER,K-ART-THE,TRUE-VALUE,STR?345
	PRINTI	" the spice out of the bottle and it scatters on"
	ICALL	RT-PRINT-OBJ,TH-GROUND,K-ART-THE
	PRINTR	"."
?CCL10:	ICALL	PERFORM,V?TAKE,TH-SPICE-BOTTLE
	RTRUE	
?CCL7:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"The spice is light brown in color, and it is very fine-grained."

	.ENDSEG

	.SEGMENT "TOWN"


	.FUNCT	RT-TH-TAVERN-TABLE:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	EQUAL?	PRSA,V?CLIMB-OVER,V?CLIMB-ON,V?CLIMB-UP \FALSE
	PRINTI	"It's not polite to "
	PRINTB	P-PRSA-WORD
	PRINTR	" on tables."


	.FUNCT	RT-TH-DROPPING:ANY:0:1,CONTEXT
	ZERO?	CONTEXT \FALSE
	CALL1	TOUCH-VERB?
	ZERO?	STACK /FALSE
	CALL2	RT-AUTHOR-MSG,STR?369
	RSTACK	

	.ENDSEG

	.ENDI
