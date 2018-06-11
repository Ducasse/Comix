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
	workingDirectory := FileSystem workingDirectory.
]

{ #category : #'in/out' }
BDBase >> save [

	(workingDirectory / (workingDirectory nextNameFor: 'BDs' extension: 'ston')) 
		asFileReference writeStreamDo: [ :str | str nextPutAll: 
		(STON toStringPretty: self)]
]
