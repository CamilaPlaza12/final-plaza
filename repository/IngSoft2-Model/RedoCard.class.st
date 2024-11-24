Class {
	#name : 'RedoCard',
	#superclass : 'Object',
	#instVars : [
		'cardId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance variables' }
RedoCard >> id [

	^ cardId
]

{ #category : 'action' }
RedoCard >> id: number [

	cardId := number
]

{ #category : 'testing' }
RedoCard >> isPlayedOn: aBoardGame from: aSpaceship [
	aBoardGame takes: self from: aSpaceship.
	aBoardGame dealLastPlayedCardTo: aSpaceship.
	(aBoardGame lastCardPlayed) isPlayedOn: aBoardGame from: aSpaceship.
]

{ #category : 'testing' }
RedoCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	aBoardGame takes: self from: aSpaceship.
	aBoardGame dealLastPlayedCardTo: aSpaceship.
	(aBoardGame lastCardPlayed) isPlayedOn: aBoardGame from: aSpaceship choosing: aCard.
]

{ #category : 'testing' }
RedoCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [ 
	aBoardGame takes: self from: aSpaceship.
	aBoardGame dealLastPlayedCardTo: aSpaceship.
	(aBoardGame lastCardPlayed) isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship.
	
]
