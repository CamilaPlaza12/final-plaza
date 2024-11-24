Class {
	#name : 'OverloadCard',
	#superclass : 'Object',
	#instVars : [
		'cardId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance variables' }
OverloadCard >> id [

	^ cardId
]

{ #category : 'initialization' }
OverloadCard >> id: number [ 

	cardId:= number.
]

{ #category : 'action' }
OverloadCard >> implementOn: aBoardGame [

	^ -2
]

{ #category : 'action' }
OverloadCard >> isPlayedOn: aBoardGame from: aSpaceship [ 

	Error signal: 'To play card, choose a player'
]

{ #category : 'action' }
OverloadCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	
	Error signal: 'To play card, choose a player'.
]

{ #category : 'testing' }
OverloadCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [ 
	|aCardPlayers|
	aBoardGame validateSpaceshipExists: anotherSpaceship.
	aBoardGame validates: aSpaceship canPlay: self.
	aCardPlayers := CardPlayers
		                of: self
		                with: (OrderedCollection with: anotherSpaceship).
	aBoardGame recordPermanent: aCardPlayers.
]

{ #category : 'instance variables' }
OverloadCard >> name [

	^'overload'.
]
