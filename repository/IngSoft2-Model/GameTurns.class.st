Class {
	#name : 'GameTurns',
	#superclass : 'Object',
	#instVars : [
		'spaceships',
		'turn',
		'reverseEffect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
GameTurns class >> initializeTurnsOf: aGroupOfSpaceships [
	^(self new) initializeTurnsOf: aGroupOfSpaceships.
]

{ #category : 'jail' }
GameTurns >> applyReverseEffect [

	self reverseEffect
		ifTrue: [ reverseEffect unreverse ]
		ifFalse: [ reverseEffect reverse ]
]

{ #category : 'initialization' }
GameTurns >> initializeTurnsOf: aGroupOfSpaceships [

	spaceships:= aGroupOfSpaceships .
	turn:= 1.
	reverseEffect := ReverseEffect initializeNew .
]

{ #category : 'initialization' }
GameTurns >> nextTurn [

	turn := turn \\ spaceships size + 1
]

{ #category : 'initialization' }
GameTurns >> reverseEffect [

	^ reverseEffect effect information
]

{ #category : 'initialization' }
GameTurns >> spaceships [ 
	^spaceships 
]

{ #category : 'initialization' }
GameTurns >> turn [

	^ turn
]
