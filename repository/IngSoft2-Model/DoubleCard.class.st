Class {
	#name : 'DoubleCard',
	#superclass : 'Object',
	#instVars : [
		'cardId'
	],
	#classInstVars : [
		'cardId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
DoubleCard >> id [

	^ cardId
]

{ #category : 'accessing' }
DoubleCard >> id: number [

	cardId := number
]

{ #category : 'accessing' }
DoubleCard >> isPlayedOn: aBoardGame from: aSpaceship [
	
	aBoardGame validateSomeSpaceshipHasPlayed.
	aBoardGame takes: self from: aSpaceship.
	aBoardGame applyDoubleEffect
]

{ #category : 'accessing' }
DoubleCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	
	Error signal: 'To play card, dont choose a card'.
]

{ #category : 'accessing' }
DoubleCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [

	Error signal: 'To play card, dont choose a player'
]
