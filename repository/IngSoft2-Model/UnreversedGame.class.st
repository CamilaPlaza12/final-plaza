Class {
	#name : 'UnreversedGame',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
UnreversedGame >> information [
	^false.
]

{ #category : 'accessing' }
UnreversedGame >> reverseShiftsOrderFrom: aReverseEffect [

	aReverseEffect changeState: ReversedGame new.
]
