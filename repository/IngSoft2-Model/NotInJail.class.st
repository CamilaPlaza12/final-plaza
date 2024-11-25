Class {
	#name : 'NotInJail',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
NotInJail >> captureIn: aJail [
	
	aJail changeState: InJail new.
]

{ #category : 'accessing' }
NotInJail >> information [
	^false.
]

{ #category : 'as yet unclassified' }
NotInJail >> releaseFrom: aJail [
]
