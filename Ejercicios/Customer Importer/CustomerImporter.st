!classDefinition: #PersistentSet category: #CustomerImporter!
Set subclass: #PersistentSet
	instanceVariableNames: 'session'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!PersistentSet methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:31'!
initializeOn: aSession from: aNonPersistentSet

	session := aSession.
	self addAll: aNonPersistentSet ! !


!PersistentSet methodsFor: 'adding' stamp: 'HAW 11/14/2023 08:23:40'!
add: newObject

	super add: newObject.
	session persist: newObject.
	
	^newObject! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PersistentSet class' category: #CustomerImporter!
PersistentSet class
	instanceVariableNames: ''!

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:24:32'!
on: aSession

	^self on: aSession from: #()! !

!PersistentSet class methodsFor: 'instance creation' stamp: 'HAW 11/14/2023 08:25:00'!
on: aSession from: aNonPersistentSet

	^self new initializeOn: aSession from: aNonPersistentSet
! !


!classDefinition: #ImportTest category: #CustomerImporter!
TestCase subclass: #ImportTest
	instanceVariableNames: 'session inputStream'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!ImportTest methodsFor: 'test' stamp: 'jcs 6/20/2024 17:38:47'!
test01Import

	| customers |
	
	inputStream := ReadStream on: self csvDataForTest01.
	
	self importCustomers.
	
	session beginTransaction.
	
	customers := session selectAllOfType: Customer.
	
	self assert: customers size equals: 2.

	self
		assertExistanceOfCustomerNamed: 'Pepe'
		withLastName: 'Sanchez'
		withIdentificationType: 'D'
		withIdentificationNumber: '22333444'.

	self 
		assertExistanceOfAddressOnStreet: 'San Martin'
		withNumber: 3322
		atTown: 'Olivos'
		withZipCode: 1636
		atProvince: 'BsAs'.
	
	self 
		assertExistanceOfAddressOnStreet: 'Maipu'
		withNumber: 888
		atTown: 'Florida'
		withZipCode: 1122
		atProvince: 'Buenos Aires'.
	
	self
		assertExistanceOfCustomerNamed: 'Juan'
		withLastName: 'Perez'
		withIdentificationType: 'C'
		withIdentificationNumber: '23-25666777-9'.
	
	self
		assertExistanceOfAddressOnStreet: 'Alem'
		withNumber: 1122
		atTown: 'CABA'
		withZipCode: 1001
		atProvince: 'CABA'.
	
	inputStream close.
! !


!ImportTest methodsFor: 'test - private' stamp: 'jcs 6/20/2024 17:38:47'!
csvDataForTest01

	^'C,Pepe,Sanchez,D,22333444
A,San Martin,3322,Olivos,1636,BsAs
A,Maipu,888,Florida,1122,Buenos Aires
C,Juan,Perez,C,23-25666777-9
A,Alem,1122,CABA,1001,CABA'! !

!ImportTest methodsFor: 'test - private' stamp: 'jcs 6/20/2024 16:39:29'!
importCustomers

	^ (CustomerDataImporter fromStream: inputStream toDatabaseSession: session) importData! !

!ImportTest methodsFor: 'test - private' stamp: 'LI 6/13/2024 21:18:39'!
setUp

	^ session := DataBaseSession for: (Array with: Address with: Customer)! !

!ImportTest methodsFor: 'test - private' stamp: 'LI 6/13/2024 21:19:18'!
tearDown

	^ session close! !


!ImportTest methodsFor: 'assertions - private' stamp: 'jcs 6/20/2024 17:28:41'!
assertExistanceOfAddressOnStreet: aStreetName withNumber: aStreetNumber atTown: aTown withZipCode: aZipCode atProvince: aProvince

	| addresses address |
	
	addresses := session
				select: [:anAddress | anAddress streetName = aStreetName]
				ofType: Address.
	
	address := addresses anyOne.
	
	self assert: address streetName equals: aStreetName.
	self assert: address streetNumber equals: aStreetNumber.
	self assert: address town equals: aTown.
	self assert: address zipCode equals: aZipCode.
	self assert: address province equals: aProvince.! !

!ImportTest methodsFor: 'assertions - private' stamp: 'jcs 6/20/2024 17:23:59'!
assertExistanceOfCustomerNamed: aFirstName withLastName: aLastName withIdentificationType: anIdentificationType withIdentificationNumber: anIdentificationNumber

	| customers customer |
	
	customers := session
				select: [:aCustomer | aCustomer firstName = aFirstName]
				ofType: Customer.
	
	customer := customers anyOne.
	
	self assert: customer firstName equals: aFirstName.
	self assert: customer lastName equals: aLastName.
	self assert: customer identificationType equals: anIdentificationType.
	self assert: customer identificationNumber equals: anIdentificationNumber.! !


!classDefinition: #Address category: #CustomerImporter!
Object subclass: #Address
	instanceVariableNames: 'id streetName streetNumber town zipCode province'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province

	^province! !

!Address methodsFor: 'province' stamp: 'HAW 5/22/2022 00:19:29'!
province: aProvince

	province := aProvince
	! !


!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName

	^streetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetName: aStreetName

	streetName := aStreetName ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber

	^streetNumber ! !

!Address methodsFor: 'street' stamp: 'HAW 5/22/2022 00:19:29'!
streetNumber: aStreetNumber

	streetNumber := aStreetNumber ! !


!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town

	^town! !

!Address methodsFor: 'twon' stamp: 'HAW 5/22/2022 00:19:29'!
town: aTown

	town := aTown! !


!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode

	^zipCode! !

!Address methodsFor: 'zip code' stamp: 'HAW 5/22/2022 00:19:29'!
zipCode: aZipCode

	zipCode := aZipCode! !


!classDefinition: #Customer category: #CustomerImporter!
Object subclass: #Customer
	instanceVariableNames: 'id firstName lastName identificationType identificationNumber addresses'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addAddress: anAddress

	addresses add: anAddress ! !

!Customer methodsFor: 'addresses' stamp: 'HAW 5/22/2022 00:19:29'!
addresses

	^ addresses! !


!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName

	^firstName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
firstName: aName

	firstName := aName! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName

	^lastName ! !

!Customer methodsFor: 'name' stamp: 'HAW 5/22/2022 00:19:29'!
lastName: aLastName

	lastName := aLastName
! !


!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber

	^identificationNumber ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationNumber: anIdentificationNumber

	identificationNumber := anIdentificationNumber! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType

	^identificationType ! !

!Customer methodsFor: 'identification' stamp: 'HAW 5/22/2022 00:19:29'!
identificationType: anIdentificationType

	identificationType := anIdentificationType! !


!Customer methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:25:42'!
initialize

	super initialize.
	addresses := Set new.! !


!classDefinition: #CustomerDataImporter category: #CustomerImporter!
Object subclass: #CustomerDataImporter
	instanceVariableNames: 'session inputStream newCustomer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!CustomerDataImporter methodsFor: 'initialization' stamp: 'jcs 6/20/2024 16:37:32'!
initializeFromStream: anInputStream toDatabaseSession: aSession
	session := aSession.
	inputStream := anInputStream.! !


!CustomerDataImporter methodsFor: 'evaluating' stamp: 'jcs 6/20/2024 16:49:18'!
importAddressRecord: anAddressRecord

	| addressData newAddress |
			addressData := anAddressRecord findTokens: $,.
			newAddress := Address new.
			newCustomer addAddress: newAddress.
			newAddress streetName: addressData second.
			newAddress streetNumber: addressData third asNumber .
			newAddress town: addressData fourth.
			newAddress zipCode: addressData fifth asNumber .
			newAddress province: addressData sixth! !

!CustomerDataImporter methodsFor: 'evaluating' stamp: 'jcs 6/20/2024 16:46:09'!
importCustomerRecord: aCustomerRecord

	| customerData  |
			customerData := aCustomerRecord findTokens: $,.
			newCustomer := Customer new.
			newCustomer firstName: customerData second.
			newCustomer lastName: customerData third.
			newCustomer identificationType: customerData fourth.
			newCustomer identificationNumber: customerData fifth.
			session persist: newCustomer! !

!CustomerDataImporter methodsFor: 'evaluating' stamp: 'jcs 6/20/2024 16:54:57'!
importData

	session beginTransaction.

	self recordsDo: [:aRecord | self importRecord: aRecord ].

	session commit.
	! !

!CustomerDataImporter methodsFor: 'evaluating' stamp: 'jcs 6/20/2024 16:52:19'!
importRecord: aRecord

	(self isCustomerRecord: aRecord) ifTrue: [ self importCustomerRecord: aRecord ].

		(self isAddressRecord: aRecord) ifTrue: [ self importAddressRecord: aRecord ]! !

!CustomerDataImporter methodsFor: 'evaluating' stamp: 'jcs 6/20/2024 16:51:22'!
isAddressRecord: aRecord

	^ aRecord beginsWith: 'A'! !

!CustomerDataImporter methodsFor: 'evaluating' stamp: 'jcs 6/20/2024 16:50:18'!
isCustomerRecord: aRecord

	^ aRecord beginsWith: 'C'! !


!CustomerDataImporter methodsFor: 'as yet unclassified' stamp: 'jcs 6/20/2024 16:54:20'!
recordsDo: aClosureToEvaluateOnEachRecord

	| line |

	line := inputStream nextLine.
	[ line notNil ] whileTrue: [
		aClosureToEvaluateOnEachRecord value: line.
		line := inputStream nextLine. ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerDataImporter class' category: #CustomerImporter!
CustomerDataImporter class
	instanceVariableNames: ''!

!CustomerDataImporter class methodsFor: 'instance creation' stamp: 'jcs 6/20/2024 16:37:32'!
fromStream: anInputStream toDatabaseSession: aSession
	^self new initializeFromStream: anInputStream toDatabaseSession: aSession! !


!classDefinition: #DataBaseSession category: #CustomerImporter!
Object subclass: #DataBaseSession
	instanceVariableNames: 'configuration tables id inTransaction closed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CustomerImporter'!

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:25'!
beginTransaction

	inTransaction := true.! !

!DataBaseSession methodsFor: 'transaction management' stamp: 'HAW 11/14/2023 08:52:18'!
commit

	inTransaction := false.! !


!DataBaseSession methodsFor: 'closing' stamp: 'HAW 11/14/2023 08:52:30'!
close

	closed := true.! !


!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:49:30'!
assertCanUseDatabase

	self assertIsOpen.
	self assertInTransaction ! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:43'!
assertInTransaction

	inTransaction ifFalse: [ self error: 'Not in transaction' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:48:16'!
assertIsOpen

	closed ifTrue: [ self error: 'Connection with database closed' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:09:07'!
assertTypeIsPersisted: aType

	(configuration includes: aType) ifFalse: [ self error: 'Object of type ', aType name, ' are not configured to be persisted' ].! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
defineIdOf: anObject

	anObject instVarNamed: 'id' put: (self newIdFor: anObject).! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 5/22/2022 00:19:29'!
delay

	(Delay forMilliseconds: 100) wait! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
isRelationToPersist: possibleRelation

	^ possibleRelation class = Set! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:59'!
persistPossibleRelationOf: anObject at: anInstVarOffset

	| possibleRelation |
		
	possibleRelation := anObject instVarAt: anInstVarOffset.
	(self isRelationToPersist: possibleRelation) ifTrue: [ self persistRelationOf: anObject at: anInstVarOffset with: possibleRelation ]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:03'!
persistRelationOf: anObject at: anInstVarOffset with: aRelation

	| persistentRelation |
	
	persistentRelation := PersistentSet on: self from: aRelation.
	anObject instVarAt: anInstVarOffset put: persistentRelation! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 08:58:34'!
persistRelationsOf: anObject

	anObject class instVarNamesAndOffsetsDo: [ :anInstVarName :anInstVarOffset | self persistPossibleRelationOf: anObject at: anInstVarOffset]! !

!DataBaseSession methodsFor: 'persistence - private' stamp: 'HAW 11/14/2023 09:06:24'!
tableOfType: aType

	^ tables at: aType ifAbsentPut: [ Set new ]! !


!DataBaseSession methodsFor: 'initialization' stamp: 'HAW 11/14/2023 08:44:19'!
initializeFor: aConfiguration

	configuration := aConfiguration.
	tables := Dictionary new.
	id := 0.
	inTransaction := false.
	closed := false.! !


!DataBaseSession methodsFor: 'id' stamp: 'HAW 5/22/2022 00:19:29'!
newIdFor: anObject

	id := id + 1.
	^id! !


!DataBaseSession methodsFor: 'persistance' stamp: 'HAW 11/14/2023 09:06:24'!
persist: anObject

	| table |

	self assertCanUseDatabase.
	self assertTypeIsPersisted: anObject class.
	self delay.
	
	table := self tableOfType: anObject class.
	self defineIdOf: anObject.
	table add: anObject.
	self persistRelationsOf: anObject.
! !


!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:06:56'!
select: aCondition ofType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) select: aCondition ! !

!DataBaseSession methodsFor: 'selecting' stamp: 'HAW 11/14/2023 09:07:12'!
selectAllOfType: aType

	self assertCanUseDatabase.
	self assertTypeIsPersisted: aType.
	self delay.
	
	^(self tableOfType: aType) copy ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'DataBaseSession class' category: #CustomerImporter!
DataBaseSession class
	instanceVariableNames: ''!

!DataBaseSession class methodsFor: 'instance creation' stamp: 'HAW 5/22/2022 00:19:29'!
for: aConfiguration

	^self new initializeFor: aConfiguration! !
