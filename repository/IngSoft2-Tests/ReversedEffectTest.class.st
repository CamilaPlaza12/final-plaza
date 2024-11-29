Class {
	#name : 'ReversedEffectTest',
	#superclass : 'TestCase',
	#instVars : [
		'aDeckOfCards',
		'anOverloadCard',
		'aSpeedCard',
		'anAccelerationCard',
		'aCancellationCard',
		'aRepeatCard',
		'aRedoCard',
		'aFreedomCard',
		'cellEffects',
		'aReverseCard'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
ReversedEffectTest >> setUp [

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

]

{ #category : 'asserting' }
ReversedEffectTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
			self assert: error messageText equals: anErrorMessage ].
]

{ #category : 'tests' }
ReversedEffectTest >> test01WhenBoardGameIsCreatedThenUnreversedGameEffect [

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

	self assert: aBoardGame reversedEffect equals: false.
]

{ #category : 'tests' }
ReversedEffectTest >> test02WhenBoardGameHasUnreversedGameEffectThenSpaceshipsOrder [

	| spaceships aBoard aBoardGame aCroupier|
		
	aDeckOfCards := DeckOfCards with: (OrderedCollection with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards. 
	
	
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 2 managedBy: aCroupier.

	self
		assert: aBoardGame spaceships equals: (OrderedCollection with: 'Vicky' with: 'Cami').

]

{ #category : 'tests' }
ReversedEffectTest >> test03WhenReverseCardThenReverseEffectTrue [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard ).
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
]

{ #category : 'tests' }
ReversedEffectTest >> test04WhenTwoReverseCardThenReverseEffectFalse [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard ).
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
	self assert: aBoardGame reversedEffect equals: false.
]

{ #category : 'tests' }
ReversedEffectTest >> test05WhenBoardGameHasReversedGameEffectThenSpaceshipsPlaysInReversedOrder [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard ).
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
	aBoardGame playTurnFor: 'Cami'.

]

{ #category : 'tests' }
ReversedEffectTest >> test06WhenReverseCardThenSpaceshipsPlaysInReversedOrder [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard ).
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
]

{ #category : 'tests' }
ReversedEffectTest >> test07WhenReverseCardThenLotOfSpaceshipsPlaysInReversedOrder [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard ).
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
			

]

{ #category : 'tests' }
ReversedEffectTest >> test08WhenTwoReverseCardThenSpaceshipsPlaysInUnreversedOrder [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard ).
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
	
	aBoardGame playTurnFor: 'Cami'.	
	aBoardGame playTurnFor: 'Delfi'.
	aBoardGame playTurnFor: 'Vicky'.
]

{ #category : 'tests' }
ReversedEffectTest >> test09WhenTwoReverseCardThenLotOfSpaceshipsPlaysInUnreversedOrder [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard ).
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
	
	aBoardGame playTurnFor: '3'.	
	aBoardGame playTurnFor: '4'.
	aBoardGame playTurnFor: '5'.
]

{ #category : 'tests' }
ReversedEffectTest >> test10WhenReverseCardAndSpaceshipsWantsToPlayThenItsNotHerTurn [

	| spaceships aBoard aBoardGame aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aReverseCard ).
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

	self should: [ aBoardGame playTurnFor: 'Cami'. ] 
	raise: Error  
	withMessage: 'Its not your turn' .	
]
