Class {
	#name : #LatexPrinter,
	#superclass : #Object,
	#instVars : [
		'stream',
		'twoColumn',
		'lines'
	],
	#category : #Comix
}

{ #category : #'latex default' }
LatexPrinter >> addLatexEnd [


	stream nextPutAll: '\end{document}'
]

{ #category : #'latex default' }
LatexPrinter >> addLatexStart [


	stream nextPutAll: '\documentclass[', self columns, ']{article}
\usepackage[utf8]{inputenc}  %% les accents dans le fichier.tex
\usepackage{calc}
\usepackage[pdftex]{graphicx}
\usepackage{vmargin}
\setmarginsrb{1.2cm}{2cm}{1.2cm}{1.2cm}{0cm}{0cm}{0cm}{0cm}
\pagestyle{empty}
\begin{document}
\noindent
\scriptsize'
]

{ #category : #'latex default' }
LatexPrinter >> addTableEnd [

	stream cr ; nextPutAll: '\end{tabular}' ; cr
]

{ #category : #'latex default' }
LatexPrinter >> addTableStart [

	stream cr ; nextPutAll: '\noindent\begin{tabular}{|rp{3.2cm}p{4cm}r|}\hline' ; cr
]

{ #category : #'latex default' }
LatexPrinter >> addTableTwoEnd [

	stream cr ; nextPutAll: '\end{tabular}' ; cr
]

{ #category : #'latex default' }
LatexPrinter >> addTableTwoStart [

	stream cr ; nextPutAll: '\noindent\begin{tabular}{|p{0.5cm}p{3.2cm}p{3cm}p{0.5cm}||p{0.5cm}p{3.2cm}p{3cm}p{0.5cm}|}\hline' ; cr
]

{ #category : #'latex default' }
LatexPrinter >> columns [
	
	^ ''


	
]

{ #category : #'latex work' }
LatexPrinter >> dispatch [
	
	| bds |
	bds := base bdsSortedBySeries.
	1 to: bds size do: [:i |
					self printBD: (bds at: i). self hline.
					(i rem: 84) isZero ifTrue: [ self addTableEnd. self addTableStart]].


]

{ #category : #'latex work' }
LatexPrinter >> dispatchTwoColumns [
	| bds totalSize size |
	bds := base bdsSortedBySeries.
	totalSize := bds size.
	totalSize odd ifTrue: [size := totalSize - 1] ifFalse: [size := totalSize].
	1 to: size
		by: 2
		do: 
			[:i | 
			self printBD: (bds at: i).
			stream nextPutAll: '&'.
			self printBD: (bds at: i + 1).
			self hline.
			(i + 1 rem: 120) isZero 
				ifTrue: 
					[self addTableTwoEnd.
					self addTableTwoStart]].
	self printBD: (bds at: totalSize).
	self printBD: ((BD new)
				title: ' ';
				serie: ' ';
				number: 0;
				year: 0)
]

{ #category : #configuration }
LatexPrinter >> extension [

	^ 'tex'
]

{ #category : #'latex work' }
LatexPrinter >> hline [
	stream
		nextPutAll: '\\ \hline';
		cr
]

{ #category : #initialize }
LatexPrinter >> initialize [

	super initialize.
	lines := 0.
	self fileName: 'BELIST'.
	twoColumn := true.
]

{ #category : #lines }
LatexPrinter >> linePlus [

	lines := lines +1 
]

{ #category : #'latex work' }
LatexPrinter >> printBD: aBD [

	aBD isOriginal 
		ifTrue: [
		stream cr; 
			nextPutAll: ((aBD hasNumber) ifTrue: [aBD publicNumber asString] ifFalse: ['']); nextPutAll: '&' ; 
			nextPutAll: aBD publicSortedAs asString ; nextPutAll: '&' ; 
			nextPutAll: aBD title asString ; nextPutAll: '&' ; 
			nextPutAll: aBD year asString ]
]

{ #category : #public }
LatexPrinter >> save [
	self stream.
	self addLatexStart.
	self treatBase.
	self addLatexEnd
]

{ #category : #stream }
LatexPrinter >> stream [
	
	stream := (MultiByteFileStream newFileNamed: self nextBDFileName).
	stream converter: UTF8TextConverter new
]

{ #category : #public }
LatexPrinter >> treatBase [

	twoColumn 
		ifTrue: 
			[self addTableTwoStart.
			self dispatchTwoColumns.
			self addTableTwoEnd]
		ifFalse: 
			[self addTableStart.
			self dispatch.
			self addTableEnd]
]
