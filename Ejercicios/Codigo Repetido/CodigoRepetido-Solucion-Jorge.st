!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'private testing' stamp: 'jcs 4/8/2024 23:24:50'!
assertEqualityOn: aCustomerBook activeCustomerCount: numberOfActiveCustomers suspendedCustomerCount: numberOfSuspendedCustomers customerCount: numberOfCustomers

	self assert: numberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: numberOfCustomers equals: aCustomerBook numberOfCustomers.! !

!CustomerBookTest methodsFor: 'private testing' stamp: 'jcs 4/10/2024 15:37:10'!
assertErrorTriggeredOnClosure: closureThatShoudFail errorToCatch: anError closureToRunAfterFailure: closureToBeRunAfterFailure

	[ closureThatShoudFail value.
	self fail ]
		on: anError
		do: closureToBeRunAfterFailure
	! !

!CustomerBookTest methodsFor: 'private testing' stamp: 'jcs 4/9/2024 17:03:05'!
assertOnlyCustomerOn: aCustomerBook isCustomer: aCustomerName

	self assert: aCustomerBook numberOfCustomers = 1.
	self assert: (aCustomerBook includesCustomerNamed: aCustomerName)! !

!CustomerBookTest methodsFor: 'private testing' stamp: 'jcs 4/8/2024 21:08:39'!
meassureRuntimeInMilliseconds: aClosure
	
	|  millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^millisecondsAfterRunning - millisecondsBeforeRunning! !


!CustomerBookTest methodsFor: 'testing' stamp: 'jcs 4/8/2024 21:09:06'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook runtimeInMilliseconds |
	
	customerBook := CustomerBook new.
	
	runtimeInMilliseconds := self meassureRuntimeInMilliseconds: 
		[ customerBook addCustomerNamed: 'John Lennon' ].
	
	self assert: runtimeInMilliseconds < (50 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jcs 4/9/2024 16:52:41'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook runtimeInMilliseconds paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	runtimeInMilliseconds := self meassureRuntimeInMilliseconds: 
		[ customerBook removeCustomerNamed: paulMcCartney ].
	
	self assert: runtimeInMilliseconds < (100 * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jcs 4/10/2024 15:37:10'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	self assertErrorTriggeredOnClosure: [ customerBook addCustomerNamed: '' ]
		errorToCatch: Error 
		closureToRunAfterFailure: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jcs 4/10/2024 15:37:10'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertErrorTriggeredOnClosure: [ customerBook removeCustomerNamed: 'Paul McCartney' ]
		errorToCatch: NotFound
		closureToRunAfterFailure: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jcs 4/8/2024 23:23:44'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self assertEqualityOn: customerBook
		activeCustomerCount: 0
		suspendedCustomerCount: 1 
		customerCount: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jcs 4/9/2024 16:56:07'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertEqualityOn: customerBook
		activeCustomerCount: 0
		suspendedCustomerCount: 0 
		customerCount: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jcs 4/10/2024 15:37:10'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertErrorTriggeredOnClosure: [ customerBook suspendCustomerNamed: 'George Harrison' ]
		errorToCatch: CantSuspend
		closureToRunAfterFailure: [ :anError | 
			self assertOnlyCustomerOn: customerBook isCustomer: johnLennon ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'jcs 4/10/2024 15:37:10'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self assertErrorTriggeredOnClosure: [ customerBook suspendCustomerNamed: johnLennon ]
		errorToCatch: CantSuspend
		closureToRunAfterFailure: [ :anError | 
			self assertOnlyCustomerOn: customerBook isCustomer: johnLennon ]! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'jcs 4/10/2024 15:34:37'!
isEmpty
	
	^self numberOfCustomers isZero ! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'jcs 4/10/2024 15:05:06'!
addCustomerNamed: aName
	
	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(self includesCustomerNamed: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'jcs 4/10/2024 15:09:44'!
numberOfCustomers
	
	^self numberOfActiveCustomers + self numberOfSuspendedCustomers ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'jcs 4/10/2024 15:08:56'!
removeCustomerNamed: aName 
 
	active remove: aName ifAbsent: [ 
		suspended remove: aName ifAbsent: [
			^NotFound signal
		] 
	]
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'jcs 4/10/2024 15:04:22'!
suspendCustomerNamed: aName 

	active remove: aName ifAbsent: [ ^CantSuspend signal]. 
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:52'!
customerAlreadyExistsErrorMessage

	^'Customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/9/2023 22:25:56'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty!!!!!!'! !
