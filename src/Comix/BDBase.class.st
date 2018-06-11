Class {
	#name : #BDBase,
	#superclass : #Object,
	#instVars : [
		'bds',
		'workingDirectory'
	],
	#category : #'Comix-Core'
}

{ #category : #initialization }
BDBase >> add: aBD [

	bds add: aBD
]

{ #category : #initialization }
BDBase >> initialize [

	super initialize.
	bds := OrderedCollection new. 
]
