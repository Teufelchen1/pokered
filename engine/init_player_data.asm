InitPlayerData:
InitPlayerData2:

	call Random
	ld a, [hRandomSub]
	ld [wPlayerID], a

	call Random
	ld a, [hRandomAdd]
	ld [wPlayerID + 1], a

	ld a, $ff
	ld [wUnusedD71B], a

	ld hl, wPartyCount
	call InitializeEmptyList
	ld hl, wNumInBox
	call InitializeEmptyList
	ld hl, wNumBagItems
	call InitializeEmptyList
	ld hl, wNumBoxItems
	call InitializeEmptyList
	ld hl, wNumBoxItems
	; num element
	ld a, $3
	ld [hl], a
	inc hl
	; Masterball
	ld a, $1
	ld [hl], a
	inc hl
	ld a, $ff
	ld [hl], a
	inc hl
	; Surfboard
	ld a, $7
	ld [hl], a
	inc hl
	ld [hl], a
	inc hl
	; Fun 
	ld a, $2C
	ld [hl], a
	inc hl
	ld [hl], a
	inc hl
	; End of list
	xor a;
	dec a ; terminator
	ld [hl], a

START_MONEY EQU $F000
	ld hl, wPlayerMoney + 1
	ld a, START_MONEY / $100
	ld [hld], a
	xor a
	ld [hli], a
	inc hl
	ld [hl], a

	ld [wMonDataLocation], a

	ld hl, wObtainedBadges
	ld [hli], a

	ld [hl], a

	ld hl, wPlayerCoins
	ld [hli], a
	ld [hl], a

	ld hl, wGameProgressFlags
	ld bc, wGameProgressFlagsEnd - wGameProgressFlags
	call FillMemory ; clear all game progress flags

	jp InitializeMissableObjectsFlags

InitializeEmptyList:
	xor a ; count
	ld [hli], a
	dec a ; terminator
	ld [hl], a
	ret
