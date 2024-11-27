Class {
	#name : 'ReversedGame',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
ReversedGame >> information [
	^true.
]

{ #category : 'accessing' }
ReversedGame >> reverseShiftsOrderFrom: aReverseEffect [


]

{ #category : 'accessing' }
ReversedGame >> unreverseShiftsOrderFrom: aReverseEffect [

	aReverseEffect changeState: UnreversedGame new.


]
