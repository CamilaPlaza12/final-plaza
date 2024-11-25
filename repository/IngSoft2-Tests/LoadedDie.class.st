Class {
	#name : 'LoadedDie',
	#superclass : 'Object',
	#instVars : [
		'sequence',
		'sequenceIndex',
		'faces'
	],
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'initialize' }
LoadedDie class >> of: aSequence [
	self validateExistsWith: aSequence.
	^(self new) initializeWith: aSequence.
]

{ #category : 'initialize' }
LoadedDie class >> validateExistsWith: aSequence [
	(aSequence anySatisfy: [:value | value <= 0]) ifTrue: [ 
		Error signal: 'Cannot create die with value less than 0' ].
]

{ #category : 'accessing' }
LoadedDie >> faces [ 
	^faces 
]

{ #category : 'instance creation' }
LoadedDie >> initializeWith: aSequence [
	sequence:= aSequence.
	sequenceIndex := 1.
	faces := sequence max.
	
	
]

{ #category : 'instance variables' }
LoadedDie >> sequence [

	^ sequence
]

{ #category : 'action' }
LoadedDie >> throw [
	|value|
        value := sequence  at: sequenceIndex  .
        sequenceIndex := (sequenceIndex \\ sequence size) + 1.
        ^ value.
]
