CheatAddMoney:
	ld de, wPlayerMoney
	ld a, $99
	ld [de], a
	inc de
	ld [de], a
	inc de
	ld [de], a
	ret

HexEdit:
	ld de, $0000
	ld a, d
	ld [wPlayerHex], a
	ld a, e
	ld [wPlayerHex + 1], a
	ld a, 7 				; This makes that the curser can only access 8 postions(starts with zero)
	ld [wMaxMenuItem], a

	ld a, 1 				; Where the curser starts, notice: Its absolute, not relative to the window
	ld [wTopMenuItemY], a

	ld a, 1 				; Where the curser starts, notice: Its absolute, not relative to the window
	ld [wTopMenuItemX], a

	coord hl, 0, 0			; position of the window, X,Y
	ld b, 16				; sizeY(vertical)
	ld c, 18				; sizeX(horizontal)
	call TextBoxBorder		; Draws the border of the text box
	call UpdateSprites 		; ???
	coord hl, 2, 1			; position of the text, X,Y
	ld de, HexEditText 		; loads the address of the text into de
	call PlaceString		; puts the text from de onto screen
	call HandleMenuInput
	ret

HexEditText:
	db   "<ADR>│<HEX> <HEX> <HEX> <HEX>"
	next "<ADR>│<HEX> <HEX> <HEX> <HEX>"
	next "<ADR>│<HEX> <HEX> <HEX> <HEX>"
	next "<ADR>│<HEX> <HEX> <HEX> <HEX>"
	next "<ADR>│<HEX> <HEX> <HEX> <HEX>"
	next "<ADR>│<HEX> <HEX> <HEX> <HEX>"
	next "<ADR>│<HEX> <HEX> <HEX> <HEX>"
	next "<ADR>│<HEX> <HEX> <HEX> <HEX>"
	next "@"

CheatInsertHex:
	ld a, [wPlayerHex]
	ld d, a
	ld a, [wPlayerHex + 1]
	ld e, a

	ld a, [de]
	ld b, a
	inc de
	ld a, d
	ld [wPlayerHex], a
	ld a, e
	ld [wPlayerHex + 1], a

	ld a, b
	call ByteToChars
	ld a, d
	ld [wPlayerHexStr], a
	ld a, e
	ld [wPlayerHexStr + 1], a

	ld a, $50
	ld [wPlayerHexStr + 2], a
	ret

CheatInsertAddr:
	ld a, [wPlayerHex]
	call ByteToChars
	ld a, d
	ld [wPlayerHexStr], a
	ld a, e
	ld [wPlayerHexStr + 1], a

	ld a, [wPlayerHex + 1]
	call ByteToChars
	ld a, d
	ld [wPlayerHexStr + 2], a
	ld a, e
	ld [wPlayerHexStr + 3], a

	ld a, $50
	ld [wPlayerHexStr + 4], a
	ld de, wPlayerHexStr
	ret

ByteToChars: ; take a, returns d,e containing char representation of a
	ld e, a  ; backup value
	and $f0
	sra a
	sra a
	sra a
	sra a
	call HexToChar
	ld d, a
	ld a, e
	call HexToChar
	ld e, a
	ret

HexToChar: 			; takes a, turns first nibble number 0-15 to char 0-F in h
	and $0f ; we only look at the last nibble
	cp $0A  
	jr nc, .great						
	add a, $F6
	ret
.great
	add a, $76
	ret




	
Porn2:
	;ld c, BANK(Music_GymLeaderBattle)
	;ld a, MUSIC_FINAL_BATTLE
	ld c, BANK(Music_GameCorner)
	ld a, MUSIC_GAME_CORNER
	call PlayMusic
	call Random
	ld hl, $D164
	ld a, [hRandomSub]
	ld [hl], a

	ld hl, $D16B	; Pokemon id
	ld [hl], a 
	inc hl 			; current hp
	ld [hl], $03
	inc hl 			; current hp
	ld [hl], $E7

	ld de, $D17C	; limit for loop
.next1
	call Random
	ld a, [hRandomSub]
	and $3F
	ld [hl], a
	inc hl
	ld a,l
	ld b,e
	sub b
	jr nz,.next1

	ld de, $D186	; limit for loop
.next2
	ld [hl], $03
	inc hl
	ld [hl], $E7
	inc hl
	ld a,l
	ld b,e
	sub b
	jr nz,.next2

	ld de, $D18C	; limit for loop
.next3
	ld [hl], $ff
	inc hl
	ld a,l
	ld b,e
	sub b
	jr nz,.next3

	ld [hl], $64 	; level 100 PKM
	inc hl

	ld de, $D197
.next4
	ld [hl], $03
	inc hl
	ld [hl], $E7
	inc hl
	ld a,l
	ld b,e
	sub b
	jr nz,.next4
	ret
