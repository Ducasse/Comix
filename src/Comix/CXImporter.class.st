Class {
	#name : #CXImporter,
	#superclass : #Object,
	#category : #'Comix-Import'
}

{ #category : #importing }
CXImporter class >> import [

	| p |
	p := XMLDOMParser onFileNamed: 'BD.319.xml'.
	p parseDocument
]
