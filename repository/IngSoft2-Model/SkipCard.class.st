Class {
	#name : 'SkipCard',
	#superclass : 'Object',
	#instVars : [
		'cardId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
SkipCard >> id [

	^ cardId
]

{ #category : 'accessing' }
SkipCard >> id: number [

	cardId := number
]

{ #category : 'accessing' }
SkipCard >> isPlayedOn: aBoardGame from: aSpaceship [

	aBoardGame takes: self from: aSpaceship.
	aBoardGame applySkipEffect.
]

{ #category : 'accessing' }
SkipCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	
	Error signal: 'To play card, dont choose a card'.
]

{ #category : 'accessing' }
SkipCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [

	Error signal: 'To play card, dont choose a player'
]
