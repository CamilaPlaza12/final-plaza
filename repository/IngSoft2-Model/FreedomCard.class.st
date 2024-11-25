Class {
	#name : 'FreedomCard',
	#superclass : 'Object',
	#instVars : [
		'cardId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
FreedomCard >> id [

	^ cardId
]

{ #category : 'accessing' }
FreedomCard >> id: number [

	cardId := number
]

{ #category : 'accessing' }
FreedomCard >> isPlayedOn: aBoardGame from: aSpaceship [ 

	Error signal: 'To play card, choose a player'
]

{ #category : 'accessing' }
FreedomCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	
	Error signal: 'To play card, choose a player'.
]

{ #category : 'accessing' }
FreedomCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [ 
	aBoardGame validateSpaceshipExists: anotherSpaceship.
	aBoardGame takes: self from: aSpaceship.
	aBoardGame releaseFromJail: anotherSpaceship.


	
]
