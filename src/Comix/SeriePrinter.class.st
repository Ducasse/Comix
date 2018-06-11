"
berk I should refactor that hierarchy
"
Class {
	#name : #SeriePrinter,
	#superclass : #LatexPrinter,
	#category : #Comix
}

{ #category : #example }
SeriePrinter class >> printBaseName: aSymbol [

	| fx |
	fx := BDBase baseNamed: aSymbol asSymbol.
	(self new base: fx) save
]

{ #category : #'latex work' }
SeriePrinter >> addTableStart [

	stream cr ; nextPutAll: '\noindent\begin{tabular}{|rp{5cm}r|}\hline' ; cr
]

{ #category : #'latex work' }
SeriePrinter >> columns [

	^ 'twocolumn'
]

{ #category : #'initialize-release' }
SeriePrinter >> initialize [ 

	super initialize.
	self fileName:  'Series'
]

{ #category : #'latex work' }
SeriePrinter >> printBD: aBD [

	aBD isOriginal 
		ifTrue: [
		stream cr; 
			nextPutAll: ((aBD hasNumber) 
							ifTrue: [aBD publicNumber asString] 
							ifFalse: ['']); 
			nextPutAll: (aBD numberOnCover isNil not 
							ifTrue: [ '(', aBD numberOnCover asString, ')' ]
							ifFalse: ['']);
			nextPutAll: '&' ; 
			nextPutAll: aBD title asString ; nextPutAll: '&' ; 
			nextPutAll: aBD year asString.
			self hline]
]

{ #category : #'latex work' }
SeriePrinter >> printBDs: aSortedCollection [ 

	self addTableStart.
	aSortedCollection do: [:each | self printBD: each.].
	self addTableEnd
]

{ #category : #'latex work' }
SeriePrinter >> printSerie: each. [

	stream nextPutAll: '\subsection*{' , each title asString , '}' ; cr.
	self linePlus.
	each missingNumbers first do: [:missing | stream nextPutAll: missing asString] 
		separatedBy: [stream nextPut: Character space]
	
]

{ #category : #'latex work' }
SeriePrinter >> treatBase [
	"self printNormal"

	base series do: [ :each | 
						self printSerie: each. stream cr.
						self printBDs: each bds]

	

]
