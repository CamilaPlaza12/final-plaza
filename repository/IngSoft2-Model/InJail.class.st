Class {
	#name : 'InJail',
	#superclass : 'Object',
	#category : 'IngSoft2-Model',
	#package : 'IngSoft2-Model'
}

{ #category : 'accessing' }
InJail >> information [
	
	^true
]

{ #category : 'as yet unclassified' }
InJail >> releaseFrom: aJail [

	aJail changeState: NotInJail new.
]
