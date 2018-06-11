Class {
	#name : #BDBaseTest,
	#superclass : #TestCase,
	#instVars : [
		'testingWorkingDirectory'
	],
	#category : #'Comix-Test'
}

{ #category : #constants }
BDBaseTest class >> contentsForTest [

	^ ''
]

{ #category : #constants }
BDBaseTest class >> fileNameForTest [

	^ 'BD.ston'
]

{ #category : #running }
BDBaseTest >> setUp [

	super setUp.
	testingWorkingDirectory := FileSystem memory workingDirectory.
	(testingWorkingDirectory / self class fileNameForTest)
		writeStreamDo: [ :stream | 
			stream nextPutAll: self class contentsForTest ]
]
