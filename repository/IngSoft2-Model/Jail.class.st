Class {
	#name : 'Jail',
	#superclass : 'Object',
	#instVars : [
		'state'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
Jail class >> initializeNew [
	^ (self new) initializeNew
]

{ #category : 'as yet unclassified' }
Jail >> capture [

	state captureIn: self
]

{ #category : 'as yet unclassified' }
Jail >> changeState: newState [

	state := newState .
]

{ #category : 'initialization' }
Jail >> initializeNew [

	state := NotInJail new.
]

{ #category : 'dependencies' }
Jail >> release [

	state releaseFrom: self
]

{ #category : 'accessing' }
Jail >> state [
	
	^ state information
]
