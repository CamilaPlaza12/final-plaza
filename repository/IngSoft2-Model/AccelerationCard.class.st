Class {
	#name : 'AccelerationCard',
	#superclass : 'Object',
	#instVars : [
		'cardId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance variable' }
AccelerationCard >> id [
	^cardId 
]

{ #category : 'instance variable' }
AccelerationCard >> id: number [ 
	cardId:= number.
]

{ #category : 'action' }
AccelerationCard >> implementOn: aBoardGame [ 
	^1
]

{ #category : 'testing' }
AccelerationCard >> isPlayedOn: aBoardGame from: aSpaceship [
	|aCardPlayers|
	aBoardGame validates: aSpaceship canPlay: self.
	aCardPlayers := CardPlayers
		                of: self
		                with: aBoardGame spaceships.
	aBoardGame recordPermanent: aCardPlayers.
]

{ #category : 'action' }
AccelerationCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	
	Error signal: 'You cannot choose a card for acceleration card.'
]

{ #category : 'action' }
AccelerationCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [
	Error signal: 'You cannot choose a player for acceleration card.'
]
