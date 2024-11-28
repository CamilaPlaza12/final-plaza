Class {
	#name : 'Croupier',
	#superclass : 'Object',
	#instVars : [
		'deckOfCards',
		'playersCards',
		'indexCards',
		'permanentCardsPlayers',
		'lastCardPlayed',
		'reversedCardEffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Croupier class >> handling: arg1 [

	^ self new handling: arg1
]

{ #category : 'jail' }
Croupier >> applyReverseEffectTo: aGameTurns [

	aGameTurns applyReverseEffect.
]

{ #category : 'action' }
Croupier >> cancellationCardTo: aCard [

	| aCardPlayers |
	aCardPlayers := permanentCardsPlayers detect: [ :cardPlayers | 
		                cardPlayers cards id = aCard id ]ifNone:[Error signal: 'That card does not exist'].
	
	permanentCardsPlayers remove: aCardPlayers .
	lastCardPlayed := CancellationCard new.
]

{ #category : 'action' }
Croupier >> dealACardTo: aSpaceship [
		playersCards do: [ :playerCards | 
		(playerCards spaceships = aSpaceship) ifTrue: [ 
			playerCards cards add: (deckOfCards cards at: indexCards).
			indexCards := indexCards \\ deckOfCards cards size + 1]].
]

{ #category : 'instance creation' }
Croupier >> dealCardsWhenGameIsStartedTo: spaceships [
	| size amountOfCards |
	size := 0.
	amountOfCards := 0.
	playersCards := OrderedCollection new.
	
	[ spaceships size > size ] whileTrue: [ 
		playersCards add: (PlayerCards
				 of: (spaceships at: size + 1)).
		self dealACardTo: (spaceships at: size + 1).
		self dealACardTo: (spaceships at: size + 1).
		
		size := size + 1 ]
	
	
]

{ #category : 'cards' }
Croupier >> dealLastPlayedCardTo: aSpaceship [ 
	playersCards do: [ :playerCards | 
		(playerCards spaceships = aSpaceship) ifTrue: [ 
			playerCards cards add: lastCardPlayed .]].
]

{ #category : 'instance creation' }
Croupier >> handling: aDeckOfCards [ 
	deckOfCards := aDeckOfCards.
	indexCards := 1.
	permanentCardsPlayers:= OrderedCollection new.
]

{ #category : 'action' }
Croupier >> lastCardPlayed [
	^lastCardPlayed .
]

{ #category : 'action' }
Croupier >> permanentCardsOf: aSpaceship [

	| anAmount |
	anAmount := 0.
	permanentCardsPlayers do: [ :cardPlayers | 
		(cardPlayers spaceships includes: aSpaceship) ifTrue: [ 
			anAmount := anAmount + (cardPlayers cards implementOn: self) ] ].
	^ anAmount
]

{ #category : 'action' }
Croupier >> playerCardOf: aSpaceship [

	| aPlayerCards |
	aPlayerCards := playersCards
		                detect: [ :playerCards | 
		                playerCards spaceships = aSpaceship ]
		                ifNone: [ Error signal: 'You are not playing' ].
	^ aPlayerCards
]

{ #category : 'action' }
Croupier >> recordPermanent: aCardPlayers [

	permanentCardsPlayers add: aCardPlayers.
	lastCardPlayed := aCardPlayers cards
]

{ #category : 'jail' }
Croupier >> releaseFromJail: aSpaceshipPosition [

	aSpaceshipPosition inJail release.
	lastCardPlayed := FreedomCard new.
]

{ #category : 'instance creation' }
Croupier >> reversedCardEffect [

	^ reversedCardEffect effect information
]

{ #category : 'action' }
Croupier >> takes: aCard from: aSpaceship [ 
	| aPlayerCards |
	aPlayerCards:= self playerCardOf: aSpaceship.
	aPlayerCards removeCard: aCard id.
]
