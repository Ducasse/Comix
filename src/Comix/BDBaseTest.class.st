Class {
	#name : #BDBaseTest,
	#superclass : #TestCase,
	#instVars : [
		'testingWorkingDirectory'
	],
	#category : #'Comix-Test'
}

{ #category : #running }
BDBaseTest >> setUp [

	super setUp.
	testingWorkingDirectory := FileSystem memory workingDirectory.
	(testingWorkingDirectory / self class bibFileNameForTest)
		writeStreamDo: [ :stream | 
			stream nextPutAll: self class bibContentsForTest ]
]
