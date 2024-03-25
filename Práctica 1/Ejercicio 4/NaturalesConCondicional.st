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


!classDefinition: #III category: #NaturalesConCondicional!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIII category: #NaturalesConCondicional!
III subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIII category: #NaturalesConCondicional!
IIII subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIII category: #NaturalesConCondicional!
IIIII subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIII category: #NaturalesConCondicional!
IIIIII subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIII category: #NaturalesConCondicional!
IIIIIII subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIII category: #NaturalesConCondicional!
IIIIIIII subclass: #IIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIII subclass: #IIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIII subclass: #IIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIII subclass: #IIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIII subclass: #IIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIII subclass: #IIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!


!classDefinition: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII category: #NaturalesConCondicional!
IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII subclass: #IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'NaturalesConCondicional'!
