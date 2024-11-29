Class {
	#name : 'ReverseEffect',
	#superclass : 'Object',
	#instVars : [
		'effect'
	],
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'initialization' }
ReverseEffect class >> initializeNew [
	^ (self new) initializeNew
]

{ #category : 'accessing' }
ReverseEffect >> changeState: newEffect [

	effect := newEffect .
]

{ #category : 'accessing' }
ReverseEffect >> effect [
	^ effect
]

{ #category : 'initialization' }
ReverseEffect >> initializeNew [
	effect := UnreversedGame new.
]

{ #category : 'accessing' }
ReverseEffect >> reverse [
	
	effect reverseShiftsOrderFrom: self
]

{ #category : 'accessing' }
ReverseEffect >> unreverse [
	
	effect unreverseShiftsOrderFrom: self
]
