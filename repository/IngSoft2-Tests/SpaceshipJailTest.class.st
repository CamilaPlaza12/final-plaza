Class {
	#name : 'SpaceshipJailTest',
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
		'cellEffectsWithJail'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'running' }
SpaceshipJailTest >> setUp [

	super setUp.		
	cellEffectsWithJail := OrderedCollection new.
	cellEffectsWithJail 
		add: (Cell on: 1 of: NoEffect new);
		add: (Cell on: 2 of: JailEffect new);
		add: (Cell on: 3 of: NoEffect new);
		add: (Cell on: 4 of: NoEffect new);
		add: (Cell on: 5 of: NoEffect new);
		add: (Cell on: 6 of: NoEffect new);
		add: (Cell on: 7 of: NoEffect new);
		add: (Cell on: 8 of: NoEffect new);
		add: (Cell on: 9 of: NoEffect new);
		add: (Cell on: 10 of: SpeedUpEffect new);
		add: (Cell on: 11 of: WormHoleEffect new);
		add: (Cell on: 12 of: (MoonWalkEffect with: 5));
		add: (Cell on: 13 of: AtomicBombEffect new);
		add: (Cell on: 14 of: (HyperJumpEffect with: (OrderedCollection with: (Parsec of: 3))));
		add: (Cell on: 15 of: NoEffect new).


	anOverloadCard := OverloadCard new.
	aSpeedCard := SpeedCard new.
	anAccelerationCard := AccelerationCard new.
	aCancellationCard := CancellationCard new.
	aRepeatCard := RepeatCard new.
	aRedoCard := RedoCard new.
	aFreedomCard := FreedomCard new.

]

{ #category : 'asserting' }
SpaceshipJailTest >> should: anErrorBlock raise: anExceptionClass withMessage: anErrorMessage [

	self
		should: anErrorBlock
		raise: anExceptionClass
		withExceptionDo: [ :error | 
			self assert: error messageText equals: anErrorMessage ].
]

{ #category : 'tests' }
SpaceshipJailTest >> test01WhenSpaceshipLandsOnJailCellThenCantMove [

	| spaceships aBoard aBoardGame cellEffects aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aFreedomCard).
	aCroupier := Croupier handling: aDeckOfCards.
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: JailEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 3 2 )))
		              on: aBoard
		              with: 4
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 2.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test02WhenSpaceshipLandsOnJailCellAndThrowsMaxAmountThenCanMove [

	| spaceships aBoard aBoardGame cellEffects aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aFreedomCard).
	aCroupier := Croupier handling: aDeckOfCards.
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: JailEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 5 )))
		              on: aBoard
		              with: 4
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 7.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test03WhenSpaceshipLandsOnJailCellAndThrowsMaxAmountOfTwoDicesThenCanMove [

	| spaceships aBoard aBoardGame cellEffects aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aFreedomCard).
	aCroupier := Croupier handling: aDeckOfCards.
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: NoEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: JailEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection
				               with: (LoadedDie of: #( 1 2 3 ))
				               with: (LoadedDie of: #( 3 1 )))
		              on: aBoard
		              with: 4
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 5.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 2
]

{ #category : 'tests' }
SpaceshipJailTest >> test04WhenSpaceshipLandsOnJailCellAndThrowsTwoDicesThenCantMove [

	| spaceships aBoard aBoardGame cellEffects aCroupier |
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aFreedomCard).
	aCroupier := Croupier handling: aDeckOfCards.
	cellEffects := OrderedCollection new.

	cellEffects add: (Cell on: 1 of: NoEffect new).
	cellEffects add: (Cell on: 2 of: NoEffect new).
	cellEffects add: (Cell on: 3 of: JailEffect new).
	cellEffects add: (Cell on: 4 of: NoEffect new).
	cellEffects add: (Cell on: 5 of: NoEffect new).
	cellEffects add: (Cell on: 6 of: NoEffect new).
	cellEffects add: (Cell on: 7 of: NoEffect new).
	cellEffects add: (Cell on: 8 of: NoEffect new).
	cellEffects add: (Cell on: 9 of: NoEffect new).
	cellEffects add: (Cell on: 10 of: NoEffect new).

	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.

	aBoard := Board of: cellEffects withLenght: (Parsec of: 15).
	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling: (OrderedCollection
				               with: (LoadedDie of: #( 1 2 3 ))
				               with: (LoadedDie of: #( 1 3 )))
		              on: aBoard
		              with: 4
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test05WhenASpaceshipThrowsFreedomCardThenCanKeepPlaying [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aFreedomCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 3 2 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aFreedomCard isPlayedOn: aBoardGame from: 'Vicky' to: 'Vicky'.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test06WhenASpaceshipThrowsFreedomCardThenNothingHappens [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aFreedomCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 4 3 2 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 5.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aFreedomCard isPlayedOn: aBoardGame from: 'Vicky' to: 'Vicky'.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 7.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test07WhenASpaceshipLandsInJailCellAndThrowsFreedomCardThenIsFree [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aFreedomCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 3 1 4 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aFreedomCard isPlayedOn: aBoardGame from: 'Cami' to: 'Cami'.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 8.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 5.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test08WhenASpaceshipThrowsFreedomCardToAnotherSpaceshipThenCanKeepPlaying [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aFreedomCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 3 1 4 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 8.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aFreedomCard isPlayedOn: aBoardGame from: 'Vicky' to: 'Cami'.
	aBoardGame playTurnFor: 'Vicky'.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test09WhenASpaceshipIsInJailAndASpeedCardIsThrownAtHerThenCantMove [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 3 2 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.


	aSpeedCard isPlayedOn: aBoardGame from: 'Cami' to: 'Vicky'.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.


	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test10WhenASpaceshipIsInJailAndASpeedCardIsThrownAtHerThenEffectIsApplied [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aSpeedCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.


	aSpeedCard isPlayedOn: aBoardGame from: 'Cami' to: 'Vicky'.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 6.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test11WhenAFreedomCardIsPlayedAndRedoCardThenHasNoEffect [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection
			                 with: aRedoCard
			                 with: aFreedomCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 3 2 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aFreedomCard isPlayedOn: aBoardGame from: 'Cami' to: 'Vicky'.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aRedoCard isPlayedOn: aBoardGame from: 'Vicky' to: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 4.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test12WhenASpaceshipIsInJailAndARedoCardIsThrownAtHerThenNothingHappensUnitIsFree [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection
			                 with: aSpeedCard
			                 with: aRedoCard
			                 with: aFreedomCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 3 2 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.

	aSpeedCard isPlayedOn: aBoardGame from: 'Vicky' to: 'Vicky'.
	aRedoCard isPlayedOn: aBoardGame from: 'Vicky' to: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aFreedomCard isPlayedOn: aBoardGame from: 'Cami' to: 'Vicky'.

	aBoardGame playTurnFor: 'Cami'.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 7.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test13WhenASpaceshipIsInJailAndARepeatCardIsThrownThenAnotherSpaceshipIsInJail [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with:
			               (LoadedDie of: #( 1 3 2 3 2 3 2 3 10 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aRepeatCard isPlayedOn: aBoardGame from: 'Cami' to: 'Cami'.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test14WhenLastEffectSpeedUpAndRepeatCardButSpaceshipInJailAThenNothingHappens [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 9 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 14.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aRepeatCard isPlayedOn: aBoardGame from: 'Cami' to: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test15WhenLastEffectWormHoleAndRepeatCardButSpaceshipInJailAThenNothingHappens [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 10 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 7.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aRepeatCard isPlayedOn: aBoardGame from: 'Cami' to: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test16WhenLastEffectMoonWalkAndRepeatCardButSpaceshipInJailAThenNothingHappens [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 11 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Delfi'.
	self
		assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber
		equals: 12.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') round equals: 1.

	aRepeatCard isPlayedOn: aBoardGame from: 'Cami' to: 'Delfi'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber
		equals: 12.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test17WhenEffectMoonWalkButSpaceshipInJailAThenNothingHappens [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	spaceships add: 'Delfi'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 2 11 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 3.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aBoardGame playTurnFor: 'Delfi'.
	self
		assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber
		equals: 12.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') round equals: 1.


	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Delfi') cellNumber
		equals: 12.
	self assert: (aBoardGame spaceshipPosition: 'Delfi') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test18WhenEffectAtomicBombButSpaceshipInJailAThenNothingHappens [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 12 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.


	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test19WhenLastEffectAtomicBombAndRepeatCardButSpaceshipInJailAThenNothingHappens [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 12 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 1.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 1.

	aRepeatCard isPlayedOn: aBoardGame from: 'Cami'.

	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test20WhenLastEffectHyperJumpAndRepeatCardButSpaceshipInJailAThenNothingHappens [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aRepeatCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 13 3 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1.

	aBoardGame playTurnFor: 'Cami'.
	self
		assert: (aBoardGame spaceshipPosition: 'Cami') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Cami') round equals: 2.

	aRepeatCard isPlayedOn: aBoardGame from: 'Cami' to: 'Vicky'.

	aBoardGame playTurnFor: 'Vicky'.
	self
		assert: (aBoardGame spaceshipPosition: 'Vicky') cellNumber
		equals: 2.
	self assert: (aBoardGame spaceshipPosition: 'Vicky') round equals: 1
]

{ #category : 'tests' }
SpaceshipJailTest >> test21WhenFreedomCardIsThrownThenNeedToChooseAPlayer [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aFreedomCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 3 2 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.

	self
		should: [ aFreedomCard isPlayedOn: aBoardGame from: 'Vicky' ]
		raise: Error
		withMessage: 'To play card, choose a player'
]

{ #category : 'tests' }
SpaceshipJailTest >> test22WhenFreedomCardIsThrownChoosingACardThenNeedToChooseAPlayer [

	| spaceships aBoard aBoardGame aCroupier |
	spaceships := OrderedCollection new.
	spaceships add: 'Vicky'.
	spaceships add: 'Cami'.
	aBoard := Board of: cellEffectsWithJail withLenght: (Parsec of: 15).
	aDeckOfCards := DeckOfCards with:
		                (OrderedCollection with: aFreedomCard).
	aCroupier := Croupier handling: aDeckOfCards.

	aBoardGame := BoardGame
		              playedBy: spaceships
		              rolling:
		              (OrderedCollection with: (LoadedDie of: #( 1 3 2 )))
		              on: aBoard
		              with: 3
		              managedBy: aCroupier.

	aBoardGame playTurnFor: 'Vicky'.

	self
		should: [
			aFreedomCard
				isPlayedOn: aBoardGame
				from: 'Vicky'
				choosing: aSpeedCard ]
		raise: Error
		withMessage: 'To play card, choose a player'
]
