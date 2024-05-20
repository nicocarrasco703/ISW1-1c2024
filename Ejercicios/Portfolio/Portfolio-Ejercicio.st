!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'testing' stamp: 'jcs 5/19/2024 15:35:19'!
test01AddPortfolioToPortfolio
	
	| aPortfolio anotherPortfolio |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	aPortfolio addPortfolio: anotherPortfolio.! !

!PortfolioTest methodsFor: 'testing' stamp: 'jcs 5/19/2024 16:28:16'!
test02CanNotAddAccountTwiceToPortfolio
	
	| aPortfolio aReceptiveAccount |
	
	aPortfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	
	aPortfolio addAccount: aReceptiveAccount.
	
	self shouldFail: [aPortfolio addAccount: aReceptiveAccount ]
! !

!PortfolioTest methodsFor: 'testing' stamp: 'jcs 5/19/2024 16:28:16'!
test03CanNotAddTwoAccountsTwiceToPortfolio
	
	| aPortfolio aReceptiveAccount anotherReceptiveAccount |
	
	aPortfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	anotherReceptiveAccount := ReceptiveAccount new.
	
	aPortfolio addAccount: aReceptiveAccount.
	aPortfolio addAccount: anotherReceptiveAccount.
	
	self shouldFail: [aPortfolio addAccount: aReceptiveAccount ].
	self shouldFail: [aPortfolio addAccount: anotherReceptiveAccount ].
! !

!PortfolioTest methodsFor: 'testing' stamp: 'jcs 5/19/2024 16:28:16'!
test04CanNotAddAccountIncludedInNestedPortfolio
	
	| aPortfolio anotherPortfolio aReceptiveAccount |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	
	anotherPortfolio addAccount: aReceptiveAccount.
	aPortfolio addPortfolio: anotherPortfolio.
	
	self shouldFail: [aPortfolio addAccount: aReceptiveAccount ].
! !

!PortfolioTest methodsFor: 'testing' stamp: 'jcs 5/19/2024 16:28:16'!
test05CanNotAddPortfolioIncludedInNestedPortfolio
	
	| aPortfolio anotherPortfolio aReceptiveAccount |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	
	anotherPortfolio addAccount: aReceptiveAccount.
	aPortfolio addPortfolio: anotherPortfolio.
	
	self shouldFail: [aPortfolio addPortfolio: anotherPortfolio ].
! !

!PortfolioTest methodsFor: 'testing' stamp: 'jcs 5/19/2024 16:28:16'!
test06CanNotAddAccountIfParentContainsAccount
	
	| aPortfolio anotherPortfolio aReceptiveAccount |
	
	aPortfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	
	aPortfolio addAccount: aReceptiveAccount.
	aPortfolio addPortfolio: anotherPortfolio.
	
	self shouldFail: [anotherPortfolio addAccount: aReceptiveAccount ].
! !

!PortfolioTest methodsFor: 'testing' stamp: 'jcs 5/19/2024 16:28:16'!
test07CanNotAddAccountIfOneOfMultipleParentsContainsAccount
	
	| childPortfolio parentPortfiolio1 parentPortfolio2 aReceptiveAccount |
	
	childPortfolio := Portfolio new.
	parentPortfiolio1 := Portfolio new.
	parentPortfolio2 := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	
	parentPortfiolio1 addAccount: aReceptiveAccount.
	parentPortfiolio1 addPortfolio: childPortfolio .
	parentPortfolio2 addPortfolio: childPortfolio .
	
	self shouldFail: [childPortfolio addAccount: aReceptiveAccount ].
! !

!PortfolioTest methodsFor: 'testing' stamp: 'jcs 5/19/2024 16:55:20'!
test08CanNotAddPortfolioWhenBothParentsShareAccount
	
	| childPortfolio parentPortfiolio1 parentPortfolio2 aReceptiveAccount |
	
	childPortfolio := Portfolio new.
	parentPortfiolio1 := Portfolio new.
	parentPortfolio2 := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	
	parentPortfiolio1 addAccount: aReceptiveAccount.
	parentPortfolio2 addAccount: aReceptiveAccount.
	parentPortfiolio1 addPortfolio: childPortfolio.
	
	self shouldFail: [parentPortfolio2 addPortfolio: childPortfolio ].
! !

!PortfolioTest methodsFor: 'testing' stamp: 'jcs 5/19/2024 17:02:08'!
test09BalanceOfSingleChildAccount
	
	| aPortfolio aReceptiveAccount |
	
	aPortfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	
	aPortfolio addAccount: aReceptiveAccount.
	aReceptiveAccount register: (Deposit for: 50).
		
	self assert: (aPortfolio balance) equals: 50

! !

!PortfolioTest methodsFor: 'testing' stamp: 'jcs 5/19/2024 17:04:08'!
test10BalanceOfEmptyPortfolio
	
	| aPortfolio |
	
	aPortfolio := Portfolio new.
		
	self assert: (aPortfolio balance) equals: 0

! !

!PortfolioTest methodsFor: 'testing' stamp: 'NC 5/19/2024 20:29:05'!
test11TransactionsOfEmptyPortfolio
	
	| aPortfolio |
	
	aPortfolio := Portfolio new.
		
	self assert: (aPortfolio transactions) isEmpty

! !

!PortfolioTest methodsFor: 'testing' stamp: 'NC 5/20/2024 15:00:08'!
test12TransactionsOfPortfolioWithOneAccount
	
	| portfolio aReceptiveAccount depositTransaction accountTransactions|
	
	portfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.

	portfolio addAccount: aReceptiveAccount.
	depositTransaction := Deposit register: 100 on: aReceptiveAccount.
	accountTransactions := Bag with: depositTransaction.
		
	self assert: (portfolio transactions) equals: accountTransactions

! !

!PortfolioTest methodsFor: 'testing' stamp: 'NC 5/20/2024 15:03:05'!
test13TransactionsOfPortfolioWithMoreThanOneAccount
	
	| portfolio aReceptiveAccount_A aReceptiveAccount_B withdrawlTransaction depositTransaction allAccountsTransactions|
	
	portfolio := Portfolio new.
	aReceptiveAccount_A := ReceptiveAccount new.
	aReceptiveAccount_B := ReceptiveAccount new.

	portfolio addAccount: aReceptiveAccount_A.
	portfolio addAccount: aReceptiveAccount_B.
	
	depositTransaction := Deposit register: 100 on: aReceptiveAccount_A.
	withdrawlTransaction := Withdraw register: 50 on: aReceptiveAccount_B.
	
	allAccountsTransactions := Bag with: depositTransaction with: withdrawlTransaction.
		
	self assert: (portfolio transactions) equals: allAccountsTransactions

! !

!PortfolioTest methodsFor: 'testing' stamp: 'NC 5/20/2024 15:05:15'!
test14TransactionsOfPortfolioWithAnAccountAndAnEmptyPortfolio
	
	| aPortfolio aReceptiveAccount aNestedPortfolio aWithdrawlTransaction depositTransaction allAccountsTransactions|
	
	aPortfolio := Portfolio new.
	aReceptiveAccount := ReceptiveAccount new.
	aNestedPortfolio := Portfolio new.

	aPortfolio addAccount: aReceptiveAccount.
	aPortfolio addPortfolio: aNestedPortfolio.
	
	depositTransaction := Deposit register: 100 on: aReceptiveAccount.
	aWithdrawlTransaction := Withdraw register: 50 on: aReceptiveAccount.
	
	allAccountsTransactions := Bag with: depositTransaction with: aWithdrawlTransaction.
		
	self assert: (aPortfolio transactions) equals: allAccountsTransactions

! !

!PortfolioTest methodsFor: 'testing' stamp: 'NC 5/20/2024 15:07:36'!
test15TransactionsOfPortfolioWithAnAccountAndANestedPortfolio
	
	| aPortfolio aReceptiveAccount_A aReceptiveAccount_B aNestedPortfolio withdrawlTransaction depositTransaction allAccountsTransactions|
	
	aPortfolio := Portfolio new.
	aNestedPortfolio := Portfolio new.
	aReceptiveAccount_A := ReceptiveAccount new.
	aReceptiveAccount_B := ReceptiveAccount new.

	aPortfolio addAccount: aReceptiveAccount_A.
	aNestedPortfolio addAccount: aReceptiveAccount_B.
	aPortfolio addPortfolio: aNestedPortfolio.
	
	depositTransaction := Deposit register: 100 on: aReceptiveAccount_A.
	withdrawlTransaction := Withdraw register: 50 on: aReceptiveAccount_B.
	
	allAccountsTransactions := Bag with: depositTransaction with: withdrawlTransaction.
		
	self assert: (aPortfolio transactions) equals: allAccountsTransactions

! !

!PortfolioTest methodsFor: 'testing' stamp: 'NC 5/20/2024 15:13:31'!
test16PortfolioWithOneAccountHasRegisteredATransaction

	| portfolio receptiveAccount depositTransaction|
	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.

	portfolio addAccount: receptiveAccount.
	
	depositTransaction := Deposit register: 100 on: receptiveAccount.

	self assert: (portfolio hasRegistered: depositTransaction)

! !

!PortfolioTest methodsFor: 'testing' stamp: 'NC 5/20/2024 15:18:38'!
test17PortfolioWithMoreThanOneAccountHasRegisteredAllTransactions

	| portfolio aReceptiveAccount_A aReceptiveAccount_B withdrawlTransaction depositTransaction|
	
	portfolio := Portfolio new.
	aReceptiveAccount_A := ReceptiveAccount new.
	aReceptiveAccount_B := ReceptiveAccount new.

	portfolio addAccount: aReceptiveAccount_A.
	portfolio addAccount: aReceptiveAccount_B.
	
	depositTransaction := Deposit register: 100 on: aReceptiveAccount_A.
	withdrawlTransaction := Withdraw register: 50 on: aReceptiveAccount_B.

	self assert: (portfolio hasRegistered: depositTransaction).
	self assert: (portfolio hasRegistered: withdrawlTransaction)


! !

!PortfolioTest methodsFor: 'testing' stamp: 'NC 5/20/2024 15:16:59'!
test18PortofolioWithAnAccountAndANestedPorfolioHasRegisteredAllTransactions
	
	| aPortfolio aReceptiveAccount_A aReceptiveAccount_B aNestedPortfolio withdrawlTransaction_1 withdrawlTransaction_2 depositTransaction|
	
	aPortfolio := Portfolio new.
	aNestedPortfolio := Portfolio new.
	aReceptiveAccount_A := ReceptiveAccount new.
	aReceptiveAccount_B := ReceptiveAccount new.

	aPortfolio addAccount: aReceptiveAccount_A.
	aNestedPortfolio addAccount: aReceptiveAccount_B.
	aPortfolio addPortfolio: aNestedPortfolio.
	
	depositTransaction := Deposit register: 100 on: aReceptiveAccount_A.
	withdrawlTransaction_1 := Withdraw register: 50 on: aReceptiveAccount_B.
	withdrawlTransaction_2 := Withdraw register: 50 on: aReceptiveAccount_A.
		

	self assert: (aPortfolio hasRegistered: depositTransaction).
	self assert: (aPortfolio hasRegistered: withdrawlTransaction_1).
	self assert: (aPortfolio hasRegistered: withdrawlTransaction_2).


! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'jcs 5/18/2024 13:47:51'!
effectOnAccountBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'jcs 5/18/2024 13:48:09'!
effectOnAccountBalance

	^value! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'jcs 5/18/2024 13:48:25'!
effectOnAccountBalance

	^-1 * value! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #FinancialInstruments category: #'Portfolio-Ejercicio'!
Object subclass: #FinancialInstruments
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!FinancialInstruments methodsFor: 'private' stamp: 'jcs 5/19/2024 16:50:53'!
associatedAccountsOfChildren

	self subclassResponsibility! !


!FinancialInstruments methodsFor: 'balance' stamp: 'jcs 5/19/2024 16:59:56'!
balance

	self subclassResponsibility! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
FinancialInstruments subclass: #Portfolio
	instanceVariableNames: 'instruments parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'jcs 5/19/2024 16:12:23'!
initialize

	instruments := Set new.
	parents := Set new.! !


!Portfolio methodsFor: 'private' stamp: 'jcs 5/19/2024 16:12:37'!
addPortfolioAsParent: aParentPortfolio

	parents add: aParentPortfolio ! !

!Portfolio methodsFor: 'private' stamp: 'jcs 5/19/2024 16:53:55'!
associatedAccountsInWholeGraph

	| associatedAccounts rootPortfolios |

	associatedAccounts := Set new.
	
	rootPortfolios := self rootPortfolios.
	
	"run DFS from all nodes with an indegree of zero"
	
	rootPortfolios do: [:rootPortfolio | associatedAccounts := associatedAccounts union: (rootPortfolio associatedAccountsOfChildren)].
	
	^associatedAccounts! !

!Portfolio methodsFor: 'private' stamp: 'jcs 5/19/2024 16:27:52'!
associatedAccountsOfChildren

	"DFS goes brrrrr"

	| associatedAccounts |
		
	associatedAccounts := Set new.
	
	instruments do: [:anInstrument | associatedAccounts := associatedAccounts union: (anInstrument associatedAccountsOfChildren)].
	
	^associatedAccounts! !

!Portfolio methodsFor: 'private' stamp: 'jcs 5/19/2024 16:24:21'!
rootPortfolios

	| rootPortfolios |
	
	rootPortfolios := Set new.
	
	(parents isEmpty)
		ifTrue: [rootPortfolios add: self]
		ifFalse: [
			parents do: [:parentPortfolio | rootPortfolios := rootPortfolios union: (parentPortfolio rootPortfolios)]
		].

	^rootPortfolios 		
	
		! !


!Portfolio methodsFor: 'instrument managment' stamp: 'jcs 5/19/2024 16:47:20'!
addAccount: anInstrument

	self assertAccountNotPresentInPortfolio: anInstrument.
	instruments add: anInstrument ! !

!Portfolio methodsFor: 'instrument managment' stamp: 'jcs 5/19/2024 16:48:57'!
addPortfolio: aPortfolio

	self assertOwnAccountsDoNotIntersectWithPortfolio: aPortfolio.
	instruments add: aPortfolio.
	aPortfolio addPortfolioAsParent: self.! !


!Portfolio methodsFor: 'balance' stamp: 'jcs 5/19/2024 17:04:18'!
balance
	
	^instruments sum: [:anInstrument | anInstrument balance] ifEmpty: [0]! !


!Portfolio methodsFor: 'transactions' stamp: 'NC 5/20/2024 15:12:21'!
hasRegistered: aTransaction 

	^ self transactions includes: aTransaction! !

!Portfolio methodsFor: 'transactions' stamp: 'NC 5/20/2024 14:54:02'!
transactions

	| allTransactions | 
	
	allTransactions := Bag new.
	
	instruments do: [:anInstrument | allTransactions addAll:(anInstrument transactions)].
	
	^ allTransactions ! !


!Portfolio methodsFor: 'assertions' stamp: 'jcs 5/19/2024 16:52:36'!
assertAccountNotPresentInPortfolio: anAccount

	| ownAccounts |
	
	ownAccounts := self associatedAccountsInWholeGraph.
	
	(ownAccounts includes: anAccount ) ifTrue: [self error: self class errorInstrumentAlreadyInPortfolio ]! !

!Portfolio methodsFor: 'assertions' stamp: 'jcs 5/19/2024 16:52:36'!
assertOwnAccountsDoNotIntersectWithPortfolio: anotherPortfolio

	| ownAccounts instrumentAccounts |
	
	ownAccounts := self associatedAccountsInWholeGraph.
	
	instrumentAccounts  := anotherPortfolio associatedAccountsInWholeGraph.

	((ownAccounts intersection: instrumentAccounts) notEmpty) ifTrue: [self error: self class errorInstrumentAlreadyInPortfolio ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'errors' stamp: 'jcs 5/18/2024 14:07:43'!
errorInstrumentAlreadyInPortfolio

	^'Instrument already present in portfolio'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
FinancialInstruments subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'jcs 5/18/2024 13:48:47'!
balance

	^transactions sum: [ :aTransaction | aTransaction effectOnAccountBalance ] ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'private' stamp: 'jcs 5/19/2024 16:27:52'!
associatedAccountsOfChildren

	^Set with: self.! !
