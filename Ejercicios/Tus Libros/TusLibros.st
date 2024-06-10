!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosRestInterfaceTest category: #TusLibros!
TestCase subclass: #TusLibrosRestInterfaceTest
	instanceVariableNames: 'testObjectsFactory authenticatorBehaviour currentDate debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'jcs 6/9/2024 17:45:49'!
test01CreateCartWithValidUserAndPassword

	| tusLibrosRestInterface cartId cartContents |
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
	cartContents := Bag new.
	cartId := tusLibrosRestInterface createCartForClientId: testObjectsFactory validClientId andPassword: testObjectsFactory validPassword.
	
	self assert: (tusLibrosRestInterface listCart: cartId) equals: cartContents.
	! !

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'jcs 6/9/2024 18:04:04'!
test02CanNotCreateCartWithInvalidUserCredentials

	| tusLibrosRestInterface |
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
	
	self
		should: [tusLibrosRestInterface createCartForClientId: testObjectsFactory invalidClientId andPassword: testObjectsFactory invalidPassword]
		raise: Error - MessageNotUnderstood 
		withMessageText: [TusLibrosRestInterface errorInvalidCredentials]
	
	
		
	! !

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'jcs 6/9/2024 17:50:54'!
test03ListCartContainingSingleItem

	| tusLibrosRestInterface cartId expectedCartContens |
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
	expectedCartContens := Bag with: testObjectsFactory itemSellByTheStore with: testObjectsFactory itemSellByTheStore.
	cartId := tusLibrosRestInterface createCartForClientId: testObjectsFactory validClientId andPassword: testObjectsFactory validPassword.
	tusLibrosRestInterface addToCart: cartId bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 2.
	
	self assert: (tusLibrosRestInterface listCart: cartId) equals: expectedCartContens
	! !

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'jcs 6/9/2024 17:54:11'!
test04ListCartContainingMultipleItems

	| tusLibrosRestInterface cartId listCartResponse expectedCartItems |
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
	
	cartId := tusLibrosRestInterface createCartForClientId: testObjectsFactory validClientId andPassword: testObjectsFactory validPassword.
	
	expectedCartItems := Bag with: testObjectsFactory itemSellByTheStore with: testObjectsFactory anotherItemSellByTheStore.
	
	tusLibrosRestInterface addToCart: cartId bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 1.
	tusLibrosRestInterface addToCart: cartId bookIsbn: testObjectsFactory anotherItemSellByTheStore bookQuantity: 1.
	
	listCartResponse := tusLibrosRestInterface listCart: cartId.
	
	self assert: listCartResponse equals: expectedCartItems
! !

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'jcs 6/9/2024 18:03:51'!
test05CanNotAddItemsToInvalidCartId

	| tusLibrosRestInterface |
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
		
	self
		should: [tusLibrosRestInterface addToCart: 1 bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 2]
		raise: Error - MessageNotUnderstood 
		withMessageText: [TusLibrosRestInterface errorInvalidCartId]
	! !

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'jcs 6/9/2024 18:03:37'!
test06CanNotListItemsFromInvalidCartId

	| tusLibrosRestInterface |
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
	
	self
		should: [tusLibrosRestInterface listCart: 1]
		raise: Error - MessageNotUnderstood 
		withMessageText: [TusLibrosRestInterface errorInvalidCartId]
			! !

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'jcs 6/9/2024 18:12:00'!
test07TwoUsersHaveIndependentCarts

	| tusLibrosRestInterface user1CartId user2CartId user1ExpectedCartContents user2ExpectedCartContents |
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
	
	authenticatorBehaviour := [:userId :password | true]							.
	
	user1ExpectedCartContents := Bag with: testObjectsFactory itemSellByTheStore with: testObjectsFactory itemSellByTheStore.
	user2ExpectedCartContents := Bag with: testObjectsFactory anotherItemSellByTheStore.
	
	user1CartId := tusLibrosRestInterface createCartForClientId: 1 andPassword: testObjectsFactory validPassword.
	user2CartId := tusLibrosRestInterface createCartForClientId: 2 andPassword: testObjectsFactory validPassword.
	
	tusLibrosRestInterface addToCart: user1CartId bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 2.
	tusLibrosRestInterface addToCart: user2CartId bookIsbn: testObjectsFactory anotherItemSellByTheStore bookQuantity: 1.
	
	self assert: (tusLibrosRestInterface listCart: user1CartId) equals: user1ExpectedCartContents.
	self assert: (tusLibrosRestInterface listCart: user2CartId ) equals: user2ExpectedCartContents .! !

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'jcs 6/9/2024 18:20:15'!
test08UserCanNotCreateMultipleCarts

	| tusLibrosRestInterface |
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
	
	tusLibrosRestInterface createCartForClientId: testObjectsFactory validClientId andPassword: testObjectsFactory validPassword.
	
	self
		should: [tusLibrosRestInterface createCartForClientId: testObjectsFactory validClientId andPassword: testObjectsFactory validPassword]
		raise: Error - MessageNotUnderstood
		withMessageText: [TusLibrosRestInterface errorUserCanNotCreateMoreThanOneCart]
	
! !

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'jcs 6/9/2024 19:52:59'!
test09CartExpiresAfter30Minutes

	| tusLibrosRestInterface cartId |
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
	
	currentDate := DateAndTime year: 2018 month: 12 day: 9 hour: 8 minute: 0.
	
	cartId := tusLibrosRestInterface createCartForClientId: testObjectsFactory validClientId andPassword: testObjectsFactory validPassword.
	
	currentDate := DateAndTime year: 2018 month: 12 day: 9 hour: 8 minute: 31.

	self
		should: [tusLibrosRestInterface addToCart: cartId bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 2]
		raise: Error - MessageNotUnderstood 
		withMessageText: [TusLibrosRestInterface errorInvalidCartId].

	self
		should: [tusLibrosRestInterface listCart: cartId]
		raise: Error - MessageNotUnderstood 
		withMessageText: [TusLibrosRestInterface errorInvalidCartId].
		! !

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'jcs 6/9/2024 20:41:39'!
test10ListingItemsResetsCartTimeToLive

	| tusLibrosRestInterface cartId |
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
	
	currentDate := DateAndTime year: 2018 month: 12 day: 9 hour: 8 minute: 0.
	cartId := tusLibrosRestInterface createCartForClientId: testObjectsFactory validClientId andPassword: testObjectsFactory validPassword.
	
	currentDate := DateAndTime year: 2018 month: 12 day: 9 hour: 8 minute: 20.
	tusLibrosRestInterface listCart: cartId.
	
	currentDate := DateAndTime year: 2018 month: 12 day: 9 hour: 8 minute: 40.
	tusLibrosRestInterface listCart: cartId! !

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'jcs 6/9/2024 20:42:02'!
test11AddingItemsResetsCartTimeToLive

	| tusLibrosRestInterface cartId expectedCartContens |
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
	expectedCartContens := Bag with: testObjectsFactory itemSellByTheStore with: testObjectsFactory itemSellByTheStore.

	
	currentDate := DateAndTime year: 2018 month: 12 day: 9 hour: 8 minute: 0.
	cartId := tusLibrosRestInterface createCartForClientId: testObjectsFactory validClientId andPassword: testObjectsFactory validPassword.
	
	currentDate := DateAndTime year: 2018 month: 12 day: 9 hour: 8 minute: 20.
	tusLibrosRestInterface addToCart: cartId bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 1.
	
	currentDate := DateAndTime year: 2018 month: 12 day: 9 hour: 8 minute: 40.
	tusLibrosRestInterface addToCart: cartId bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 1.
	
	self assert: (tusLibrosRestInterface listCart: cartId) equals: expectedCartContens 
! !

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'NC 6/10/2024 15:40:09'!
test12CanNotCheckoutExpiredCart

	| tusLibrosRestInterface cartId salesBook |
	
	salesBook := OrderedCollection new.
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
								
	currentDate := DateAndTime year: 2018 month: 12 day: 9 hour: 8 minute: 0.
	
	cartId := tusLibrosRestInterface createCartForClientId: testObjectsFactory validClientId andPassword: testObjectsFactory validPassword.
	tusLibrosRestInterface addToCart: cartId bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 2.
	
	currentDate := DateAndTime year: 2018 month: 12 day: 9 hour: 8 minute: 31.

	self
		should: [	tusLibrosRestInterface checkoutCartWithID: cartId
							payingWithCCN: testObjectsFactory validCreditCardNumber 
							CCED: testObjectsFactory validCreditCardED 
							CCO: testObjectsFactory validCreditCardOwner ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosRestInterface errorInvalidCartId.
			self assert: salesBook isEmpty ]

! !

!TusLibrosRestInterfaceTest methodsFor: 'tests' stamp: 'NC 6/10/2024 16:42:41'!
test13CartIsDeletedAfterCheckout

	| tusLibrosRestInterface cartId |
	
	tusLibrosRestInterface := TusLibrosRestInterface 
								withCatalog: testObjectsFactory defaultCatalog
								withPaymentProcessor: self
								withTimekeeping: self
								withAuthenticator: self.
	
	cartId := tusLibrosRestInterface createCartForClientId: testObjectsFactory validClientId andPassword: testObjectsFactory validPassword.
	
	tusLibrosRestInterface addToCart: cartId bookIsbn: testObjectsFactory itemSellByTheStore bookQuantity: 1.

	tusLibrosRestInterface checkoutCartWithID: cartId
							payingWithCCN: testObjectsFactory validCreditCardNumber 
							CCED: testObjectsFactory validCreditCardED 
							CCO: testObjectsFactory validCreditCardOwner.
							
	self
		should: [tusLibrosRestInterface listCart: cartId]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosRestInterface errorInvalidCartId.
			]

! !


!TusLibrosRestInterfaceTest methodsFor: 'setUp' stamp: 'NC 6/10/2024 11:57:16'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	authenticatorBehaviour := [:userId :password | 
		((userId = testObjectsFactory validClientId) and: (password = testObjectsFactory validPassword))].
	currentDate := DateAndTime now.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!TusLibrosRestInterfaceTest methodsFor: 'simulation messages' stamp: 'NC 6/10/2024 11:57:41'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!TusLibrosRestInterfaceTest methodsFor: 'simulation messages' stamp: 'jcs 6/9/2024 16:02:43'!
isRegisteredWithId: aClientId andPassword: aPassword

	^authenticatorBehaviour value: aClientId value: aPassword! !

!TusLibrosRestInterfaceTest methodsFor: 'simulation messages' stamp: 'jcs 6/9/2024 19:43:17'!
now

	^currentDate! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'jcs 6/9/2024 16:25:39'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'jcs 6/9/2024 16:34:39'!
items

	^items copy! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'jcs 6/9/2024 16:26:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration owner number'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

!CreditCard methodsFor: 'initialization' stamp: 'NC 6/10/2024 11:53:46'!
initializeExpiringOn: aMonth withNumber: aCCNumber withOwner: anOwnerName
	
	expiration := aMonth.
	owner := anOwnerName.
	number := aCCNumber ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !

!CreditCard class methodsFor: 'instance creation' stamp: 'NC 6/10/2024 11:54:39'!
expiringOn: aMonth withNumber: aCCNumber withOwner: anOwnerName
	
	^self new initializeExpiringOn: aMonth withNumber: aCCNumber withOwner: anOwnerName! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'jcs 6/9/2024 17:21:25'!
anotherItemSellByTheStore
	
	^ 'anotherValidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'jcs 6/9/2024 17:21:43'!
anotherItemSellByTheStorePrice
	
	^100! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'jcs 6/9/2024 17:22:02'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'NC 6/10/2024 16:20:27'!
validCreditCardED
	
	^ Month month: today monthIndex year: today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'NC 6/10/2024 12:32:10'!
validCreditCardNumber
	
	^'0000 0000 0000 0000'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'NC 6/10/2024 12:32:02'!
validCreditCardOwner
	
	^'Leonel Braginski'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'client information' stamp: 'jcs 6/9/2024 15:51:02'!
invalidClientId

	^420! !

!StoreTestObjectsFactory methodsFor: 'client information' stamp: 'jcs 6/9/2024 15:50:51'!
invalidPassword

	^'blackjack'! !

!StoreTestObjectsFactory methodsFor: 'client information' stamp: 'HAW 6/6/2024 21:40:35'!
validClientId

	^1! !

!StoreTestObjectsFactory methodsFor: 'client information' stamp: 'HAW 6/6/2024 21:41:03'!
validPassword

	^'casino'! !


!classDefinition: #TusLibrosRestInterface category: #TusLibros!
Object subclass: #TusLibrosRestInterface
	instanceVariableNames: 'catalog paymentProcessor time authenticator userTracker clientsSalesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosRestInterface methodsFor: 'initialization' stamp: 'NC 6/10/2024 15:49:47'!
initializeWithCatalog: aCatalog withPaymentProcessor: aPaymentProcessor withTimekeeping: aTimekeepingObject withAuthenticator: anAuthenticationPlatform

	catalog := aCatalog.
	paymentProcessor := aPaymentProcessor.
	time := aTimekeepingObject.
	authenticator := anAuthenticationPlatform.
	userTracker := UserTracker new.
	clientsSalesBook := Dictionary new.! !


!TusLibrosRestInterface methodsFor: 'runtime assertions' stamp: 'jcs 6/9/2024 18:48:44'!
assertCartIdIsStillValid: aCartId! !

!TusLibrosRestInterface methodsFor: 'runtime assertions' stamp: 'jcs 6/9/2024 19:34:09'!
assertUserDoesNotHaveActiveCart: aClientId

	(userTracker isUserActive: aClientId) ifTrue: [self error: self class errorUserCanNotCreateMoreThanOneCart].! !

!TusLibrosRestInterface methodsFor: 'runtime assertions' stamp: 'jcs 6/9/2024 17:56:20'!
authenticateClientId: aClientId andPassword: aPassword

	(authenticator isRegisteredWithId: aClientId andPassword: aPassword)
		ifFalse: [self error: self class errorInvalidCredentials]! !


!TusLibrosRestInterface methodsFor: 'rest interface' stamp: 'NC 6/10/2024 12:44:08'!
addToCart: aCartId bookIsbn: aBookIsbn bookQuantity: aBookQuantity 
	
	| aCart |
	
	aCart := self cartAssociatedToId: aCartId.
	aCart add: aBookQuantity of: aBookIsbn.
	userTracker setLastUsedTime: time now forCartWithId: aCartId.

	! !

!TusLibrosRestInterface methodsFor: 'rest interface' stamp: 'NC 6/10/2024 16:34:53'!
checkoutCartWithID: aCartID payingWithCCN: aCCNumber CCED: anExpirationDate CCO: anOwnerName

	| creditCard cashier cart clientID total|
	
	creditCard := CreditCard expiringOn: anExpirationDate withNumber: aCCNumber withOwner: anOwnerName.
	cart := self cartAssociatedToId: aCartID.
	clientID := self clientIDAssociatedToCart: aCartID.
	cashier :=  Cashier
		toCheckout: cart 
		charging: creditCard
		throught: paymentProcessor 
		on: time now
		registeringOn: OrderedCollection new.
		
	total := cashier checkOut.
	self registerSaleForClient: clientID forAmmount: total andItemsOf: cart.

	userTracker deleteCart: aCartID.! !

!TusLibrosRestInterface methodsFor: 'rest interface' stamp: 'jcs 6/9/2024 19:43:55'!
createCartForClientId: clientId andPassword: password 
	
	| newCart newCartId |
	
	self authenticateClientId: clientId andPassword: password.
	userTracker removeExpiredCartsWithDate: time now.
	self assertUserDoesNotHaveActiveCart: clientId.
	
	newCart := Cart acceptingItemsOf: catalog.
	newCartId := userTracker generateIdForCart: newCart associatedToClient: clientId withLastActivityOn: time now.
	^newCartId! !

!TusLibrosRestInterface methodsFor: 'rest interface' stamp: 'NC 6/10/2024 12:44:15'!
listCart: aCartId
	
	| aCart |

	aCart := self cartAssociatedToId: aCartId.
	userTracker setLastUsedTime: time now forCartWithId: aCartId.
	^aCart items! !


!TusLibrosRestInterface methodsFor: 'private' stamp: 'NC 6/10/2024 15:58:19'!
cartAssociatedToId: aCartId
	
	| aCart |
	
	userTracker removeExpiredCartsWithDate: time now.

	[aCart := userTracker cartAssociatedToId: aCartId]
		on: Error
		do: [self error: self class errorInvalidCartId].
	
	^aCart! !

!TusLibrosRestInterface methodsFor: 'private' stamp: 'NC 6/10/2024 16:02:00'!
clientIDAssociatedToCart: aCartId
	
	^ userTracker clientIDAssociatedToCart: aCartId! !

!TusLibrosRestInterface methodsFor: 'private' stamp: 'NC 6/10/2024 16:22:58'!
registerSaleForClient: clientID 
	self shouldBeImplemented.! !

!TusLibrosRestInterface methodsFor: 'private' stamp: 'NC 6/10/2024 16:32:16'!
registerSaleForClient: clientID forAmmount: aTotalAmmount andItemsOf: aCart

	| purchasedItems |
	
	purchasedItems := Bag new .
	purchasedItems addAll: aCart items.
	
	clientsSalesBook add: clientID->(Array with: purchasedItems with: aTotalAmmount)
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestInterface class' category: #TusLibros!
TusLibrosRestInterface class
	instanceVariableNames: ''!

!TusLibrosRestInterface class methodsFor: 'error descriptions' stamp: 'jcs 6/9/2024 16:39:20'!
errorInvalidCartId

	^'Invalid cart id'! !

!TusLibrosRestInterface class methodsFor: 'error descriptions' stamp: 'jcs 6/9/2024 16:39:06'!
errorInvalidCredentials
	
	^'Invalid user credentials'! !

!TusLibrosRestInterface class methodsFor: 'error descriptions' stamp: 'jcs 6/9/2024 18:17:00'!
errorUserCanNotCreateMoreThanOneCart

	^'User can not create more than one cart'! !


!TusLibrosRestInterface class methodsFor: 'instance creation' stamp: 'jcs 6/6/2024 23:05:47'!
withCatalog: aCatalog withPaymentProcessor: aPaymentProcessor withTimekeeping: aTimekeepingObject withAuthenticator: anAunthenticationPlatform

	^self new initializeWithCatalog: aCatalog withPaymentProcessor: aPaymentProcessor withTimekeeping: aTimekeepingObject withAuthenticator: anAunthenticationPlatform! !


!classDefinition: #UserTracker category: #TusLibros!
Object subclass: #UserTracker
	instanceVariableNames: 'cartIdAssociatedToUser cartAssociatedToId lastRegisteredActivityForCartId nextCartId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!UserTracker methodsFor: 'initialization' stamp: 'jcs 6/9/2024 19:12:17'!
initialize
	
	cartIdAssociatedToUser := Dictionary new.
	cartAssociatedToId := Dictionary new.
	lastRegisteredActivityForCartId := Dictionary new.
	nextCartId := 0.! !


!UserTracker methodsFor: 'private' stamp: 'jcs 6/9/2024 19:00:12'!
newCartId

	| newCartId |
	
	newCartId := nextCartId.
	nextCartId := nextCartId + 1.
	^newCartId! !


!UserTracker methodsFor: 'user managment' stamp: 'jcs 6/9/2024 18:56:05'!
cartAssociatedToId: aCartId

	^cartAssociatedToId at: aCartId! !

!UserTracker methodsFor: 'user managment' stamp: 'NC 6/10/2024 16:00:48'!
clientIDAssociatedToCart: aCartId

	^cartIdAssociatedToUser at: aCartId! !

!UserTracker methodsFor: 'user managment' stamp: 'NC 6/10/2024 16:35:42'!
deleteCart: aCartID

	lastRegisteredActivityForCartId removeKey: aCartID.
	cartAssociatedToId removeKey: aCartID.
	cartIdAssociatedToUser removeKey: aCartID.! !

!UserTracker methodsFor: 'user managment' stamp: 'jcs 6/9/2024 19:11:50'!
generateIdForCart: aCart associatedToClient: aClientId withLastActivityOn: aDate

	| newCartId |
	
	newCartId := self newCartId.
	cartAssociatedToId add: newCartId->aCart.
	lastRegisteredActivityForCartId add: newCartId->aDate.
	cartIdAssociatedToUser add: newCartId->aClientId.
	^newCartId! !

!UserTracker methodsFor: 'user managment' stamp: 'jcs 6/9/2024 19:48:37'!
isUserActive: aClientId

	^cartIdAssociatedToUser includes: aClientId! !

!UserTracker methodsFor: 'user managment' stamp: 'jcs 6/9/2024 19:13:29'!
lastActivityForCartWithId: aCartId

	^lastRegisteredActivityForCartId at: aCartId! !

!UserTracker methodsFor: 'user managment' stamp: 'jcs 6/9/2024 19:46:15'!
removeExpiredCartsWithDate: aDate

	| cartIdsToBeDeleted |
	
	cartIdsToBeDeleted := Set new.
	
	lastRegisteredActivityForCartId keysAndValuesDo: [:aCartId :lastActivity | 
		((aDate - lastActivity) > (Duration minutes: 30)) ifTrue: [cartIdsToBeDeleted add: aCartId]].
	
	cartIdsToBeDeleted do: [:aCartId | 
		lastRegisteredActivityForCartId removeKey: aCartId.
		cartAssociatedToId removeKey: aCartId.
		cartIdAssociatedToUser removeKey: aCartId.
		]! !

!UserTracker methodsFor: 'user managment' stamp: 'jcs 6/9/2024 20:27:34'!
setLastUsedTime: aDate forCartWithId: aCartId

	lastRegisteredActivityForCartId at: aCartId put: aDate! !
