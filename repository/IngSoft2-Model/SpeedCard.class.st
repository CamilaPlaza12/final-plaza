Class {
	#name : 'SpeedCard',
	#superclass : 'Object',
	#instVars : [
		'cardId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance variable' }
SpeedCard >> id [

	^ cardId
]

{ #category : 'initialization' }
SpeedCard >> id: number [

	cardId := number
]

{ #category : 'action' }
SpeedCard >> implementOn: aBoardGame [

	^ 1
]

{ #category : 'validation' }
SpeedCard >> isPlayedOn: aBoardGame from: aSpaceship [ 

	Error signal: 'To play card, choose a player'
]

{ #category : 'action' }
SpeedCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	
	Error signal: 'To play card, choose a player'.
]

{ #category : 'testing' }
SpeedCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [ 
	|aCardPlayers|
	aBoardGame validateSpaceshipExists: anotherSpaceship.
	aBoardGame validates: aSpaceship canPlay: self.
	aCardPlayers := CardPlayers
		                of: self
		                with: (OrderedCollection with: anotherSpaceship).
	aBoardGame recordPermanent: aCardPlayers.
	
]
