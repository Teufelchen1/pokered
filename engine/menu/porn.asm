PornMenu:
	coord hl, 10, 0
	ld b,$0c
	ld c,$08
	call TextBoxBorder
	ld de, PornMenuTop
	call PrintPornMenuItem
	ret
	;ld a, [wParentMenuItem]
	;ld [wCurrentMenuItem], a
	;ld hl, wFlags_0xcd60
	;set 5, [hl]
	;call LoadScreenTilesFromBuffer2
	;coord hl, 0, 0
	;ld b, $8
	;ld c, $e
	;call TextBoxBorder
	;call UpdateSprites
	;coord hl, 2, 2
	;ld de, PornMenuEntries
	;call PlaceString
	;ret

PrintPornMenuItem:
	push hl
	call PlaceString
	pop hl
	ld de,SCREEN_WIDTH * 2
	add hl,de
	ret

PornMenuTop:
	db 	"SEE DICK PIC"

PornMenuEntries:
	db   "SEE DICK PIC"
	next "TAKE DICK PIC"
	next "BIG BOOBS"
	next "JERK OFF@"