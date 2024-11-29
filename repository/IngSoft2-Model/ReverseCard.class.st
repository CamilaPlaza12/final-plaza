Class {
	#name : 'ReverseCard',
	#superclass : 'Object',
	#instVars : [
		'cardId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
ReverseCard >> id [

	^ cardId
]

{ #category : 'accessing' }
ReverseCard >> id: number [

	cardId := number
]

{ #category : 'accessing' }
ReverseCard >> isPlayedOn: aBoardGame from: aSpaceship [

	aBoardGame takes: self from: aSpaceship.
	aBoardGame applyReverseEffect.
]

{ #category : 'accessing' }
ReverseCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	
	Error signal: 'To play card, dont choose a card'.
]

{ #category : 'accessing' }
ReverseCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [

	Error signal: 'To play card, dont choose a player'
]
