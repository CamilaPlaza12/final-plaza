Class {
	#name : 'InJail',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'as yet unclassified' }
InJail >> captureIn: aJail [
]

{ #category : 'accessing' }
InJail >> information [
	
	^true
]

{ #category : 'as yet unclassified' }
InJail >> releaseFrom: aJail [

	aJail changeState: NotInJail new.
]
