Class {
	#name : 'BoardGame',
	#superclass : 'Object',
	#instVars : [
		'dice',
		'spaceshipPositions',
		'board',
		'winner',
		'rounds',
		'isOver',
		'lastCellEffect',
		'playingSpaceshipPosition',
		'croupier',
		'spaceshipInJail',
		'maxDiceHits',
		'totalDiceResults',
		'gameTurns'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
BoardGame class >> playedBy: spaceships rolling: dice on: aBoard with: rounds managedBy: aCroupier [ 

	self validateCanExistWith: spaceships andWith: rounds.
	^ self new
		  initializePlayedBy: spaceships
		  rolling: dice
		  on: aBoard
		  winningAfter: rounds
		  managedBy: aCroupier.
]

{ #category : 'instance creation' }
BoardGame class >> validateCanExistWith: aSpaceshipCollection andWith: anAmountOfRounds [

	aSpaceshipCollection isEmpty ifTrue: [ 
		Error signal: 'Cannot create board with no spaceships' ].

	anAmountOfRounds > 0 ifFalse: [ 
		Error signal: 'Cannot create board with a negative amount of rounds' ].


	aSpaceshipCollection asSet size < aSpaceshipCollection size ifTrue: [ 
		Error signal: 'Cannot create board with repeated spaceships' ].
]

{ #category : 'cards' }
BoardGame >> appliesCancellationCardTo: aCard [ 
	croupier cancellationCardTo: aCard.
]

{ #category : 'effects' }
BoardGame >> applyAtomicBombEffect [

	spaceshipPositions do: [ :spaceship |
		spaceship inJail state ifFalse: [
			self moves: spaceship to: spaceship position cellNumber negated + 1 ] ]
]

{ #category : 'jail' }
BoardGame >> applyDoubleEffect [
	
	croupier applyDoubleEffectTo: gameTurns .

]

{ #category : 'effects' }
BoardGame >> applyEffect [

	| aCellEffect |
	aCellEffect := board cellsEffect detect: [ :cell | 
		               cell quantity = playingSpaceshipPosition  position cellNumber  ].
	lastCellEffect := aCellEffect effect.
	aCellEffect effect implementOn: self
]

{ #category : 'effects' }
BoardGame >> applyHyperJumpEffect: parsecs [
    playingSpaceshipPosition inJail state ifFalse: [
        self 
            moves: playingSpaceshipPosition
            to: parsecs // board parsecsPerCell
    ].

]

{ #category : 'jail' }
BoardGame >> applyJailEffect [

	playingSpaceshipPosition inJail capture.
]

{ #category : 'effects' }
BoardGame >> applyMoonWalkEffect: cellsBackward [

	(spaceshipPositions select: [ :spaceshipPosition |
		 playingSpaceshipPosition spaceships ~= spaceshipPosition spaceships ])
		do: [ :spaceshipPosition |
			spaceshipPosition inJail state ifFalse: [
				self moves: spaceshipPosition to: cellsBackward negated ] ]
]

{ #category : 'effects' }
BoardGame >> applyMovingEffect: aNumber [ 
	
	spaceshipInJail := playingSpaceshipPosition inJail state.
	spaceshipInJail
	ifFalse: [ self moves: playingSpaceshipPosition to: aNumber. ].
	
]

{ #category : 'jail' }
BoardGame >> applyReverseEffect [
	
	croupier applyReverseEffectTo: gameTurns .

]

{ #category : 'jail' }
BoardGame >> applySkipEffect [
	
	croupier applySkipEffectTo: gameTurns .

]

{ #category : 'effects' }
BoardGame >> dealACardEffect [

	croupier dealACardTo: playingSpaceshipPosition spaceships
]

{ #category : 'cards' }
BoardGame >> dealLastPlayedCardTo: aSpaceship [ 
	croupier dealLastPlayedCardTo: aSpaceship
]

{ #category : 'instance creation' }
BoardGame >> initializePlayedBy: manySpaceships rolling: manyDice on: aBoard winningAfter: anAmountOfRounds managedBy: aCroupier [

	board := aBoard.
	dice := manyDice.
	isOver := false.
	rounds := anAmountOfRounds.
	winner := ''.
	lastCellEffect := NoEffect new.
	totalDiceResults := 0.
	croupier := aCroupier.
	croupier dealCardsWhenGameIsStartedTo: manySpaceships.
	self spaceshipsInitialization: manySpaceships.
]

{ #category : 'accessing' }
BoardGame >> lastCardPlayed [
	^ (croupier lastCardPlayed)
]

{ #category : 'action' }
BoardGame >> moves: aSpaceshipPosition to: amountOfCellsToMove [

	| moveAmount aSpaceshipPositionNew cellNumberNew roundNew |
	moveAmount := aSpaceshipPosition position cellNumber
	              + amountOfCellsToMove.

	cellNumberNew := self
		                 newCellNumberPositionWith: moveAmount
		                 on: aSpaceshipPosition position round.
	roundNew := self
		            newRoundPositionWhen: aSpaceshipPosition position round
		            with: moveAmount.


	aSpaceshipPositionNew := SpaceshipPosition
		                         named: aSpaceshipPosition spaceships
		                         on:
		                         (Position on: cellNumberNew at: roundNew).
	playingSpaceshipPosition := aSpaceshipPositionNew.

	spaceshipPositions
		at: (spaceshipPositions indexOf: aSpaceshipPosition)
		put: aSpaceshipPositionNew
]

{ #category : 'action' }
BoardGame >> newCellNumberPositionWith: moveAmount on: aRound [

	| cellNumber amountOfRounds |
	cellNumber := moveAmount.
	amountOfRounds := aRound.

	[ cellNumber > board anAmountOfCells ] whileTrue: [ 
		cellNumber := cellNumber - board anAmountOfCells ].

	[ cellNumber <= 0 ] whileTrue: [ 
		amountOfRounds = 1
			ifTrue: [ cellNumber := 1 ]
			ifFalse: [ 
				amountOfRounds := amountOfRounds - 1.
				cellNumber := cellNumber + board anAmountOfCells ] ].

	cellNumber = 0 ifTrue: [ cellNumber := 1 ].

	^ cellNumber
]

{ #category : 'action' }
BoardGame >> newRoundPositionWhen: originalRound with: moveAmount [

	| cellNumber round |
	cellNumber := moveAmount.
	round := originalRound.

	[ cellNumber > board anAmountOfCells ] whileTrue: [ 
		cellNumber := cellNumber - board anAmountOfCells.
		round := round + 1 ].

	[ cellNumber < 0 ] whileTrue: [ 
		cellNumber := cellNumber + board anAmountOfCells.
		round := round - 1 ].

	round <= 0 ifTrue: [ round := 1 ].


	^ round
]

{ #category : 'action' }
BoardGame >> playTurnFor: aSpaceship [

	isOver
		ifFalse: [ 
			self validateSpaceshipTurnFor: aSpaceship.
			self validatePlayingSpaceshipPosition.
			self throwDice.
			self validatesSpaceshipInJail.
			spaceshipInJail
				ifFalse: [ 
					self relocatesSpaceshipPositionTo: self totalAmount.
					self validateWinner: playingSpaceshipPosition.
				].
			self turn.
		]
		ifTrue: [ self validateKeepPlaying ]
]

{ #category : 'action' }
BoardGame >> positions [

	^ spaceshipPositions collect: [ :spaceship | 
		  spaceship position cellNumber ]
]

{ #category : 'action' }
BoardGame >> ranking [

	| namesRanking |
	namesRanking := spaceshipPositions sort: [
		                :spaceshipPosition1
		                :spaceshipPosition2 |
		                spaceshipPosition1 >= spaceshipPosition2 ].
	namesRanking size >= 3 ifTrue: [
		namesRanking := namesRanking first: 3 ].
	^ namesRanking collect: [ :spaceshipPosition |
		  spaceshipPosition spaceships ]
]

{ #category : 'action' }
BoardGame >> recordPermanent: aCardPlayers [

	croupier recordPermanent: aCardPlayers
]

{ #category : 'jail' }
BoardGame >> releaseFromJail: aSpaceship [

	| spaceshipPosition |
	spaceshipPosition := spaceshipPositions detect: [ :each |
		                     each spaceships == aSpaceship ].

	croupier releaseFromJail: spaceshipPosition
]

{ #category : 'action' }
BoardGame >> relocatesSpaceshipPositionTo: aNumber [

	self moves: playingSpaceshipPosition to: aNumber.

	self applyEffect
]

{ #category : 'cards' }
BoardGame >> repeatCardTo: aSpaceship [

	playingSpaceshipPosition := spaceshipPositions detect: [
		                            :spaceshipPosition |
		                            spaceshipPosition spaceships
		                            == aSpaceship ].

	lastCellEffect implementOn: self
]

{ #category : 'accessing' }
BoardGame >> reversedEffect [

	^ gameTurns reverseEffect
]

{ #category : 'action' }
BoardGame >> spaceshipPosition: aName [

	^ (spaceshipPositions detect: [ :spaceshipPosition |
		   spaceshipPosition spaceships == aName ]) position
]

{ #category : 'validation' }
BoardGame >> spaceshipTurn [

	^(self spaceships at: (gameTurns turn))
]

{ #category : 'accessing' }
BoardGame >> spaceships [

	^ gameTurns spaceships
]

{ #category : 'initialization' }
BoardGame >> spaceshipsInitialization: aGroupOfSpaceships [

	| size |
	size := 0.
	gameTurns := GameTurns initializeTurnsOf: aGroupOfSpaceships.
	spaceshipPositions := OrderedCollection new.
	[ aGroupOfSpaceships size > size ] whileTrue: [
		spaceshipPositions add: (SpaceshipPosition
				 named: (aGroupOfSpaceships at: size + 1)
				 on: (Position on: 1 at: 1)).
		size := size + 1 ]
]

{ #category : 'action' }
BoardGame >> takes: aCard from: aSpaceship [ 

	croupier takes: aCard from: aSpaceship.
]

{ #category : 'action' }
BoardGame >> throwDice [

	| result |
	result := 0.
	maxDiceHits := true.

	dice do: [ :each |
		| throwResult |
		throwResult := each throw.
		result := result + throwResult.
		throwResult ~= each faces ifTrue: [ maxDiceHits := false ] ].

	totalDiceResults := result
]

{ #category : 'cards' }
BoardGame >> totalAmount [

	^ totalDiceResults
	  + (croupier permanentCardsOf: playingSpaceshipPosition spaceships)
]

{ #category : 'accessing' }
BoardGame >> turn [

	gameTurns nextTurn
]

{ #category : 'validation' }
BoardGame >> validateKeepPlaying [

	Error signal: 'There is a winner, you cant keep moving forward'
]

{ #category : 'action' }
BoardGame >> validatePlayingSpaceshipPosition [

	playingSpaceshipPosition := spaceshipPositions detect: [
		                            :spaceshipPosition |
		                            spaceshipPosition spaceships
		                            == (self spaceships at: gameTurns turn) ]
]

{ #category : 'validation' }
BoardGame >> validateSomeSpaceshipHasPlayed [

	totalDiceResults = 0 ifTrue: [
		Error signal: 'To play a card, a spaceship must have played first.' ]
]

{ #category : 'validation' }
BoardGame >> validateSpaceshipExists: aSpaceship [

	(self spaceships includes: aSpaceship)
		ifFalse: [ Error signal: 'That spaceship doesn´t exists' ].
]

{ #category : 'validation' }
BoardGame >> validateSpaceshipTurnFor: aSpaceship [

	(self spaceshipTurn ) = aSpaceship
		ifFalse: [ Error signal: 'Its not your turn' ].
]

{ #category : 'validation' }
BoardGame >> validateWinner: aSpaceshipPosition [

	aSpaceshipPosition position round > rounds
		ifTrue: [
			isOver := true.
			winner := aSpaceshipPosition spaceships ]
		ifFalse: [  ]
]

{ #category : 'validation' }
BoardGame >> validates: aSpaceship canPlay: aCard [

	self validateSpaceshipTurnFor: aSpaceship.
	self takes: aCard from: aSpaceship
]

{ #category : 'jail' }
BoardGame >> validatesSpaceshipInJail [

	maxDiceHits ifTrue: [ playingSpaceshipPosition inJail release ].

	spaceshipInJail := playingSpaceshipPosition inJail state
]

{ #category : 'instance variable' }
BoardGame >> winner [

	winner
		ifEmpty: [ Error signal: 'There is not a winner' ]
		ifNotEmpty: [  ].
	^ winner
]
