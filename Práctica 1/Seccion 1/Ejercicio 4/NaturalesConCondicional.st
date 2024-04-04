!classDefinition: #I category: #NaturalesConCondicional!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #NaturalesConCondicional!
I class
	instanceVariableNames: ''!

!I class methodsFor: '-- all --' stamp: 'jcs 3/21/2024 21:31:18'!
* aMultiplicand
	^aMultiplicand.! !

!I class methodsFor: '-- all --' stamp: 'jcs 3/21/2024 21:48:53'!
+ anAdder
	^anAdder next.! !

!I class methodsFor: '-- all --' stamp: 'jcs 3/24/2024 23:30:27'!
- aSustraend
	
	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

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

!I class methodsFor: '-- all --' stamp: 'jcs 3/24/2024 23:30:08'!
previous

	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !


!classDefinition: #II category: #NaturalesConCondicional!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #NaturalesConCondicional!
II class
	instanceVariableNames: ''!

!II class methodsFor: '-- all --' stamp: 'jcs 3/24/2024 22:44:24'!
* aMultiplicand
	^aMultiplicand + (aMultiplicand * self previous).! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/21/2024 21:43:31'!
+ anAdder
	^self previous + anAdder next.! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/24/2024 23:01:16'!
- aSustraend
	aSustraend == I ifTrue: [^self previous].
	^(self previous) - (aSustraend previous).! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/24/2024 23:37:31'!
/ dividend
	self == dividend ifTrue: [^I].
	^I + ((self - dividend) / dividend).! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/24/2024 23:38:10'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'El resultado no es un numero natural.'.! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/21/2024 21:11:06'!
next
	^self createChildNamed: self name, 'I'.! !

!II class methodsFor: '-- all --' stamp: 'jcs 3/21/2024 21:16:24'!
previous
	self == II ifTrue: [^I].
	^self parent.! !



