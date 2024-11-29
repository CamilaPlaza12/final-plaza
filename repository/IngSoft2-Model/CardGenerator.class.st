Class {
	#name : 'CardGenerator',
	#superclass : 'Object',
	#instVars : [
		'amountOfCards',
		'speeds',
		'overloads',
		'accelerations',
		'cancellations',
		'redos',
		'repeats',
		'cards',
		'freedoms',
		'reverses',
		'skips',
		'doubles'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialize' }
CardGenerator class >> setWithCards: aNumber [

	^ self new initializeWithCards: aNumber
]

{ #category : 'instance variable' }
CardGenerator >> accelerations [

	^ accelerations
]

{ #category : 'instance variable' }
CardGenerator >> cancellations [

	^ cancellations
]

{ #category : 'instance creation' }
CardGenerator >> cards [

	^ cards
]

{ #category : 'instance variable' }
CardGenerator >> doubles [

	^ doubles
]

{ #category : 'instance variable' }
CardGenerator >> freedoms [

	^ freedoms
]

{ #category : 'instance creation' }
CardGenerator >> initializeDeck [

	1 to: amountOfCards do: [ :index |
		| aNumber |
		aNumber := 100 atRandom.
		(aNumber > 0 and: aNumber <= 10) ifTrue: [
			cards add: SpeedCard new.
			speeds := speeds + 1 ].

		(aNumber > 10 and: aNumber <= 20) ifTrue: [
			cards add: OverloadCard new.
			overloads := overloads + 1 ].

		(aNumber > 20 and: aNumber <= 30) ifTrue: [
			cards add: AccelerationCard new.
			accelerations := accelerations + 1 ].

		(aNumber > 30 and: aNumber <= 40) ifTrue: [
			cards add: CancellationCard new.
			cancellations := cancellations + 1 ].

		(aNumber > 40 and: aNumber <= 50) ifTrue: [
			cards add: RedoCard new.
			redos := redos + 1 ].

		(aNumber > 50 and: aNumber <= 60) ifTrue: [
			cards add: RepeatCard new.
			repeats := repeats + 1 ].

		(aNumber > 60 and: aNumber <= 70) ifTrue: [
			cards add: FreedomCard new.
			freedoms := freedoms + 1 ].

		(aNumber > 70 and: aNumber <= 80) ifTrue: [
			cards add: ReverseCard new.
			reverses := reverses + 1 ].

		(aNumber > 80 and: aNumber <= 90) ifTrue: [
			cards add: SkipCard new.
			skips := skips + 1 ].

		(aNumber > 90 and: aNumber <= 100) ifTrue: [
			cards add: DoubleCard new.
			doubles := doubles + 1 ] ]
]

{ #category : 'instance creation' }
CardGenerator >> initializeWithCards: aNumber [

	cards := OrderedCollection new.
	amountOfCards := aNumber.
	speeds := 0.
	overloads := 0.
	accelerations := 0.
	cancellations := 0.
	redos := 0.
	repeats := 0.
	freedoms := 0.
	reverses := 0.
	skips := 0.
	doubles := 0.
	self initializeDeck
]

{ #category : 'instance variable' }
CardGenerator >> overloads [

	^ overloads
]

{ #category : 'instance variable' }
CardGenerator >> redos [

	^ redos
]

{ #category : 'instance variable' }
CardGenerator >> repeats [

	^ repeats
]

{ #category : 'instance variable' }
CardGenerator >> reverses [

	^ reverses
]

{ #category : 'instance variable' }
CardGenerator >> skips [

	^ skips
]

{ #category : 'instance variable' }
CardGenerator >> speeds [

	^ speeds
]
