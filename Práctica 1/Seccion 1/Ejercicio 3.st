!classDefinition: #BooleanoTest category: #'Ejercicio 3'!
DenotativeObject subclass: #BooleanoTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BooleanoTest class' category: #'Ejercicio 3'!
BooleanoTest class
	instanceVariableNames: ''!

!BooleanoTest class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 21:42:50'!
testNo
	"Testea la negación"
	
	Assert that: Verdadero no isEqualTo: Falso.
	Assert that: Falso no isEqualTo: Verdadero.

	
! !

!BooleanoTest class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 22:01:00'!
testO
	"Testea el O."

	Assert that: (Verdadero o: Verdadero) isEqualTo: Verdadero.
	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero.
	Assert that: (Falso o: Verdadero) isEqualTo: Verdadero.
	Assert that: (Falso o: Falso) isEqualTo: Falso.



! !

!BooleanoTest class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 22:02:15'!
testSiFalso
	"siFalso ejecuta el bloque de código."

	| unNumero |
	unNumero := 0.
	Verdadero siFalso: [unNumero := 1].
	Assert that: unNumero isEqualTo: 0.
	unNumero := 0.
	Falso siFalso: [unNumero := 1].
	Assert that: unNumero isEqualTo: 1.! !

!BooleanoTest class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 22:02:08'!
testSiVerdadero
	"siEsVerdadero ejecuta el bloque de código."

	| unNumero |
	unNumero := 0.
	Verdadero siVerdadero: [unNumero := 1].
	Assert that: unNumero isEqualTo: 1.
	unNumero := 0.
	Falso siVerdadero: [unNumero := 1].
	Assert that: unNumero isEqualTo: 0.! !

!BooleanoTest class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 22:01:20'!
testY
	"Testea Y"

	Assert that: (Verdadero y: Verdadero) isEqualTo: Verdadero.
	Assert that: (Falso y: Verdadero) isEqualTo: Falso.
	Assert that: (Verdadero y: Falso) isEqualTo: Falso.
	Assert that: (Falso y: Falso) isEqualTo: Falso.! !


!classDefinition: #Falso category: #'Ejercicio 3'!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #'Ejercicio 3'!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 21:54:09'!
no
	^Verdadero! !

!Falso class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 21:56:31'!
o: unBooleano
	^unBooleano.! !

!Falso class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 21:59:14'!
siFalso: unaAccionARealizarUIgnorar

	^unaAccionARealizarUIgnorar value.! !

!Falso class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 22:02:56'!
siVerdadero: unaAccionARealizarUIgnorar

	! !

!Falso class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 21:56:02'!
y: UnBooleano
	^Falso! !


!classDefinition: #Verdadero category: #'Ejercicio 3'!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ejercicio 3'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #'Ejercicio 3'!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 21:54:20'!
no
	^Falso! !

!Verdadero class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 21:56:44'!
o: unBooleano
	^Verdadero.! !

!Verdadero class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 21:58:59'!
siFalso: unaAccionARealizarUIgnorar
	^nil.! !

!Verdadero class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 21:57:57'!
siVerdadero: unaAccionARealizarUIgnorar

	^unaAccionARealizarUIgnorar value.! !

!Verdadero class methodsFor: '-- all --' stamp: 'jcd 3/18/2024 21:55:49'!
y: unBooleano
	^unBooleano! !
