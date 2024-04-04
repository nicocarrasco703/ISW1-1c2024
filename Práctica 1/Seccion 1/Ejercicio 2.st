!classDefinition: #Bill category: #'Ejercicio 2'!
DenotativeObject subclass: #Bill
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 2'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Bill class' category: #'Ejercicio 2'!
Bill class
	instanceVariableNames: 'energia'!

!Bill class methodsFor: '-- all --' stamp: 'NC 3/19/2024 14:28:39'!
caminar: unaCantidadDeKilometros
	energia := energia - (unaCantidadDeKilometros + 3)! !

!Bill class methodsFor: '-- all --' stamp: 'NC 3/19/2024 14:27:53'!
comer: unaCantidadDeKilosDeCerebro
	energia := energia + (unaCantidadDeKilosDeCerebro * 4)! !

!Bill class methodsFor: '-- all --' stamp: 'NC 3/19/2024 14:27:03'!
energia
	^energia! !

!Bill class methodsFor: '-- all --' stamp: 'NC 3/19/2024 14:26:51'!
initialize
	energia := 28! !

!Bill class methodsFor: '--** private fileout/in **--' stamp: 'NC 3/19/2024 14:32:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energia := 24.! !


!Bill class methodsFor: '--** private fileout/in **--' stamp: 'NC 3/19/2024 14:32:12'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	energia := 24.! !

Bill initialize!
Bill initializeAfterFileIn!