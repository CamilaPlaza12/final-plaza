Class {
	#name : 'GameTurnTest',
	#superclass : 'TestCase',
	#instVars : [
		'aDeckOfCards',
		'anOverloadCard',
		'aSpeedCard',
		'anAccelerationCard',
		'aCancellationCard',
		'aRepeatCard',
		'aRedoCard',
		'cellEffects',
		'aReverseCard',
		'aSkipCard',
		'aDoubleCard'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
GameTurnTest >> setUp [

	super setUp.
	cellEffects := OrderedCollection new.
	cellEffects
		add: (Cell on: 1 of: NoEffect new);
		add: (Cell on: 2 of: NoEffect new);
		add: (Cell on: 3 of: NoEffect new);
		add: (Cell on: 4 of: NoEffect new);
		add: (Cell on: 5 of: NoEffect new);
		add: (Cell on: 6 of: NoEffect new);
		add: (Cell on: 7 of: NoEffect new);
		add: (Cell on: 8 of: NoEffect new);
		add: (Cell on: 9 of: NoEffect new);
		add: (Cell on: 10 of: NoEffect new).
	
	anOverloadCard := OverloadCard new.
	aSpeedCard := SpeedCard new.
	anAccelerationCard := AccelerationCard new.
	aCancellationCard := CancellationCard new.
	aRepeatCard := RepeatCard new.
	aRedoCard := RedoCard new.
	aReverseCard := ReverseCard new.
	aSkipCard := SkipCard new.
	aDoubleCard := DoubleCard new.

]

{ #category : 'asserting' }
GameTurnTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
			self assert: error messageText equals: anErrorMessage ].
]

{ #category : 'tests' }
GameTurnTest >> test01WhenBoardGameIsCreatedThenUnreversedGameEffect [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards.

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	self assert: aBoardGame reversedEffect equals: false
]

{ #category : 'tests' }
GameTurnTest >> test02WhenBoardGameHasUnreversedGameEffectThenSpaceshipsOrder [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	self
		assert: aBoardGame spaceships
		equals: (OrderedCollection with: 'Vicky' with: 'Cami')
]

{ #category : 'tests' }
GameTurnTest >> test03WhenReverseCardThenReverseEffectTrue [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aReverseCard isPlayedOn: aBoardGame from: 'Cami'.

	self assert: aBoardGame reversedEffect equals: true
]

{ #category : 'tests' }
GameTurnTest >> test04WhenTwoReverseCardThenReverseEffectFalse [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aReverseCard isPlayedOn: aBoardGame from: 'Cami'.
	self assert: aBoardGame reversedEffect equals: true.

	aReverseCard isPlayedOn: aBoardGame from: 'Cami'.
	self assert: aBoardGame reversedEffect equals: false
]

{ #category : 'tests' }
GameTurnTest >> test05WhenBoardGameHasReversedGameEffectThenSpaceshipsPlaysInReversedOrder [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aReverseCard isPlayedOn: aBoardGame from: 'Cami'.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Delfi'.

	self assert: aBoardGame spaceshipTurn equals: 'Cami'
]

{ #category : 'tests' }
GameTurnTest >> test06WhenReverseCardThenSpaceshipsPlaysInReversedOrder [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.

	aReverseCard isPlayedOn: aBoardGame from: 'Cami'.

	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.

	self assert: aBoardGame spaceshipTurn equals: 'Delfi'
]

{ #category : 'tests' }
GameTurnTest >> test07WhenReverseCardThenLotOfSpaceshipsPlaysInReversedOrder [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: '1'.
	spaceships add: '2'.
	spaceships add: '3'.
	spaceships add: '4'.
	spaceships add: '5'.
	spaceships add: '6'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aBoardGame playTurnFor: '1'.

	aReverseCard isPlayedOn: aBoardGame from: '2'.

	self assert: aBoardGame spaceshipTurn equals: '2'.
	aBoardGame playTurnFor: '2'.

	self assert: aBoardGame spaceshipTurn equals: '1'.
	aBoardGame playTurnFor: '1'.

	self assert: aBoardGame spaceshipTurn equals: '6'.
	aBoardGame playTurnFor: '6'.

	self assert: aBoardGame spaceshipTurn equals: '5'.
	aBoardGame playTurnFor: '5'.

	self assert: aBoardGame spaceshipTurn equals: '4'.
	aBoardGame playTurnFor: '4'
]

{ #category : 'tests' }
GameTurnTest >> test08WhenTwoReverseCardThenSpaceshipsPlaysInUnreversedOrder [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.

	aReverseCard isPlayedOn: aBoardGame from: 'Cami'.

	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Delfi'.

	aReverseCard isPlayedOn: aBoardGame from: 'Cami'.

	self assert: aBoardGame spaceshipTurn equals: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.
	aBoardGame playTurnFor: 'Delfi'.
	self assert: aBoardGame spaceshipTurn equals: 'Vicky'
]

{ #category : 'tests' }
GameTurnTest >> test09WhenTwoReverseCardThenLotOfSpaceshipsPlaysInUnreversedOrder [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: '1'.
	spaceships add: '2'.
	spaceships add: '3'.
	spaceships add: '4'.
	spaceships add: '5'.
	spaceships add: '6'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aBoardGame playTurnFor: '1'.

	aReverseCard isPlayedOn: aBoardGame from: '2'.

	aBoardGame playTurnFor: '2'.
	aBoardGame playTurnFor: '1'.
	aBoardGame playTurnFor: '6'.
	aBoardGame playTurnFor: '5'.
	aBoardGame playTurnFor: '4'.

	aReverseCard isPlayedOn: aBoardGame from: '2'.

	self assert: aBoardGame spaceshipTurn equals: '3'.
	aBoardGame playTurnFor: '3'.

	self assert: aBoardGame spaceshipTurn equals: '4'.
	aBoardGame playTurnFor: '4'.

	self assert: aBoardGame spaceshipTurn equals: '5'.
	aBoardGame playTurnFor: '5'
]

{ #category : 'tests' }
GameTurnTest >> test10WhenReverseCardAndSpaceshipsWantsToPlayThenItsNotHerTurn [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aReverseCard isPlayedOn: aBoardGame from: 'Cami'.

	aBoardGame playTurnFor: 'Vicky'.

	self
		should: [ aBoardGame playTurnFor: 'Cami' ]
		raise: Error
		withMessage: 'Its not your turn'
]

{ #category : 'tests' }
GameTurnTest >> test11WhenReverseCardChoosingACardThenCantPlayIt [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aReverseCard isPlayedOn: aBoardGame from: 'Cami'.

	self
		should: [
			aReverseCard
				isPlayedOn: aBoardGame
				from: 'Cami'
				choosing: aSpeedCard ]
		raise: Error
		withMessage: 'To play card, dont choose a card'
]

{ #category : 'tests' }
GameTurnTest >> test12WhenReverseCardChoosingASpaceshipThenCantPlayIt [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.


	self
		should: [
		aReverseCard isPlayedOn: aBoardGame from: 'Cami' to: 'Vicky' ]
		raise: Error
		withMessage: 'To play card, dont choose a player'
]

{ #category : 'tests' }
GameTurnTest >> test13WhenReverseCardAndSpeedCardThenSpaceshipPosition [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection
			                 with: aReverseCard
			                 with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.


	aSpeedCard isPlayedOn: aBoardGame from: 'Vicky' to: 'Cami'.
	aReverseCard isPlayedOn: aBoardGame from: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.

	aBoardGame playTurnFor: 'Delfi'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.

	aBoardGame playTurnFor: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 5
]

{ #category : 'tests' }
GameTurnTest >> test14WhenSkipCardThenNextSpaceshipPlays [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: aSkipCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.


	aBoardGame playTurnFor: 'Vicky'.

	aSkipCard isPlayedOn: aBoardGame from: 'Vicky'.

	self assert: aBoardGame spaceshipTurn equals: 'Delfi'
]

{ #category : 'tests' }
GameTurnTest >> test15WhenSkipCardThenSpaceshipCantPlay [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: aSkipCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.


	aBoardGame playTurnFor: 'Vicky'.

	aSkipCard isPlayedOn: aBoardGame from: 'Vicky'.

	self
		should: [ aBoardGame playTurnFor: 'Cami' ]
		raise: Error
		withMessage: 'Its not your turn'
]

{ #category : 'tests' }
GameTurnTest >> test16WhenReverseCardAndSkipCardThenNextSpaceshipPlays [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection
			                 with: aSkipCard
			                 with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aReverseCard isPlayedOn: aBoardGame from: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Delfi'.

	aSkipCard isPlayedOn: aBoardGame from: 'Vicky'.

	self assert: aBoardGame spaceshipTurn equals: 'Vicky'
]

{ #category : 'tests' }
GameTurnTest >> test17WhenSpaceshipPlaysWithReverseCardAndSkipCardThenNextSpaceshipPlays [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection
			                 with: aSkipCard
			                 with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.

	aReverseCard isPlayedOn: aBoardGame from: 'Vicky'.

	self assert: aBoardGame spaceshipTurn equals: 'Cami'.

	aSkipCard isPlayedOn: aBoardGame from: 'Vicky'.

	self assert: aBoardGame spaceshipTurn equals: 'Vicky'
]

{ #category : 'tests' }
GameTurnTest >> test18WhenTwoSkipCardAndReverseCardThenNextSpaceshipPlays [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection
			                 with: aSkipCard
			                 with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	aSkipCard isPlayedOn: aBoardGame from: 'Vicky'.
	aSkipCard isPlayedOn: aBoardGame from: 'Cami'.

	aBoardGame playTurnFor: 'Vicky'.

	aReverseCard isPlayedOn: aBoardGame from: 'Vicky'.

	self assert: aBoardGame spaceshipTurn equals: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.

	self assert: aBoardGame spaceshipTurn equals: 'Vicky'.
	aBoardGame playTurnFor: 'Vicky'.

	self assert: aBoardGame spaceshipTurn equals: 'Delfi'.
	aBoardGame playTurnFor: 'Delfi'
]

{ #category : 'tests' }
GameTurnTest >> test19WhenReverseCardAndDoubleCardThenSpaceshipPlays [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection
			                 with: aDoubleCard
			                 with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	aReverseCard isPlayedOn: aBoardGame from: 'Vicky'.

	self assert: aBoardGame spaceshipTurn equals: 'Delfi'.
	aBoardGame playTurnFor: 'Delfi'.

	aDoubleCard isPlayedOn: aBoardGame from: 'Vicky'.

	self assert: aBoardGame spaceshipTurn equals: 'Delfi'
]

{ #category : 'tests' }
GameTurnTest >> test20WhenDoubleCardThenSpaceshipPlaysTwoTimes [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aDoubleCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.


	aBoardGame playTurnFor: 'Vicky'.

	aDoubleCard isPlayedOn: aBoardGame from: 'Vicky'.

	self assert: aBoardGame spaceshipTurn equals: 'Vicky'
]

{ #category : 'tests' }
GameTurnTest >> test21WhenDoubleCardAndSkipCardThenSpaceshipPlaysOneTime [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aDoubleCard with: aSkipCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	aBoardGame playTurnFor: 'Cami'.

	aDoubleCard isPlayedOn: aBoardGame from: 'Vicky'.
	aSkipCard isPlayedOn: aBoardGame from: 'Vicky'.

	self assert: aBoardGame spaceshipTurn equals: 'Delfi'
]

{ #category : 'tests' }
GameTurnTest >> test22WhenSkipCardChoosesCardThenCantThrowIt [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: aSkipCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.


	self should: [ 	aSkipCard isPlayedOn: aBoardGame from: 'Vicky' choosing: aSpeedCard .] 
	raise: Error  
	withMessage: 'To play card, dont choose a card' .	
]

{ #category : 'tests' }
GameTurnTest >> test23WhenSkipCardChoosesPlayerThenCantThrowIt [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: aSkipCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.


	self
		should: [ aSkipCard isPlayedOn: aBoardGame from: 'Vicky' to: 'Cami' ]
		raise: Error
		withMessage: 'To play card, dont choose a player'
]

{ #category : 'tests' }
GameTurnTest >> test24WhenDoubleCardChoosesPlayerThenCantThrowIt [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: aSkipCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.


	self
		should: [
		aDoubleCard isPlayedOn: aBoardGame from: 'Vicky' to: 'Cami' ]
		raise: Error
		withMessage: 'To play card, dont choose a player'
]

{ #category : 'tests' }
GameTurnTest >> test25WhenDoubleCardChoosesCardThenCantThrowIt [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: aSkipCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.


	self
		should: [
			aDoubleCard
				isPlayedOn: aBoardGame
				from: 'Vicky'
				choosing: aSpeedCard ]
		raise: Error
		withMessage: 'To play card, dont choose a card'
]

{ #category : 'tests' }
GameTurnTest >> test26WhenReverseCardRedoCardThenUnreversedOrder [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection
			                 with: aRedoCard
			                 with: aReverseCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.

	aReverseCard isPlayedOn: aBoardGame from: 'Vicky'.
	aRedoCard isPlayedOn: aBoardGame from: 'Vicky'.

	self assert: aBoardGame spaceshipTurn equals: 'Cami'.
	aBoardGame playTurnFor: 'Cami'.

	self assert: aBoardGame spaceshipTurn equals: 'Delfi'
]

{ #category : 'tests' }
GameTurnTest >> test27WhenSkipCardRedoCardThenSkipsTwoTurns [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aSkipCard with: aRedoCard).
	aCroupier := Croupier handling: aDeckOfCards.


	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	aSkipCard isPlayedOn: aBoardGame from: 'Vicky'.
	aRedoCard isPlayedOn: aBoardGame from: 'Cami'.

	self assert: aBoardGame spaceshipTurn equals: 'Vicky'
]
