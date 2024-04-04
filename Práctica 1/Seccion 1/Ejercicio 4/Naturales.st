!classDefinition: #I category: 'Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: '-- all --' stamp: 'jcs 3/21/2024 21:31:18'!
* aMultiplicand
	^aMultiplicand.! !

!I class methodsFor: '-- all --' stamp: 'jcs 3/21/2024 21:48:53'!
+ anAdder
	^anAdder next.! !

!I class methodsFor: '-- all --' stamp: 'jcs 3/25/2024 21:32:36'!
- aSustraend
	
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.
! !

!I class methodsFor: '-- all --' stamp: 'jcs 3/24/2024 23:32:00'!
/ dividend

	dividend == I ifTrue: [^self].
	^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor.! !

!I class methodsFor: '-- all --' stamp: 'jcs 3/24/2024 23:31:49'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'El resultado no es un numero natural.'.! !

!I class methodsFor: '-- all --' stamp: 'jcs 3/24/2024 23:37:53'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'El resultado no es un numero natural.'.! !

!I class methodsFor: '-- all --' stamp: 'jcs 3/21/2024 21:10:21'!
next
	^II! !

!I class methodsFor: '-- all --' stamp: 'jcs 3/25/2024 21:32:41'!
previous

	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.
! !

!I class methodsFor: '-- all --' stamp: 'jcs 3/25/2024 21:45:37'!
substractFrom: minuend 
	^minuend previous.! !


!classDefinition: #II category: 'Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Naturales'!
II class
	instanceVariableNames: 'myPrevious'!

!II class methodsFor: '-- all --' stamp: 'jcs 3/24/2024 22:44:24'!
* aMultiplicand
	^aMultiplicand + (aMultiplicand * self previous).! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/21/2024 21:43:31'!
+ anAdder
	^self previous + anAdder next.! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/25/2024 21:46:41'!
- aSustraend
	^aSustraend substractFrom: self.
	! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/25/2024 21:28:08'!
/ dividend
	self == dividend ifTrue: [^I].
	^I + ((self - dividend) / dividend).! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/24/2024 23:38:10'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'El resultado no es un numero natural.'.! !

!II class methodsFor: '--** private fileout/in **--' stamp: 'jcs 3/25/2024 21:54:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	myPrevious := I.! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/25/2024 21:03:35'!
next
	| nextNumber |
	nextNumber := II createChildNamed: self name, 'I'.
	nextNumber setPrevious: self.
	^nextNumber.! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/25/2024 20:56:59'!
previous
	^myPrevious.! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/25/2024 20:58:07'!
setPrevious: currentPrevious

	myPrevious := currentPrevious.! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/25/2024 21:51:26'!
substractFrom: minuend
	^minuend previous - self previous.! !


!II class methodsFor: '--** private fileout/in **--' stamp: 'jcs 3/25/2024 21:54:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	myPrevious := I.! !


!classDefinition: #III category: 'Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: '--** private fileout/in **--' stamp: 'jcs 3/25/2024 21:54:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	myPrevious := II.! !


!classDefinition: #IIII category: 'Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: '--** private fileout/in **--' stamp: 'jcs 3/25/2024 21:54:57'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	myPrevious := III.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!