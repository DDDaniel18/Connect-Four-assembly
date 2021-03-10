; multi-segment executable file template.

data segment
    ; add your data here!   
                                                            
   HeadLineTxt     db  13,10,7 Dup(" ")," CCCC  OOOO  N   N N   N EEEE  CCCC TTTTT   FFFF  OOOO  U   U RRRR  "             
                   db  13,10,7 Dup(" "),"CC    OO  OO NN  N NN  N E    CC      T     F    OO  OO U   U R   R "           
                   db  13,10,7 Dup(" "),"C     O    O N N N N N N EEE  C       T     FFF  O    O U   U RRRR  "
                   db  13,10,7 Dup(" "),"CC    OO  OO N  NN N  NN E    CC      T     F    OO  OO UU UU R   R "
                   db  13,10,7 Dup(" ")," CCCC  OOOO  N   N N   N EEEE  CCCC   T     F     OOOO   UUU  R   R $"
                  
    
   InstructionsTxt db  13,10,10,7 Dup(" ")," "  
                   db  13,10,7 Dup(" "), "To win Connect Four you must be the first player to get four of"
                   db  13,10,7 Dup(" "), "your colored checkers in a row either horizontally, vertically" 
                   db  13,10,7 Dup(" "), "or diagonally.$"
                 
   Player1Txt      db  13,10,10,9,"    Please enter player 1 name(9 letters max): ", '$'
   Player2Txt      db  13,10,9,   "    Please enter player 2 name(9 letters max): ", '$'
                   
   Player1Name     db  10 Dup(?)  ;the name of the player 1                                               
   Player2Name     db  10 Dup(?)  ;the name of the player 2                                                                                                         
   KeyPressTxt     db  " Press any key to continue...", '$'                  
                                                                                                          
   Player1Color    db  ?                                                                                  
   Player2Color    db  ?                                                                                  
                                                                                                          
   ColorListTxt    db  "This is the colors list:", '$'                                                    
   ColorChooseTxt  db  ", please choose a color: ", '$'
   SameColorTxt    db  " already choose that color, try another one", '$'
   
   Matrix          db  0,0,0,0,0,0,0   ; row number 6                                                     
                   db  0,0,0,0,0,0,0   ; row number 5                                                     
                   db  0,0,0,0,0,0,0   ; row number 4
                   db  0,0,0,0,0,0,0   ; row number 3
                   db  0,0,0,0,0,0,0   ; row number 2
                   db  0,0,0,0,0,0,0   ; row number 1 
    
   GameBoard       db  13,10,10,"    1    2    3    4    5    6    7  "
                   db  13,10,   "  ____ ____ ____ ____ ____ ____ ____ "
                   db  13,10,   " |    |    |    |    |    |    |    |"
                   db  13,10,   " |    |    |    |    |    |    |    |"
                   db  13,10,   " |____|____|____|____|____|____|____|"
                   db  13,10,   " |    |    |    |    |    |    |    |"
                   db  13,10,   " |    |    |    |    |    |    |    |"
                   db  13,10,   " |____|____|____|____|____|____|____|"
                   db  13,10,   " |    |    |    |    |    |    |    |" 
                   db  13,10,   " |    |    |    |    |    |    |    |"
                   db  13,10,   " |____|____|____|____|____|____|____|"
                   db  13,10,   " |    |    |    |    |    |    |    |"
                   db  13,10,   " |    |    |    |    |    |    |    |"
                   db  13,10,   " |____|____|____|____|____|____|____|" 
                   db  13,10,   " |    |    |    |    |    |    |    |" 
                   db  13,10,   " |    |    |    |    |    |    |    |"
                   db  13,10,   " |____|____|____|____|____|____|____|" 
                   db  13,10,   " |    |    |    |    |    |    |    |"
                   db  13,10,   " |    |    |    |    |    |    |    |"
                   db  13,10,   " |____|____|____|____|____|____|____|", '$'                                                   
                                                                                                          
   TurnTxt         db  ", Its your turn now      $"                                                       
   PickTxt         db  "Please pick a colomn (1..7)  $"                                                   
   IllegalTxt      db  "Illegal input!, Please try again", '$'                                            
                                                                                                         
   RowsCheck       dw  0                                                                              
   ColsCheck       dw  0   
   
   Winner          db  0
                                                                                                      
   WinnerTxt       db  " is the winner!!",'$'                                                             
   DrawTxt         db  "Its a draw!!", '$'                                                                                                       
                                                                                 
                                                                                                          
   PlayAgainTxt    db  "Hit (R) to play again ", '$'
   QuitGameTxt     db  "Hit (Q) to quit the game", '$'                                                     
                 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                 
                 
ends

stack segment
    dw   128  dup(0)
ends

code segment
start:
; set segment registers:

      mov  ax, data
      mov  ds, ax
      mov  es, ax
    
  GAMESTART:
                                                             
      mov  bx, offset Matrix      ;- Adress of the matrix   \
      mov  cx, 42                 ;- Number of max turns     \
                                  ;                           \
  Again:                          ;                           / Restarting the game
                                  ;                          /
      mov  BYTE PTR [bx], 0       ;- Zero the location      /
      add  bx, 1                  ;- To the next locatoin  /
      loop Again
  
      call ClearScreen            ;- Procedore that clears the screen
                                  
      mov  al, 0                  ;\
      mov  bh, 0                  ; \
      mov  bl, 0ah                ;  \
      mov  cx, 2000               ;  / Set the text color to green
      mov  ah, 09h                ; /   
      int  10h                    ;/     
                                  
      mov  ah, 9                  ;\   
      lea  dx, HeadLineTxt        ;- Print head line
      int  21h                    ;/  
                                  
      mov  al, 0                  ;\
      mov  bh, 0                  ; \
      mov  bl, 0eh                ;  \
      mov  cx, 2000               ;  / Set the text color to yellow 
      mov  ah, 09h                ; /   
      int  10h                    ;/    
                                      
      lea  dx, InstructionsTxt    ;\
      mov  ah, 9                  ;- Print game instructions 
      int  21h                    ;/  
                                  
      mov  al, 0                  ;\
      mov  bh, 0                  ; \
      mov  bl, 0bh                ;  \
      mov  cx, 2000               ;  / Set the text color to light cyan
      mov  ah, 09h                ; /
      int  10h                    ;/
                                  
      lea  dx, Player1Txt         ;\
      mov  ah, 9                  ;- Print player one input text
      int  21h                    ;/
                                  
      mov  bx, Offset Player1Name ;\
      push bx                     ;- Get the first player's name
      call InputName              ;/
                                  
      lea  dx, Player2Txt         ;\                              
      mov  ah, 9                  ;- Print player two input text
      int  21h                    ;/                              
                                  
      mov  bx, Offset Player2Name ;\                          
      push bx                     ;- Get the second player's name
      call InputName              ;/  
      
      mov  dh, 17                 ;\
      mov  dl, 23                 ; \
      mov  bh, 0                  ;-- Set cursor location
      mov  ah, 2                  ; /
      int  10h                    ;/ 
      
      mov  al, 0                  ;\
      mov  bh, 0                  ; \
      mov  bl, 0dh                ;  \
      mov  cx, 100                ;  / Set the text color to light magenta 
      mov  ah, 09h                ; /   
      int  10h                    ;/   
                                  
      lea  dx, KeyPressTxt        ;\                              
      mov  ah, 9                  ;- Print key press text
      int  21h                    ;/                              
                                  
      mov  ah, 7                  ;\
      int  21h                    ;- Key input without printing it
                                  
      call ClearScreen            ;- Procedore that clears the screen
                                  
      push offset ColorListTxt    ;- Push the color list text to the stack 
                            
      call ColorList              ;- Procedure that print the color list                                        
      
      push offset Player1Color    ;- Address of Player one color\                             
      push 13                     ;- Row number to print         \
      push offset Player1Name     ;- Address of plyaer one name  / Push to the stack
      push offset ColorChooseTxt  ;- Text                       /
      call ColorChoose            ;- Call to the color choose procedure

ChooseAgain:
      
      push offset Player2Color    ;- Address of Player two color\                   
      push 15                     ;- Row number to print         \                  
      push offset Player2Name     ;- Address of plyaer two name  / Push to the stack              
      push offset ColorChooseTxt  ;- Text                       /                   
      call ColorChoose            ;- Call to the color choose procedure
      
      cmp  al, Player1Color       ;- Check if player two choose like player one
      je   SameColor              ;/
      
      jmp  Next10
      
SameColor: 
     
      mov  dh, 17                
      mov  dl, 10                 ;\
      mov  bh, 0                  ; \
      mov  ah, 2                  ; / Set cursor position   
      int  10h                    ;/    
                                 
      mov  al, 0                  ;\
      mov  bh, 0                  ; \
      mov  bl, 0ch                ;  \
      mov  cx, 50                 ;  / Set the text color to red 
      mov  ah, 09h                ; /   
      int  10h                    ;/    
                                 
      lea  dx, Player1Name        ;\
      mov  ah, 9                  ;- Print player 1 name
      int  21h                    ;/
                                 
      lea  dx, SameColorTxt       ;\
      mov  ah,9                   ;- Print same color text
      int  21h                    ;/  
                                 
      mov  dh, 17                
      mov  dl, 10                 ;\
      mov  bh, 0                  ; \
      mov  ah, 2                  ; / Set cursor position to the text beggining  
      int  10h                    ;/
                                 
      mov  cx, 0fh                ;\
      mov  dx, 4240h              ; \ Wait 1 million microseconds (= 1 second)
      mov  ah, 86h                ; / before deleting the text
      int  15h                    ;/                                            
                                                                                                    
      mov  al, 20h                ;\                                               
      mov  cx, 50                 ; \                         
      mov  ah, 9                  ; / Print space to delete the text                                                               
      int  10h                    ;/ 
      
      jmp  ChooseAgain
      
 Next10:       

      mov  dh, 19                 ;\
      mov  dl, 23                 ; \
      mov  bh, 0                  ;-- Set cursor location
      mov  ah, 2                  ; /
      int  10h                    ;/ 

      lea  dx, KeyPressTxt        ;\                              
      mov  ah, 9                  ;- Print key press text
      int  21h                    ;/
                            
      mov  ah, 7                  ;\
      int  21h                    ;- Key input without printing it
                                  
      call ClearScreen            ;- Procedore that clear the screen
                                  
      lea  dx, GameBoard          ;\
      mov  ah, 9                  ;- Print the game board
      int  21h                    ;/
      
      xor  dh, dh
                                  
      mov  cx, 1                  ;- Player one: number \ 
      lea  bx, Player1Name        ;-             name   - Player one start the game
      mov  dl, Player1Color       ;-             color  / 
                                  
      mov  ax, 0                  ;- Turns Counter
                                  
   Turn:
      
      push  cx                    ;- Player number          \
      push  bx                    ;- Player name adress      \
      push  dx                    ;- Player color            |
      push  offset ColsCheck      ;- Location of the disc    |
      push  offset RowsCheck      ;/                         |- Push to the stack
      push  offset matrix         ;- Address of the matrix   |
      push  offset TurnTxt        ;\                         |
      push  offset PickTxt        ;- Text                    /
      push  offset IllegalTxt     ;/                        /
                       
      call  PlayerTurn            ;- Call the player turn procedure
        
      inc   ax                    ;- Increase turns counter
      
      cmp   ax, 7                 ;- The minimum turns to possibly win
      jb    Next0 
      
      push  offset Winner         ;- To save the winner                          \                            
      push  offset Matrix         ;- Address of the matrix                        \                            
      push  ax                    ;- Turns counter                                |                              
      push  ColsCheck             ;- Location of the disc in the array that       |- Push to the stack                  
      push  RowsCheck             ;/ has been set in the PlayerTurn procedure     /                         
      push  cx                    ;- Player Number of the last turn              /                          
                                                                                                               
      call  WinCheck              ;- Procedure that check if the last turn won                      
                                                                                                                 
      cmp   Winner, 1             ;- Check if player 1 won
      je    Player1Won            ;/
                                   
      cmp   Winner, 2             ;- check if player 2 won
      je    Player2Won            ;/
            
      cmp   Winner, 3             ;- check if it is a draw
      je    Draw                  ;/
  
  Next0:    
    
      cmp  cx, 2                  ;- Check if the cuurent player is player 2
      je   ChangePlayer           ;/
                                  
      mov  cx, 2                  ;\ 
      lea  bx, Player2Name        ;- Switch the current player from 1 to 2
      mov  dl, Player2Color       ;/
                                  
      jmp  Turn                   
                                  
  ChangePlayer:                   
                                  
      mov  cx, 1                  ;\ 
      lea  bx, Player1Name        ;- Switch the current player from 2 to 1
      mov  dl, Player1Color       ;/ 
                                  
      jmp  Turn                   
                                  
  Player1Won:
      
      xor  bh, bh                 ;\                  \
      mov  bl, Player1Color       ;- Player one color  \
      push bx                     ;/                   - Push to the stack
      push offset Player1Name     ;- Player one name   /
      push offset WinnerTxt       ;- Text             /
      
      call WinDrawPrint
                           
      jmp  EndGame                ;- The game is over
                                  
  Player2Won: 
      
      xor  bh, bh                 ;\                  \                   
      mov  bl, Player2Color       ;- Player two color  \                  
      push bx                     ;/                   - Push to the stack
      push offset Player2Name     ;- Player two name   /                  
      push offset WinnerTxt       ;- Text             /                   
                                                                          
      call WinDrawPrint                      
                                  
      jmp  EndGame                ;- The game is over
      
  Draw:     
      
      xor  bh, bh                 ;\                  \                       
      mov  bl, 0bH                ;- Light cyan color  \  - Push to the stack
      push bx                  
      push 0                      ;- No name           /                      
      push offset DrawTxt         ;- Text             /                      
                                   
      call WinDrawPrint
    
  EndGame:
  
      mov  dh, 12                 ;\                      
      mov  dl, 48                 ; \                     
      mov  bh, 0                  ;-- Set cursor location 
      mov  ah, 2                  ; /                     
      int  10h                    ;/ 
                                                                                                                       
      lea  dx, PlayAgainTxt       ;\
      mov  ah, 9                  ;- Print play again text
      int  21h                    ;/ 
                                     
      mov  dh, 13                 ;\                      
      mov  dl, 48                 ; \                     
      mov  bh, 0                  ;-- Set cursor location 
      mov  ah, 2                  ; /                     
      int  10h                    ;/ 
      
      lea  dx, QuitGameTxt        ;\
      mov  ah, 9                  ;- Print quit game text
      int  21h                    ;/  
      
      mov ch, 32                  ;\
      mov ah, 1                   ;- Hide blinking cursor
      int 10h                     ;/

 TryAgain:
      
      mov  ah, 7                  ;\
      int  21h                    ;- Input letter without printing it

      cmp  al, 'R'                ;- Check if the inputted letter is 'R'
      je   GAMESTART              ;/ and the player want to play again
      
      cmp  al, 'r'                ;- Check again with small letter
      je   GAMESTART              ;/  
 
      cmp  al, 'Q'                ;- Check is the inputted letter is 'Q'
      je   GAMEOVER               ;/ and the player want to quit the game
            
      cmp  al, 'q'                ;- Check again with small letter
      je   GAMEOVER               ;/    
      
      jmp  TryAgain               ;- If the input wrong try again
      
  GAMEOVER:
   
      mov  ax, 4c00h              ;- Exit to operating system.
      int  21h
        
    ;=======================================================================================;
    ;The procedure gets from the stack: the address of where the player will enter his name ;
    ;and puts in it the name the procedure gets.                                            ;
    ;=======================================================================================;
    
 InputName Proc  
     
     Name = [bx]          ;- Easyier to read
                          
     mov bp, sp           ;- Pointer to returning address where the             
                          ;/ procedure parameters are located below of it
     push ax              ;\
     push bx              ; \
     push cx              ;-- Store registers
     push dx              ; /
     push si              ;/
                          
     mov bx, [bp + 2]     ;- Addres of where the name will enter
     mov cx, 9            ;- Counter
     mov si, 0            ;- Index of the name
                          
 GetLetter:               
                          
     mov ah, 7            ;- Get letter with out printing it AL gets the letter
     int 21h              ;/                                
                          
     cmp al,0Dh           ;- check if enter was entered
     je Enter             ;/
                          
     cmp si,0             ;- If si == 0 - only big letters 
     jne SmallLet         ;/ else only small letters
                               
     cmp al,'A'           ;\                                                      
     jb  GetLetter        ;- Check if ascii code which was enterd if bigger then 'A' \                     
                          ;                                                           big letter
     cmp al,'Z'           ;- Check if ascii codew hich was enterd is smaller then 'Z'/
     jbe OkLetter         ;/                                                       
                             
     jmp GetLetter           
                             
 smallLet:                   
                             
     cmp al, 'a'          ;\         
     jb GetLetter         ;- Check if ascii code which was enterd is bigger then 'a' \                                                          
                          ;                                                           small letter
     cmp al, 'z'          ;- Check if ascii code which was enterd is smaller then 'z'/         
     jbe OkLetter         ;/                                                              
                                 
 okLetter:                
                          
     mov Name[si],al      ;- Save the Letter
     inc si               ;- Increase index of the name
                          
     mov ah,2             ;\
     mov dl,al            ;- Print the chosen Letter
     int 21h              ;/
                          
     loop GetLetter       
                          
 enter:                   ;- If enter was enterd
                          
     cmp si, 0            ;- If Index is still by 0 then get again letter
     je GetLetter         ;/ otherwise carry on
                          
     mov Name[si],'$'     ;- Move '$' to the end of the name
                          
     pop si               ;\
     pop dx               ; \
     pop cx               ;-- Restore registers
     pop bx               ; /
     pop ax               ;/
     
     ret 2
        
    InputName ENDP 
     
    ;=====================================;
    ; The procedure clears the screen     ;
    ;=====================================;
    
    ClearScreen Proc
        
     push ax                ;\
     push bx                ; \
     push cx                ; / Store registers
     push dx                ;/
                           
     xor ah,ah              ;\
     mov al,3               ;-  Clear the screen
     int 10h                ;/  
                           
     mov al, 0              ;\
     mov bh, 0              ; \
     mov bl, 0fh            ;-- Set the text color to white
     mov cx, 2000           ; / 
     mov ah, 09h            ;/   
     int 10h               
                           
     pop dx                 ;\
     pop cx                 ; \  
     pop bx                 ; / Restore registers
     pop ax                 ;/       
      
     ret 
        
    ClearScreen ENDP  
    
   ;===========================================================;
   ;The procedure gets from stack: the address of ColorListTxt ;
   ;The procedure print the list of the colors the player can  ;
   ;for his discs choose                                       ;
   ;===========================================================;
      
    ColorList proc
        
     mov bp, sp              ;\  pointer to returning address where the             
                             ;-  procedure parameters are located below of it 
                             
     push ax                 ;\
     push bx                 ; \
     push cx                 ; / Store registers
     push dx                 ;/
                             
     mov  dh, 3              ;\
     mov  dl, 2              ; \
     mov  bh, 0              ;-- Set cursor position
     mov  ah, 2              ; /   
     int  10h                ;/   
                             
     mov  dx, [bp + 2]       ;\
     mov  ah, 9              ;- Print color list text
     int  21h                ;/  
                             
     mov  cx, 15             ;- Counter of the colors 
     mov  bl, 1              ;- First color code 
     mov  si, 0              ;- Counter of the numbers below the colors                       
                                
     mov  dh, 7              ;- Printing row's position 
     mov  dl, -2             ;- Printing clomn's start position
                             
NextColor:                   
                             
     push cx                 ;- To keep the counter of number
     
     add  dl, 5              ;- Space between colors
                             
     mov  bh, 0              ;\
     mov  ah, 2              ;- Set cursor position with last variables  
     int  10h                ;/ 
                             
     mov  al, 0dbh           ;\
     mov  cx, 2              ; \
     mov  ah, 9              ; / Print the color box
     int  10h                ;/ 
                             
     add  dh, 2              ;\                       
     mov  ah, 2              ;- Set cursor position to print the number 
     int  10h                ;/ below the color
                             
     inc  si                 ;- Inc the number below the color     
     mov  ax, si             ;- To check the number
                             
     cmp  ax, 0Ah            ;\
     jge  LetterPrint        ;- Check if the numer is letter
                             
     add  ax, '0'            ;- Add '0' = 30h to the number to get the
                             ;/ ASCII code of the number
     jmp  NextCode              
                             
 LetterPrint:                
                             
     add  ax, '7'            ;- Add '7' = 37h to the number to get the 
                             ;/ ASCII code of the letter               
 NextCode:                   
                             
     mov  cx, 1              ;\
     mov  ah, 9              ;- Print the number that located in AL  
     int  10h                ;/  
                               
     sub  dh, 2              ;- Return to colors line
     inc  bl                 ;- Next color code 
     pop  cx                 ;- The counter of numbers
                                
     loop NextColor          ;- Jump to print the next color 
                             
     pop dx                  ;\
     pop cx                  ; \  
     pop bx                  ; / Restore registers
     pop ax                  ;/                   
                             
     ret 2                   ;- Bite size of procedure stack
     
    ColorList endp
    
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                                     
   ;==================================================================================;       
   ;The procedure gets from stack:                                                    ;
   ;                                                                                  ;
   ; 1. The address of the player color                                               ; 
   ; 2. The line number to print                                                      ;
   ; 3. The address of the player name                                                ;
   ; 4. The address of Color choose text                                              ;                                         ;                     
   ;                                                                                  ;
   ; The procedure print the player name in his print row and ask him to choose a     ;
   ; color from the list above than it check if the number he has inputted is legal   ;
   ; and if it number or letter and than it enter to the color adress as a background ;  
   ; color                                                                            ;
   ;==================================================================================;
   
     ColorChoose proc
     
     mov  bp, sp             ;\  pointer to returning address where the        
                             ;-  procedure parameters are located below of it
                               
     push ax                 ;\
     push bx                 ; \
     push cx                 ; / Store registers
     push dx                 ;/ 
                           
     mov  dh, [bp + 6]       ;- Row number for Player print 
     mov  dl, 5              ;\
     mov  bh, 0              ; \
     mov  ah, 2              ; / Set cursor position  
     int  10h                ;/
                              
     mov  dx, [bp + 4]       ;\
     mov  ah, 9              ;- Print player name 
     int  21h                ;/ 
                             
     mov  dx, [bp + 2]       ;\
     mov  ah, 9              ;- Print color choose text
     int  21h                ;/
                             
Illigle:                     
                             
     mov  ah, 7              ;\
     int  21h                ;- Number input to AL without printing it
                             
     xor  ah, ah             ;- to check the number
                             
     cmp  al, '0'            ;\
     jl   Illigle            ;- Check if the entered number is smaller than '0' \
                             ;                                                  - The limits of the numbers
     cmp  al, 'F'            ;- chcck if the entered number is bigger than 'A'  /
     jg   Illigle            ;/ 
     
     cmp  al, '9'            ;- Check if the entered number is in the illigle territory
     jg   CheckIfSymbol      ;/
     
     jmp  Next12    
     
CheckIfSymbol:

     cmp  al, 'A'            ;- Continue the check above
     jl   Illigle            ;/
         
Next12:     
                             
     mov  dl, al             ;\
     mov  ah, 2              ;- Print the number that located in AL  
     int  21h                ;/ 
                             
     cmp  al, 'A'            ;\
     jge  LetterInput        ;- Check if the entered number is a letter 
                             
     sub  al, '0'            ;- Substract '0' = 30h to the number to get the
                             ;/ ASCII code of the number  
     jmp  NextCode1          
                             
LetterInput:                 
                             
     sub  al, '7'            ;- Substract '7' = 37h to the number to get the 
                             ;/ ASCII code of the number  
NextCode1:      
                       
     shl  al, 4              ;- To get background color
     
     mov  bx, [bp + 8]
     mov  [bx], al           ;- Move the color code to player 1 color   
                                           
     pop  dx                 ;\                     
     pop  cx                 ; \                    
     pop  bx                 ; / Restore registers  
     pop  ax                 ;/                 
                                                  
     ret  8                  ;- Bite size of procedure stack
                             
                             
     ColorChoose endp        
                             

     ;=========================================================================; 
     ; The procedure gets from stack:                                          ;
     ;                                                                         ;                            
     ;  1. the player number                                                   ;         
     ;  2. the address of the player name                                      ;                                                             
     ;  3. the player color                                                    ;
     ;  4. the address of ColsCheck                                            ;
     ;  5. the address of RowsCheck                                            ;                                                 
     ;  6. the address of the matrix                                           ;
     ;  7. the address of the TurnTxt                                          ;   
     ;  8. the address of the PickTxt                                          ;
     ;  9. the address of the IllegalTxt                                       ; 
     ;                                                                         ;
     ; The procedure ask the player to pick a colomn and check if the input is ;
     ; legal (and if not he input again) than it calculate the disc position   ;
     ; in the game board, store it in the matrix by the player number and save ; 
     ; the location to check if win next, and than print an animation of the   ;  
     ; disc falling                                                            ;
     ;=========================================================================;
   
   PlayerTurn  Proc

     mov  bp, sp             ;-  Pointer to returning address where the        
                             ;/  procedure parameters are located below of it
                              
     push ax                 ;\
     push bx                 ; \
     push cx                 ;  \
     push dx                 ;  / Store registers
     push si                 ; /
     push di                 ;/       
                             
PlayerTurn1:                
                            
     mov  dh, 6              ;\
     mov  dl, 45             ; \
     mov  bh, 0              ;-- Set cursor position
     mov  ah, 2              ; /
     int  10h                ;/
                            
     mov  dx, [bp + 16]      ;\ 
     mov  ah, 9              ;- Print current player name
     int  21h                ;/
                            
     mov  dx, [bp + 6]       ;\
     mov  ah, 9              ;- Print player turn text    
     int  21h                ;/
                            
     mov  dh, 7              ;\                     
     mov  dl, 45             ; \                    
     mov  bh, 0              ;-- Set cursor position
     mov  ah, 2              ; /                    
     int  10h                ;/
                            
     mov  dx, [bp + 4]       ;\                       
     mov  ah, 9              ;- Print player pick text
     int  21h                ;/
                            
     mov  dh, 7              ;\                     
     mov  dl, 73             ; \                    
     mov  bh, 0              ;-- Set cursor position
     mov  ah, 2              ; /                    
     int  10h                ;/                       
                            
     mov  ah, 7              ;- The player choose a colomn
     int  21h                ;- Input number to AL without printing it
                             ;/ 
                             
     cmp  al, '1'            ;\
     jb   Error              ;- Check if the inputted number is below '1'\
                             ;                                            The limits of colomn
     cmp  al, '7'            ;- Check if the inputted number is above '7'/
     ja   Error              ;/
                            
     mov  ah, 2              ;\
     mov  dl, al             ;- If the number lligle print it 
     int  21h                ;/
                            
     jmp  Continue          
                            
Error:                      
                            
     mov  dh, 9              ;\                      
     mov  dl, 45             ; \                     
     mov  bh, 0              ;-- Set cursor position 
     mov  ah, 2              ; /                     
     int  10h                ;/ 
                            
     mov  al, 0              ;\
     mov  bh, 0              ; \
     mov  bl, 0ch            ;  \
     mov  cx, 32             ;  / Set the text color to red
     mov  ah, 09h            ; /   
     int  10h                ;/  
                            
     mov  ah, 9              ;\    
     mov  dx, [bp + 2]       ;- Print illigle input text
     int  21h                ;/  
                            
     mov  dh, 9              ;\                      
     mov  dl, 45             ; \                     
     mov  bh, 0              ;-- Set cursor position to the text beggining                      
     mov  ah, 2              ; /                                                                
     int  10h                ;/  
                            
     mov  cx, 0fh            ;\
     mov  dx, 4240h          ; \ Wait 1 million microseconds (= 1 second)
     mov  ah, 86h            ; / before deleting the text
     int  15h                ;/                                            
                                                                                                
     mov  al, 20h            ;- Space ASCII code                                                
     mov  cx, 32             ;- The length of the illegal input text                            
     mov  ah, 9              ;\                                                                 
     int  10h                ;- Print space to delete the text                                  
                                                                                                
     jmp  PlayerTurn1        ;- Start the turn again                                            
                                                                                                
Continue:                                                                                       
                                                                                                
     xor  ah, ah             ;\                                                                 
     xor  dh, dh             ; \                                                                
     xor  dx, dx             ; / Restart registers to use in the next code                      
     xor  bx, bx             ;/                                                                 
     mov  si, 0                                                                                 
                                                                                                
     mov  di, 6              ;- Counter the of rows to print                                    
                                                                                                
     sub  al, 30h            ;- To get the inputed number from ASCII to Decimal                 
     mov  si, ax             ;- For the check                     
     sub  si, 1              ;- In Arrays the index start from zero                             
                                                                                              
CheckAgain:                                                                                   
     
     push bx                 ;- Save the location to the rest of the check
     push si                 ;/
     
     add  si, bx             ;- Merge the location
     mov  bx, [bp+8]         ;- The address of the matrix
                                                                                              
     cmp  [bx][si], 0        ;- Check if there is a disc in the chosen colomn             
     jg   JumpRow            ;/                                                           
     
     pop  si
     pop  bx
                                                                                          
     jmp  CheckEnd           ;- Jump to the end of the check                              
                                                                                          
JumpRow:

     pop  si
     pop  bx                                                                                  
                                                                                          
     dec  di                 ;- Decrement the Counter of the rows to print                
     add  bx, 7              ;- Add 7 to BX to check the the next row                     
                                                                                          
     cmp  di, -1             ;- If DI = 0 the colomn is full therefore the                
     je   Error              ;/ choise is illigle
                         
     jmp  CheckAgain         ;- Check the next row
                         
CheckEnd:                
                         
     mov  cx, [bp + 18]      ;- Move the player number to CX
     
     push bx                 ;- Save the location to the rest of the check
     push si                 ;/ 
     
     add  si, bx             ;- Merge the location
     mov  bx, [bp + 8]       ;- The address of the matrix
     
     mov  [bx][si], cl       ;- move player number to the chosen place
                             ;/ in the Game Matrix  
     pop  si
     pop  bx                            
           
     mov  cx, bx             ;\
     mov  bx, [bp + 10]      ; \  
     mov  [bx], cx           ;-- Store the location of the last turn to later check if win                                                           
     mov  bx, [bp + 12]      ; /                                                                    
     mov  [bx], si           ;/

                           
     mov  si, 0              ;- Counter of the printed rows 
                             
     mov  bx, 5              ;- Multipicate the inputted number by 5 to get
     mul  bx                 ;/ the number for the print coordinates
                             
     mov  ch, 2h             ;- The row number of disc's upper left corner. 
                             
     mov  cl, -2h            ;- The colomn number of disc's upper left corner.
     add  cl, al             ;- Add the number of the inputted colomn 
                             
     mov  dh, 2h             ;- The row number of disc's upper lower right corner.
                             
     mov  dl, -1h            ;- The colomn number of disc's lower right corner.
     add  dl, al             ;- Add the number of the inputted colomn 
                             
PrintAgain:                  
                             
     add  ch, 3              ;- Add to the rows coordinate to print lower
     add  dh, 3              ;/ every time
                             
     inc  si                 ;- inc the counter of the printed rows
                             
     mov  al, 00h            ;\
     mov  bh, [bp + 14]      ;- Print disc (=window) with the coordinates 
     mov  ah, 6              ;- that has been set before and with player color
     int  10h                ;/
                             
     cmp  si, di             ;- Check if printed rows counter is equel to the rows 
     je   end                ;/ to print and if so stop the print  
                             
     mov  al, 00h            ;\
     mov  bh, 00h            ;- Print a black disc in the same locations of the colored
     mov  ah, 6              ;- disc to make an illusion of falling disc
     int  10h                ;/
                             
     jmp  PrintAgain         ;- Print the next disc in the colomn
                             
end:                         
                             
     pop  di                 ;\     
     pop  si                 ; \
     pop  dx                 ;  \
     pop  cx                 ;  / Restore registers
     pop  bx                 ; /
     pop  ax                 ;/
                             
     ret  18                 ;- Bite size of procedure stack 
                 
    PlayerTurn  ENDP 
    
   ;=====================================================================================;
   ; The procedure gets from the stack:                                                  ;
   ;                                                                                     ;
   ;  1. The address of winner                                                           ;
   ;  2. The address of the matrix                                                       ;
   ;  3. The turns counter                                                               ;
   ;  4. The address of ColsCheck                                                        ;
   ;  5. The address of RowsCheck                                                        ;
   ;  6. The Player number                                                               ;
   ;                                                                                     ;
   ;  The procedure check the horizonal vertical main and secondary diagonal options     ;         
   ;  in order ro check if the last player succeeded to conecct four and win the game    ;
   ;  and save his number in the winner valiuabale or he didnt and chreck if the game    ;
   ;  arrive to the maximum turn number and than it is a draw and the winner equel       ;
   ;  three or the game countinue and winner equel zero                                  ;
   ;=====================================================================================;
    
    WinCheck Proc 
       
    mov  bp, sp              ;\  pointer to returning address where the        
                             ;-  procedure parameters are located below of it
                           
     push ax                 ;\       
     push bx                 ; \
     push cx                 ;  \
     push dx                 ;  / Store registers
     push si                 ; /
     push di                 ;/
     
     mov  cx, [bp + 2]       ;- Player number to check 
     mov  bx, [bp + 4]       ;- Current disc location to check - BX = row location
     mov  si, [bp + 6]       ;/                                  SI = colomn loacaion
                              
                 
     mov  di, 5              ;- Counter of horizontal possible win options
                             ;- (SI,CX,CX,CX) (CX,SI,CX,CX) (CX,CX,SI,CX) (CX,CX,CX,SI)
                             ;- SI - represent current disc to check
                             ;/ CX - represent other disc of the currnent player
     add  si, 5              ;- Because every check its down by 5 - five cols                        
                              
 HorizonalCheck:
      
     dec  di                 ;- Decrement counter of possible win options
     sub  si, 5              ;- For the next check
     mov  ax, 0              ;- Zero the counter of the streak of same player discs
     mov  ch, 0              ;- Counter of checks  
  
 HorizonalCont:
 
     cmp  di, 0              ;\
     je   NextCheck          ;- Run out of check options 
     
     cmp  si, 0              ;\
     jl   Next7              ; \
                             ;-- Check if the disc is out of the limits of the matrix
     cmp  si, 6              ; /
     jg   Next7              ;/
      
     push bx                 ;- Save the location to the rest of the check 
     push si                 ;/                                            
                                                                           
     add  si, bx             ;- Merge the location                         
     mov  bx, [bp+10]        ;- The address of the matrix                                 
      
     cmp  [bx][si], cl       ;- Check if the disc is not equel to the
     jne  Next5              ;/ player number and if so try the next option
    
     inc  ax                 ;- If the disc equel to the player number
                             ;/ increse the streak counter 
 Next5:
 
     pop si
     pop bx
         
 Next7:
 
      inc  si                 ;- To check the next disc
      inc  ch
      
      cmp  ax, 4              ;- If the streak counter equel four the player won
      je   PlayerWon          ;/   
      
      cmp  ch, 4              ;- If the check did 4 times and didn'd won move to
      je   HorizonalCheck     ;/ the next option
                                                                            
      jmp  HorizonalCont      ;- Check the next disc
 
 NextCheck:
 
      mov  bx, [bp + 4]       ;- Current disc location to check - BX = row location
      mov  si, [bp + 6]       ;/                                  SI = colomn loacaion
      
                              ;- One vertical possible win options--------------- (SI)      
                              ;- Starting from row number 4 only                  (CX)
                              ;- SI - represent current disc to check             (CX)
                              ;/ CX - represent other disc of the currnent player (CX) 
                              
      cmp  bx, 18             ;- Vertical row win is possible from row number 4 only     
      jl   NextCheck1         ;/
      
      mov  ax, 0              ;- Zero the counter of the streak of same player discs                                               
   
 VerticalCheck:
     
      push si                 ;- Save the location to the rest of the check 
      push bx                 ;/                                            
                                                                            
      add  si,bx              ;- Merge the location                         
      mov  bx, [bp +10]       ;- The address of the matrix                  
                         
      cmp  [bx][si], cl       ;- Check if the disc is not equel to the
      jne  Next8              ;/ player number and if so try the next check 
      
      pop  bx 
      pop  si
      
      inc  ax                 ;- If the disc equel to the player number  
                              ; \increse the streak counter  
      sub  si, 7              ;- To check the disc from row below
                               
      cmp  ax, 4              ;- If the streak counter equel four the player won
      je   PlayerWon          ;/  
      
      jmp  VerticalCheck      ;- Check the next disc
      
 Next8:     
      pop bx
      pop si
      
 NextCheck1: 
       
      mov  bx, [bp + 4]       ;- Current disc location to check - BX = row location
      mov  si, [bp + 6]       ;/                                  SI = colomn loacaion
      
      mov  di, 5              ;- Counter of main diagonal possible win options---- (SI)     (CX)    (CX)    (CX)
                              ;-                                                      (CX)     (SI)    (CX)    (CX)
                              ;- SI - represent current disc to check                    (CX)     (CX)    (SI)    (CX)
                              ;\ CX - represent other disc of the currnent player           (CX)     (CX)    (CX)    (SI)  
      sub  bx, 35d            ;- Because every check its up 28 - four rows
      add  si, 5              ;- Because every check its down 4 - four cols        
                              
 MainDiagonalCheck: 
 
      dec  di                 ;- Decrement counter of possible win options 
      add  bx, 35d            ;- For the next check
      sub  si, 5              ;/
      mov  ax, 0              ;- Zero the counter of the streak of same player discs 
      mov  ch, 0              ;- Zero the counter of checks
      
 MainDiagonalCont:
 
      cmp  di, 0              ;\
      je   NextCheck2         ;- Run out of check options ;
      
      inc  ch                 ;- Counter of checks
      
      cmp  si, 0              ;\                                                       
      jl   Next9              ; \                                                      
                              ;-- Check if the disc is out of the limits of colomns the matrix 
      cmp  si, 6              ; /                                                      
      jg   Next9              ;/                                                       
      
      cmp  bx, 0              ;\                                                       
      jl   Next9              ; \                                                      
                              ;-- Check if the disc is out o flimits of the rows of the matrix 
      cmp  bx, 42d            ; /                                                      
      jg   Next9              ;/                                                       
      
      push bx                 ;- Save the location to the rest of the check 
      push si                 ;/                                            
                                                                            
      add  si, bx             ;- Merge the location                         
      mov  bx, [bp + 10]      ;- The address of the matrix                  
      
      cmp [bx][si], cl        ;- Check if the disc is not equel to the
      jne  Next3              ;/ player number and if so try the next option
   
      inc  ax                 ;- If the disc equel to the player number
                              ;/ increse the streak counter
 Next3:
   
      pop  si
      pop  bx 
      
 Next9:          
 
      inc  si                 ;- To check the next disc
      sub  bx, 7              ;/                
           
      cmp  ax, 4              ;- If the streak counter equel four the player won
      je   PlayerWon          ;/
      
      cmp  ch, 4              ;- If the check counter equel four switch check option
      je   MainDiagonalCheck  ;/                                                      
      
      jmp  MainDiagonalCont   ;- Check the next disc
 
 NextCheck2: 

     mov  bx, [bp + 4]       ;- Current disc location to check - BX = row location
     mov  si, [bp + 6]       ;/                                  SI = colomn loacaion
     
     mov  di, 5              ;- Counter of Secondary diagonal possible win options         (SI)    (CX)    (CX)    (CX)
                             ;-                                                         (CX)    (SI)    (CX)    (CX)
                             ;- SI - represent current disc to check                 (CX)    (CX)    (SI)    (CX)
                             ;/ CX - represent other disc of the currnent player  (CX)    (CX)    (CX)    (SI)  
     sub  bx, 35d            ;- Because every check its up 35 - five rows
     sub  si, 5d             ;- Because every check its down 5 - five cols
     
SecondaryDiagonalCheck:

     dec  di                 ;- Decrement counter of possible win options 
     add  bx, 35d            ;- For the next check
     add  si, 5              ;/
     mov  ax, 0              ;- Zero the counter of the streak of same player discs 
     mov  ch, 0              ;- Zero the counter of checks
     
SecondaryDiagonalCont:

     cmp  di, 0              ;\
     je   NotWin             ;- Run out of check options 
     
     inc  ch                 ;- Counter of checks 
     
     cmp  si, 0              ;\                                                       
     jl   Next6              ; \                                                      
                             ;-- Check if the disc is out of the limits of colomns the matrix 
     cmp  si, 6              ; /                                                      
     jg   Next6              ;/                                                       
     
     cmp  bx, 0              ;\                                                       
     jl   Next6              ; \                                                      
                             ;-- Check if the disc is out o flimits of the rows of the matrix 
     cmp  bx, 42d            ; /                                                      
     jg   Next6              ;/                                                       
     
     push bx                 ;- Save the location to the rest of the check 
     push si                 ;/                                            
                                                                           
     add  si,bx              ;- Merge the location                         
     mov  bx, [bp+10]        ;- The address of the matrix                  
     
     cmp  [bx][si], cl       ;- Check if the disc is not equel to the
     jne  Next4              ;/ player number and if so try the next option

      
     inc  ax                 ;- If the disc equel to the player number
                             ;/ increse the streak counter
Next4:
     
     pop si
     pop bx 
     
Next6:      

     dec  si                 ;- To check the next disc
     sub  bx, 7              ;/                
          
     cmp  ax, 4              ;- If the streak counter equel four the player won
     je   PlayerWon          ;/
     
     cmp  ch, 4                   ;- If the check counter equel four switch check option
     je   SecondaryDiagonalCheck  ;/                                                      
     
     jmp  SecondaryDiagonalCont   ;- Check the next disc  
     
NotWin:

     mov ax, [bp + 8]        ;- Turns counter
     
     cmp ax, 42d             ;- Check if its the last turn
     jb  NoEndGame           ;/
     
     mov bx, [bp + 12]       ;- Address of winner
     mov [bx], 3             ;- If it is the last turn and no one won it is a draw
     jmp WonCheckEnd         ;/

     
PlayerWon: 
     
     xor ch, ch             
     mov bx, [bp + 12]       ;- Address of winner
     mov [bx], cx            ;- Player number that won 
     jmp WonCheckEnd

NoEndGame: 
     
     mov bx, [bp + 12]       ;- Address of winner
     mov [bx], 0             ;- The game continue
   
WonCheckEnd:     
  
     pop di                  ;\
     pop si                  ; \
     pop dx                  ;  \
     pop cx                  ;  / Restore registers
     pop bx                  ; /
     pop ax                  ;/
    
     ret 12                  ;- Bite size of procedure stack 
     
     WinCheck ENDP
     
     ;=================================================================; 
     ; The procedure gets from the stack:                              ;
     ;                                                                 ;
     ;  1. Number of color                                             ;
     ;  2. The address of player name (empty in case of draw)          ;
     ;  3. The adress of text                                          ;
     ;                                                                 ;
     ;  The procedure print an end game announcment - winner or draw   ;
     ;  with the suitable color                                        ; 
     ;                                                                 ;
     ;=================================================================;
     
     
     WinDrawPrint PROC
        
      mov  bp, sp                 ;-  pointer to returning address where the        
                                  ;/  procedure parameters are located below of it
                             
      mov  dh, 10                 ;\
      mov  dl, 48                 ; \
      mov  bh, 0                  ;-- Set cursor location
      mov  ah, 2                  ; /
      int  10h                    ;/ 
      
      mov  bx, [bp + 6]           ;- To write the text with the color
      shr  bl, 4                  ;- From backgroung color to text color
      
      mov  al, 0                  ;\
      mov  bh, 0                  ; \
      mov  cx, 25                 ;-- Set the text color 
      mov  ah, 09h                ; /   
      int  10h                    ;/
                    
      mov  dx, [bp + 4]           ;\
      mov  ah, 9                  ;- Print  Name
      int  21h                    ;/
                                  
      mov  dx, [bp + 2]           ;\
      mov  ah, 9                  ;- Print text
      int  21h                    ;/ 
      
      ret  6                      ;- Bite size of procedure stack
        
        
     WinDrawPrint ENDP     
    

ends

end start ; set entry point and stop the assembler.                                                  