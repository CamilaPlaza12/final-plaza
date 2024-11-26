Class {
	#name : 'SpaceshipPosition',
	#superclass : 'Object',
	#instVars : [
		'spaceship',
		'position',
		'inJail'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
SpaceshipPosition class >> named: spaceshipName on: aPosition [

	^ self new initializeNamed: spaceshipName on: aPosition
]

{ #category : 'instance variables' }
SpaceshipPosition >> >= anObject [
	^ (position cellNumber >= anObject position cellNumber) and: (position round >= anObject position round).
]

{ #category : 'accessing' }
SpaceshipPosition >> inJail [
	^ inJail
]

{ #category : 'instance creation' }
SpaceshipPosition >> initializeNamed: spaceshipName on: aPosition [

	spaceship := spaceshipName.
	position := aPosition.
	inJail := Jail initializeNew.
]

{ #category : 'instance variables' }
SpaceshipPosition >> position [

	^ position
]

{ #category : 'instance variables' }
SpaceshipPosition >> spaceships [

	^ spaceship
]
