Class {
	#name : 'CancellationCard',
	#superclass : 'Object',
	#instVars : [
		'cardId'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'instance variable' }
CancellationCard >> id [
	^cardId 
]

{ #category : 'instance variable' }
CancellationCard >> id: number [ 
	cardId:= number.
]

{ #category : 'action' }
CancellationCard >> isPlayedOn: aBoardGame from: aSpaceship [
	Error signal: 'To play card choose a card'
]

{ #category : 'testing' }
CancellationCard >> isPlayedOn: aBoardGame from: aSpaceship choosing: aCard [ 
	aBoardGame takes: self from: aSpaceship.
	aBoardGame appliesCancellationCardTo: aCard.
]

{ #category : 'action' }
CancellationCard >> isPlayedOn: aBoardGame from: aSpaceship to: anotherSpaceship [ 
	Error signal: 'You have to choose a card.'
]

{ #category : 'instance variable' }
CancellationCard >> name [
	^'cancellation'.
]
