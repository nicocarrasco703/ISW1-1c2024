!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:35'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: self itemSellByTheStore withOcurrences: 0  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:46'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add:  self itemNotSellByTheStore withOcurrences: 2  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HAW 11/2/2023 17:12:59'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore withOcurrences: 2.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HAW 6/3/2024 21:37:37'!
defaultCatalog

	| priceCatalog |
	
	priceCatalog := Dictionary new.
	priceCatalog add: (self itemSellByTheStore)->1.
	^priceCatalog ! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'jcs 6/5/2024 19:59:55'!
test01CashierCanNotCheckoutEmptyCart

	| aCashier emptyCart aCreditCard |
	
	aCashier := self defaultCashier.
	emptyCart := self defaultCart.
	aCreditCard := CreditCard 
		withNumber: MerchantProcessorSimulator validCardNumber 
		ownerName: 'Leonel Braginski'
		expiringOn: self oneYearFromNow.
	
	self
		should: [ aCashier checkoutCart: emptyCart withCreditCard: aCreditCard]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: (anError messageText) equals: Cashier errorCanNotCheckoutEmptyCart.] ! !

!CashierTest methodsFor: 'tests' stamp: 'jcs 6/5/2024 20:00:13'!
test02CashierSuccesfullyChecksOutCartWithSingleItem

	| aCashier aCart aCreditCard bill |
	
	aCashier := self defaultCashier.
	aCart := self defaultCart.
	aCart add: '0000000000000'.
		aCreditCard := CreditCard 
		withNumber: MerchantProcessorSimulator validCardNumber 
		ownerName: 'Leonel Braginski'
		expiringOn: self oneYearFromNow.
	bill := aCashier checkoutCart: aCart withCreditCard: aCreditCard.
	
	self assert: bill equals: 'Total: 1.'! !

!CashierTest methodsFor: 'tests' stamp: 'jcs 6/5/2024 20:00:18'!
test03CashierSuccesfullyChecksOutCartWithMultipleItems

	| aCashier aCart aCreditCard bill |
	
	aCashier := self defaultCashier.
	aCart := self defaultCart.
	aCart add: '0000000000000'.
	aCart add: '0000000000001'.
		aCreditCard := CreditCard 
		withNumber: MerchantProcessorSimulator validCardNumber 
		ownerName: 'Leonel Braginski'
		expiringOn: self oneYearFromNow.
	bill := aCashier checkoutCart: aCart withCreditCard: aCreditCard.
	
	self assert: bill equals: 'Total: 3.'! !

!CashierTest methodsFor: 'tests' stamp: 'jcs 6/5/2024 20:00:23'!
test04CashierCanNotCheckoutWithExpiredCard
	| aCashier aCart aCreditCard |
	
	aCashier := self defaultCashier.
	aCart := self defaultCart.
	aCart add: '0000000000000'.
		aCreditCard := CreditCard 
		withNumber: MerchantProcessorSimulator validCardNumber 
		ownerName: 'Leonel Braginski'
		expiringOn: self oneYearBeforeToday.
	
	self
		should: [aCashier checkoutCart: aCart withCreditCard: aCreditCard]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: (anError messageText) equals: Cashier errorCanNotCheckoutExpiredCard .] ! !

!CashierTest methodsFor: 'tests' stamp: 'jcs 6/5/2024 20:00:29'!
test05CashierCanNotCheckoutStolenCard
	| aCashier aCart aCreditCard |
	
	aCashier := self defaultCashier.
	aCart := self defaultCart.
	aCart add: '0000000000000'.
	aCreditCard := CreditCard
		withNumber: MerchantProcessorSimulator stolenCardNumber
		ownerName: 'Leonel Braginski'
		expiringOn: self oneYearFromNow.
	
	self
		should: [aCashier checkoutCart: aCart withCreditCard: aCreditCard]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: (anError messageText) equals: MerchantProcessorSimulator errorCreditCardInvalid .] ! !

!CashierTest methodsFor: 'tests' stamp: 'jcs 6/5/2024 20:00:33'!
test06CashierCanNotCheckoutCardWithoutSufficientBalance
	| aCashier aCart aCreditCard |
	
	aCashier := self defaultCashier.
	aCart := self defaultCart.
	aCart add: '0000000000000'.
	aCreditCard := CreditCard
		withNumber: MerchantProcessorSimulator noBalanceCardNumber 
		ownerName: 'Leonel Braginski'
		expiringOn: self oneYearFromNow.
	
	self
		should: [aCashier checkoutCart: aCart withCreditCard: aCreditCard]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError |
			self assert: (anError messageText) equals: MerchantProcessorSimulator errorCreditHasNotEnoughBalance .] ! !


!CashierTest methodsFor: 'tests private' stamp: 'jcs 6/5/2024 19:59:55'!
defaultCart

	^ Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'tests private' stamp: 'jcs 6/5/2024 19:59:36'!
defaultCashier

	^ Cashier withCatalog: self defaultCatalog withCardProcessor: MerchantProcessorSimulator new! !

!CashierTest methodsFor: 'tests private' stamp: 'HAW 6/3/2024 21:36:53'!
defaultCatalog

	| priceCatalog |
	
	priceCatalog := Dictionary new.
	priceCatalog add: '0000000000000'->1; add: '0000000000001'->2; add: '0000000000002'->3; yourself.
	^priceCatalog ! !

!CashierTest methodsFor: 'tests private' stamp: 'HAW 6/3/2024 21:28:50'!
itemNotSoldByStore

	^'0000000000003'! !

!CashierTest methodsFor: 'tests private' stamp: 'jcs 6/5/2024 18:49:21'!
oneYearBeforeToday

	^ Date today - (Duration days: 365)! !

!CashierTest methodsFor: 'tests private' stamp: 'jcs 6/5/2024 18:23:57'!
oneYearFromNow

	^ Date today + (Duration days: 365)! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HAW 6/3/2024 21:38:01'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:30'!
add: anItem

	^ self add: anItem withOcurrences: 1 ! !

!Cart methodsFor: 'adding' stamp: 'HAW 11/2/2023 17:13:19'!
add: anItem withOcurrences: aQuantity

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'catalog merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'initialization' stamp: 'jcs 6/5/2024 19:58:46'!
initializeWithCatalog: aCatalog withCardProcessor: cardProcessor  

	catalog := aCatalog.
	merchantProcessor := cardProcessor
! !


!Cashier methodsFor: 'checkout' stamp: 'jcs 6/5/2024 19:51:45'!
checkoutCart: aCart withCreditCard: aCreditCard 
	
	| currentTally |
	
	self assertCartIsNotEmpty: aCart.
	self assertCardIsNotExpired: aCreditCard.
	
	currentTally := 0.
	catalog keysAndValuesDo: [:itemInCatalog :itemPrice | currentTally := currentTally + (aCart occurrencesOf: itemInCatalog) * itemPrice ].
	
	[merchantProcessor processPaymentOnCard: aCreditCard forAmmount: currentTally]
		on: Error - MessageNotUnderstood
		do: [:merchantProcessorError | self error: merchantProcessorError messageText].
	
	^'Total: ', currentTally asString,'.'! !


!Cashier methodsFor: 'runtime assertions' stamp: 'jcs 6/5/2024 19:55:34'!
assertCardIsNotExpired: aCreditCard

	^ (aCreditCard isExpired) ifTrue: [self error: self class errorCanNotCheckoutExpiredCard]! !

!Cashier methodsFor: 'runtime assertions' stamp: 'jcs 6/5/2024 19:55:50'!
assertCartIsNotEmpty: aCart

	^ (aCart isEmpty) ifTrue: [self error: self class errorCanNotCheckoutEmptyCart]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'as yet unclassified' stamp: 'HAW 6/3/2024 21:21:12'!
errorCanNotCheckoutEmptyCart

	^ 'Can not checkout empty cart.'! !

!Cashier class methodsFor: 'as yet unclassified' stamp: 'jcs 6/5/2024 18:50:48'!
errorCanNotCheckoutExpiredCard

	^ 'Your credit card is expired.'! !


!Cashier class methodsFor: 'instance creation' stamp: 'jcs 6/5/2024 19:58:56'!
withCatalog: aCatalog withCardProcessor: cardProcessor  

	^self new initializeWithCatalog: aCatalog withCardProcessor: cardProcessor ! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiryDate name cardNumber'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'initialization' stamp: 'jcs 6/5/2024 19:09:38'!
initializeWithNumber: aCreditCardNumber ownerName: ownerName expiringOn: aDate 
	
	cardNumber := aCreditCardNumber.
	name := ownerName.
	expiryDate := aDate! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'jcs 6/5/2024 19:22:45'!
cardNumber

	^cardNumber! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'jcs 6/5/2024 19:32:49'!
isExpired
	
	^expiryDate < (Date today)! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'jcs 6/5/2024 19:32:29'!
withNumber: aCreditCardNumber ownerName: ownerName expiringOn: aDate

	^self new initializeWithNumber: aCreditCardNumber ownerName: ownerName expiringOn: aDate 
! !


!classDefinition: #MerchantProcessorSimulator category: #TusLibros!
Object subclass: #MerchantProcessorSimulator
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorSimulator methodsFor: 'as yet unclassified' stamp: 'jcs 6/5/2024 19:39:22'!
processPaymentOnCard: aCreditCard forAmmount: ammountToCharge

	(aCreditCard isExpired) ifTrue: [self error: self class errorCreditCardInvalid].
	(aCreditCard cardNumber = self class stolenCardNumber) ifTrue: [self error: self class errorCreditCardInvalid].
	(aCreditCard cardNumber = self class noBalanceCardNumber) ifTrue: [self error: self class errorCreditHasNotEnoughBalance].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorSimulator class' category: #TusLibros!
MerchantProcessorSimulator class
	instanceVariableNames: ''!

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'jcs 6/5/2024 19:21:28'!
errorCreditCardInvalid

	^'This credit card is invalid'! !

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'jcs 6/5/2024 19:38:48'!
errorCreditHasNotEnoughBalance

	^'This credit card does not have enough balance.'! !

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'jcs 6/5/2024 19:38:10'!
noBalanceCardNumber

	^ '0000000000000002'! !

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'jcs 6/5/2024 19:37:25'!
stolenCardNumber

	^ '0000000000000001'! !

!MerchantProcessorSimulator class methodsFor: 'as yet unclassified' stamp: 'jcs 6/5/2024 19:29:44'!
validCardNumber

	^ '0000000000000000'! !
