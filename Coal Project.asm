INCLUDE Irvine32.inc

.data
;main MainMenu display
GameName1			db "     << Number Crush >>",0
newGameChoice	db "       1 : Start new game",0
ExitChoice		db "       2 : Exit",0

;invalid statements
invalid1		db "Invalid Input!",0
invalid2		db "Invalid Input Program terminated!",0

;level MainMenu display.
levelChoice		db "       Select Game Level",0
Level1Choice	db "       1 : Level 1  ",0
Level2Choice	db "       2 : Level 2  " ,0
Level3Choice	db "       3 : Level 3  ",0

;Get Index Display.
getRowChoice	db "Enter Row Index (1 - 10) : ",0
getColChoice	db "Enter Column Index (1 - 10) : ",0
SelectedNum		db "Number Selected: ",0

;Swap With Choice.
SwapDirection	db "Enter Direction (1 = UP || 2 = DOWN || 3 = LEFT || 4 = RIGHT): ",0
;Name Input
playerNameInput	db "      Enter Player Name: ",0

;Spacings
Spaces1			db "    ",0
Spaces2			db "   ",0

;Above Board Display.
ColumnIndexes	db "		         C1    C2   C3   C4   C5   C6   C7   C8   C9  C10    ",0
getName			db "                    Name : ",0
getScore		db "                      Score : ",0
getMoves		db "                       Moves : ",0

Score			db 0
moves			db 15

;Special Blocks
bomb			db "B",0
Brick			db "X",0
EmptySpace		db " ",0

;GameBoard.
GameBoard Dword 10 DUP(0)
Rowsize = ($ - GameBoard)
		  Dword 10 DUP(0)
		  Dword 10 DUP(0)
		  Dword 10 DUP(0)
		  Dword 10 DUP(0)
		  Dword 10 DUP(0)
		  Dword 10 DUP(0)
		  Dword 10 DUP(0)
		  Dword 10 DUP(0)
		  Dword 10 DUP(0)

playername db 20 DUP (?)
;storing index for Swapping.
InputRow dword ?
InputCol dword ?

RowTen db "	       R",0
RowR   db "		R",0
RowN dword ?

;used for Swapping elements
temp dword ?
temp1 dword ?

.code

main PROC
call MainMenu
exit
main ENDP


Select PROC

mov esi, 0
mov ebx, 0
mov eax, 0
mov edx,offset getRowChoice
call WriteString
call crlf
call ReadDec

cmp eax,1
jg row2
add ebx,0
jmp checkcol

row2:
cmp eax,2
jg row3
add ebx,40 
jmp checkcol

row3:
cmp eax,3
jg row4
add ebx,80
jmp checkcol

row4:
cmp eax,4
jg row5
add ebx,120
jmp checkcol

row5:
cmp eax,5
jg row6
add ebx,160
jmp checkcol

row6:
cmp eax,6
jg row7
add ebx,200
jmp checkcol

row7:
cmp eax,7
jg row8
add ebx,240
jmp checkcol

row8:
cmp eax,8
jg row9
add ebx,280
jmp checkcol

row9:
cmp eax,9
jg row10
add ebx,320
jmp checkcol

row10:
mov ebx,360

checkcol:
mov edx,offset getColChoice
call WriteString 
call crlf
call ReadDec

cmp eax,1
jg col2
add esi,0
jmp checkComplete

col2:
cmp eax,3
jge col3
add esi,4
jmp checkComplete

col3:
cmp eax,4
jge col4
add esi,8
jmp checkComplete

col4:
cmp eax,5
jge col5
add esi,12
jmp checkComplete

col5:
cmp eax,6
jge col6
add esi,16
jmp checkComplete

col6:
cmp eax,7
jge col7
add esi,20
jmp checkComplete

col7:
cmp eax,8
jge col8
add esi,24
jmp checkComplete

col8:
cmp eax,9
jge col9
add esi,28
jmp checkComplete

col9:
cmp eax,10
jge col10
add esi,32
jmp checkComplete

col10:
mov esi,36
jmp checkComplete

checkComplete:

ret
exit
Select ENDP
Swap PROC

;choosing element to Swap.
call Select
mov edx,offset SelectedNum
call writestring
call crlf

;Selected item row index
mov InputRow,ebx
;Selected item column index
mov InputCol,esi

mov eax,GameBoard[ebx+esi]
cmp eax, 'X'
je FinishProc
mov temp,eax
call WriteDec
call crlf

;choosing where to Swap
;1 = up, 2 = down, 3 = left, 4 = right
mov edx, offset SwapDirection
call WriteString
call ReadDec

; choosing direction of Swap.
cmp eax, 1
je choose1
cmp eax, 2
je choose2
cmp eax, 3
je choose3
cmp eax, 4
je choose4

choose1:
sub esi, Rowsize
mov eax, GameBoard[ebx+esi]
jmp chooseDone
choose2:
add esi, Rowsize
mov eax, GameBoard[ebx+esi]
jmp chooseDone
choose3:
sub ebx, 4
mov eax, GameBoard[ebx+esi]
jmp chooseDone
choose4:
add ebx, 4
mov eax, GameBoard[ebx+esi]
jmp chooseDone

;now Swapping
chooseDone:
mov edx,offset SelectedNum
call WriteString
call WriteDec
cmp eax, 'X'
je FinishProc
mov temp1, eax
mov eax, temp
mov GameBoard[ebx+esi], eax
mov ebx, InputRow
mov esi, InputCol
mov eax, temp1
mov GameBoard[ebx+esi], eax


FinishProc:
call crlf
call crlf

ret
exit
Swap ENDP

MainMenu PROC

mov edx,offset GameName1
mov eax,LightRed+(black*16)
call settextcolor
call writestring
call crlf
call crlf


call waitmsg

call crlf

call clrscr



mov edx,offset newGameChoice

call writestring
call crlf

mov edx,offset ExitChoice
call writestring
call crlf

call crlf
call crlf

call ReadDec


cmp eax,1
je SelectLevel

cmp eax,2
je Break

ret
MainMenu ENDP
SelectLevel PROC

call clrscr

call EnterName
call crlf
mov eax,LightRed+(black*16)
call settextcolor
call waitmsg

call clrscr


mov edx,offset levelChoice
call writestring
call crlf

mov edx,offset Level1Choice
call writestring
call crlf

mov edx,offset Level2Choice
call writestring
call crlf

mov edx,offset Level3Choice
call writestring
call crlf

call crlf
call ReadDec

cmp eax,1
jb Break
je Level1

cmp eax,2
je Level2

cmp eax,3
je Level3
ja Break

ret
SelectLevel ENDP 
EnterName PROC

mov edx,offset playerNameInput
call writestring

mov edx,offset playername
mov ecx,20
call ReadString

ret
EnterName ENDP
Break PROC

mov edx,offset invalid2
call writestring
call crlf
call waitmsg

ret
Break ENDP

Level1 proc
mov ecx,15
;saving state of ecx before executing borad initialization.
push ecx
call Level1_Board_Initialize
pop ecx
Loop1:

call clrscr
call crlf

mov eax,lightGreen+(black*16)
call settextcolor

call headDisplay

mov eax,white+(black*16)
call settextcolor

call crlf
call crlf

;saving state of ecx before executing borad display.
push ecx
call Level1_Board_Disp
pop ecx

;swapping.
call Swap
;decreasing moves.
dec moves

loop Loop1

ret
Level1 endp
Level2 proc

mov ecx,15
;saving state of ecx before executing borad initialization.
push ecx
call Level2_Board_Initialize
pop ecx
Loop2:

call clrscr
call crlf

mov eax,yellow+(black*16)
call settextcolor

call headDisplay

;reseting color to white.
mov eax,white+(black*16)
call settextcolor

call crlf
call crlf

;saving state of ecx before executing borad display.
push ecx
call Level2_Board_Disp
pop ecx

;swapping
call Swap
;decreasing moves.
dec moves

loop Loop2

ret
Level2 endp
Level3 proc

mov ecx,15
;saving state of ecx before executing borad initializtion.
push ecx
call Level3_Board_Initialize
pop ecx
Loop3:

call clrscr
call crlf

mov eax,lightRed+(black*16)
call settextcolor

call headDisplay

;resetting color to white.
mov eax,white+(black*16)
call settextcolor

call crlf
call crlf

;saving state of ecx before executing borad display.
push ecx
call Level3_Board_Disp
pop ecx

;swapping.
call Swap
;decreasing moves.
dec moves

loop Loop3

ret
Level3 endp

headDisplay PROC

;priting name.
mov edx,offset getName
call writeString

mov edx,offset playername
call writestring

;printing score.
mov edx,offset getScore
call writestring

push eax
mov al,Score
call WriteDec
pop eax

;printing moves left.
mov edx,offset getMoves
call WriteString

push eax
mov al,moves
call writedec
pop eax

ret
headDisplay ENDP

Coloring proc

;comparing eax value to corresponding color to output.
cmp eax,1
je ColorItBrown3
cmp eax,2
je ColorItYellow3
cmp eax,3
je ColorItLightGreen3
cmp eax,4
je ColorItGray3
cmp eax,5
je ColorItCyan3
cmp eax,'B'     
je displaybomb3
cmp eax,'X'
je displayBrick3

displayBrick3:
mov eax,black+(white*16)
call settextcolor
mov edx,offset Brick
call WriteString
jmp ColorLevel3Terminate

 
displaybomb3:
mov edx,offset bomb
mov eax,red+(black*16)
call settextcolor
call WriteString
jmp ColorLevel3Terminate


ColorItLightGreen3:
push eax
mov eax,green+(black*16)
call settextcolor
pop eax
call WriteDec
jmp ColorLevel3Terminate

ColorItGray3:
push eax
mov eax,Gray+(black*16)
call settextcolor
pop eax
call WriteDec
jmp ColorLevel3Terminate


ColorItBrown3:
push eax
mov eax,brown+(black*16)
call settextcolor
pop eax
call WriteDec
jmp ColorLevel3Terminate


ColorItCyan3:
push eax
mov eax,cyan+(black*16)
call settextcolor
pop eax
call WriteDec
jmp ColorLevel3Terminate


ColorItYellow3:
push eax
mov eax,yellow+(black*16)
call settextcolor
pop eax
call WriteDec
jmp ColorLevel3Terminate


ColorLevel3Terminate:

;reseting color.
mov eax,white+(black*16)
call settextcolor
ret

Coloring endp

Level1_Board_Initialize PROC

mov ecx,10
mov edx,0
mov ebx,0
mov esi,0

call Randomize

L1:

push ecx
mov ecx,10
mov esi,0

L2:

;random range 0-5.
mov eax,6
call Randomrange
;increment to make range 1-6
inc eax
 
;number is 6 then save bomb.
cmp eax,6
je saveBomb

;other than bomb save number and go to next index.
mov GameBoard[ebx+esi],eax
jmp goNext

saveBomb:
mov GameBoard[ebx+esi],'B'

goNext:
;esi++ (next index)
add esi,Type GameBoard

loop L2

;next Row.
add ebx,rowsize
pop ecx

loop L1

ret
Level1_Board_Initialize ENDP
Level1_Board_Disp proc

mov edx,0
mov esi,0
mov edi,0
mov ebx,0
mov ecx,10
mov RowN, 0

call crlf
call crlf

mov eax,white+(black*16)
call settextcolor

mov edx,offset ColumnIndexes
call WriteString
call crlf
call crlf

L3:
push ecx
mov esi,0
mov ecx,10

inc RowN
call PrintRow

mov edx,offset Spaces1
call WriteString


L4:

mov edx,offset Spaces1
call WriteString

mov eax,GameBoard[ebx+esi]

cmp eax,'B'     
je PrintBomb

call Coloring

jmp printingNext

PrintBomb:

mov eax,red+(black*16)
call settextcolor
mov edx,offset bomb
call writestring
mov eax,white
call settextcolor

printingNext:
;esi++ (next index).
add esi,Type GameBoard

loop L4

mov edx,offset Spaces2
call WriteString

call crlf
call crlf

add ebx,rowsize
pop ecx

loop L3

ret
Level1_Board_Disp endp

Level2_Board_Initialize PROC
mov ecx,10     ;rows outer loop
mov edx,0
mov ebx,0
mov esi,0
mov edi,0

call Randomize

L1:
mov esi,0
mov edi,0
push ecx
mov ecx,10
L2:

;start range for non empty col index.
cmp esi,12
jae checkEnd
jb empty_1

checkEnd:
;end range for non empty col index.
cmp esi,28
jb saveValue
jae addNumber

addNumber:
;check range for non empty row.
cmp ebx,120
jae Next
jb empty_2

Next:
cmp ebx,280
jb saveValue
jae empty_2

empty_1:
cmp ebx,120
jae addNumber_2
jb empty_2

addNumber_2:
cmp ebx,280
jb saveValue
jae empty_2

empty_2:
mov GameBoard[ebx+esi],0
JMP skipBomb

saveValue:
;0-5 random.
mov eax,6
call Randomrange
;change range to 1-6
inc eax 
;add B here 

;if 6 then bomb.
cmp eax,6
je loadbomb
mov GameBoard[ebx+esi],eax 
jmp skipBomb

loadbomb:
mov GameBoard[ebx+esi],'B'

skipBomb:
;esi++ (next index)
add esi,4

loop L2

add ebx,rowsize

pop ecx
loop L1

ret
Level2_Board_Initialize ENDP
Level2_Board_Disp proc

mov ecx,10
mov edx,0
mov esi,0
mov ebx,0

mov RowN, 0

call crlf
call crlf

mov eax,white+(black*16)
call settextcolor

mov edx,offset ColumnIndexes
call WriteString
call crlf

mov eax,white+(black*16)
call settextcolor

call crlf

L1_Level2:
mov esi,0
push ecx
mov ecx,10

inc RowN
call PrintRow
mov edx,offset Spaces1
call WriteString

L2_Level2:

mov edx,offset Spaces1
call WriteString

;printing in board.
;seperate function because exceeding jmp size.
call PrintLevel2

loop L2_Level2

mov edx,offset Spaces2
call WriteString
call crlf

cmp ebx,80
jb Small
jae LargeBefore

LargeBefore:
cmp ebx,280
jb Large
jae Small

Small:
JMP ColorItne

Large:
ColorItne:
call crlf

add ebx,rowsize

pop ecx

loop L1_Level2


ret

Level2_Board_Disp endp
PrintLevel2 proc
;all conditions are same as initialization.

;start range for non empty col index.
cmp esi,12
jae NotEmpty
jb isEmpty1

;end range for non empty col index.
NotEmpty:
cmp esi,28
jb getValue
jae addNumbere

;check start range for non empty row.
addNumbere:
cmp ebx,120
jae NotEmpty1
jb printSpace

;check end range for non empty row.
NotEmpty1:
cmp ebx,280
jb getValue
jae printSpace

;check start range for empty col
isEmpty1:
cmp ebx,120
jae addNumber_2e
jb printSpace

;check end range for empty col
addNumber_2e:
cmp ebx,280
jae printSpace
jb getValue

printSpace:
mov edx,offset EmptySpace
call writestring
jmp gotoNextIndex


getValue:
mov eax,GameBoard[ebx+esi]
call Coloring

gotoNextIndex:
;esi++(next index)
add esi, 4

ret

PrintLevel2 endp

Level3_Board_Initialize proc

push ecx
mov ecx,10
mov edx,0
mov ebx,0
mov esi,0

call Randomize

L1_Level3:
push ecx
mov ecx,10
mov esi,0
L2_Level3:

;0-6 random
mov eax,7
call Randomrange
;1-7
inc eax
; bomb on 6
cmp eax,6
je loadbomb

;brick on 7
cmp eax,7
je loadBrick

mov GameBoard[ebx+esi],eax
jmp continueLevel_3
           
loadBrick:
mov GameBoard[ebx+esi],'X'
jmp continueLevel_3

loadbomb:
mov GameBoard[ebx+esi],'B'

continueLevel_3:
;esi++ (next index)
add esi,Type GameBoard

loop L2_Level3

add ebx,rowsize
pop ecx

loop L1_Level3

pop ecx
ret
Level3_Board_Initialize endp
Level3_Board_Disp proc

mov ecx,10     ;rows outer loop
mov edx,0
mov esi,0
mov edi,0
mov ebx,0

mov RowN, 0

call crlf
call crlf

mov eax,white+(black*16)
call settextcolor

mov edx,offset ColumnIndexes
call WriteString
call crlf

mov eax,white+(black*16)
call settextcolor
call crlf

Level3_1:
push ecx
mov ecx,10  ;inner loop column
mov esi,0

inc RowN
call PrintRow

mov edx,offset Spaces1
call WriteString


Level3_2:

mov edx,offset Spaces1
call WriteString

mov eax,GameBoard[ebx+esi]
call Coloring

;esi++ (next index)
add esi,Type GameBoard

loop Level3_2

mov edx,offset Spaces2
call WriteString

call crlf
call crlf

add ebx,rowsize

pop ecx

loop Level3_1

ret
Level3_Board_Disp endp

PrintRow PROC

;this funtion prints R(num) on displays.
;called in every display level function.
mov edx, offset RowR
mov eax, RowN
cmp eax, 10
jne skipIt
mov edx, offset RowTen
skipIt:
mov eax,white+(black*16)
call settextcolor
call WriteString
mov eax, RowN
call WriteDec
ret
PrintRow ENDP

END main