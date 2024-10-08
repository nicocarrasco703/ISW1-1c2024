!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #SummaryTest category: #'Portfolio-Solucion'!
TestCase subclass: #SummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!SummaryTest methodsFor: 'tests' stamp: 'NC 5/25/2024 18:58:00'!
test01EmptyAccountSummaryHasZeroBalance

	| anAccount aSummary |
	
	anAccount := ReceptiveAccount new.
	
	aSummary := Summary for: anAccount.
	
	self assert: (aSummary generateAccountSummary) equals: 'Balance = 0
	'! !

!SummaryTest methodsFor: 'tests' stamp: 'NC 5/25/2024 18:57:43'!
test02AccountWithADepositPrintsSummaryCorrectly

	| anAccount aSummary |
	
	anAccount := ReceptiveAccount new.
	Deposit register: 100 on: anAccount.
	
	aSummary := Summary for: anAccount.
	
	self assert: (aSummary generateAccountSummary) equals: 'Depósito por 100.
	Balance = 100
	'! !

!SummaryTest methodsFor: 'tests' stamp: 'NC 5/25/2024 19:00:40'!
test03AccountWithAWithdrawPrintsSummaryCorrectly

	| anAccount aSummary |
	
	anAccount := ReceptiveAccount new.
	Withdraw register: 100 on: anAccount.
	
	aSummary := Summary for: anAccount.
	
	self assert: (aSummary generateAccountSummary) equals: 'Extracción por 100.
	Balance = -100
	'! !

!SummaryTest methodsFor: 'tests' stamp: 'jcs 5/25/2024 19:21:02'!
test04AccountsWithATransferPrintsSummaryCorrectly

	| senderAccount receiverAccount aSummaryForAccount1 aSummaryForAccount2 |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Transfer ammount: 100 from: senderAccount to: receiverAccount.
	
	aSummaryForAccount1 := Summary for: senderAccount.
	aSummaryForAccount2 := Summary for: receiverAccount.
	
	self assert: (aSummaryForAccount1 generateAccountSummary) equals: 'Salida por transferencia de 100.
	Balance = -100
	'.
	self assert: (aSummaryForAccount2 generateAccountSummary) equals: 'Entrada por transferencia de 100.
	Balance = 100
	'! !

!SummaryTest methodsFor: 'tests' stamp: 'jcs 5/25/2024 19:26:34'!
test05SummaryForAccountWithEveryKindOfTransaction

	| senderAccount receiverAccount aSummaryForAccount |
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Transfer ammount: 100 from: senderAccount to: receiverAccount.
	Transfer ammount: 100 from: receiverAccount to: senderAccount.
	Deposit register: 100 on: senderAccount.
	Withdraw register: 100 on: senderAccount.
	
	aSummaryForAccount := Summary for: senderAccount.
	
	self assert: (aSummaryForAccount generateAccountSummary) equals: 'Salida por transferencia de 100.
	Entrada por transferencia de 100.
	Depósito por 100.
	Extracción por 100.
	Balance = 0
	'.
! !

!SummaryTest methodsFor: 'tests' stamp: 'jcs 5/25/2024 19:48:17'!
test06SummaryForAccountsInPortfolio

	| senderAccount receiverAccount portfolioSummary aPortfolio |
	
	aPortfolio := Portfolio new.
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	aPortfolio add: senderAccount.
	aPortfolio add: receiverAccount.

	
	Transfer ammount: 100 from: senderAccount to: receiverAccount.
	Transfer ammount: 100 from: receiverAccount to: senderAccount.
	Deposit register: 100 on: senderAccount.
	Withdraw register: 100 on: senderAccount.
	
	portfolioSummary := Summary for: aPortfolio.
	
	"TODO: posiblemente retornar conjunto de summaries"
	
	self assert: (portfolioSummary generateAccountSummary) equals: 'Salida por transferencia de 100.
	Entrada por transferencia de 100.
	Depósito por 100.
	Extracción por 100.
	Balance = 0
	Entrada por transferencia de 100.
	Salida por transferencia de 100.
	Balance = 0
	'.
! !


!classDefinition: #TransferLegTest category: #'Portfolio-Solucion'!
TestCase subclass: #TransferLegTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLegTest methodsFor: 'tests' stamp: 'jcs 5/23/2024 21:10:55'!
test01TransferFromOneAccountToAnotherAffectsBalance

    | senderAccount recieverAccount |
    
    senderAccount := ReceptiveAccount new.
    recieverAccount := ReceptiveAccount new.
    
    Transfer ammount: 100 from: senderAccount to: recieverAccount.
    
    self assert: (recieverAccount balance) equals: 100.
    self assert: (senderAccount balance) equals: -100! !

!TransferLegTest methodsFor: 'tests' stamp: 'jcs 5/23/2024 21:17:41'!
test02SenderAndRecieverAccountsRegisterWithdrawAndDeposit

    | senderAccount recieverAccount transfer depositTransaction withdrawTransaction |
    
    senderAccount := ReceptiveAccount new.
    recieverAccount := ReceptiveAccount new.
    
    transfer := Transfer ammount: 100 from: senderAccount to: recieverAccount.
    withdrawTransaction := transfer withdrawalLeg.
    depositTransaction := transfer depositLeg.
    
    self assert: (senderAccount hasRegistered: withdrawTransaction).
    self assert: (recieverAccount hasRegistered: depositTransaction)! !

!TransferLegTest methodsFor: 'tests' stamp: 'jcs 5/23/2024 21:32:02'!
test03CanGoFromWithdrawLegToDepositLeg

    | senderAccount recieverAccount transferTransaction depositTransaction withdrawTransaction |
    
    senderAccount := ReceptiveAccount new.
    recieverAccount := ReceptiveAccount new.
    
    transferTransaction := Transfer ammount: 100 from: senderAccount to: recieverAccount.
    withdrawTransaction := transferTransaction withdrawalLeg.
    depositTransaction := transferTransaction depositLeg.
    
    self assert: (withdrawTransaction depositLeg) equals: depositTransaction! !

!TransferLegTest methodsFor: 'tests' stamp: 'jcs 5/23/2024 22:04:30'!
test04ThereExistsOnlyOneInstanceOfValue

    | senderAccount recieverAccount transferTransaction depositTransaction withdrawTransaction |
    
    senderAccount := ReceptiveAccount new.
    recieverAccount := ReceptiveAccount new.
    
    transferTransaction := Transfer ammount: 100 from: senderAccount to: recieverAccount.
    withdrawTransaction := transferTransaction withdrawalLeg.
    depositTransaction := transferTransaction depositLeg.
    
    self assert: ( (withdrawTransaction value) == (depositTransaction value) )! !

!TransferLegTest methodsFor: 'tests' stamp: 'NC 5/24/2024 21:09:26'!
test05TransferCannotBeNegative

	| senderAccount recieverAccount |
	
	senderAccount := ReceptiveAccount new.
	recieverAccount := ReceptiveAccount new.
	
	self 
		should: [Transfer ammount:  -100 from: senderAccount to: recieverAccount ]
		raise: Error - MessageNotUnderstood
		withMessageText: Transfer canNotTransferANegativeAmmountErrorDescription.
	! !

!TransferLegTest methodsFor: 'tests' stamp: 'NC 5/24/2024 21:20:57'!
test06SenderAndRecieverCannotBeEqual

	| anAccount |
	
	anAccount := ReceptiveAccount new.
	
	self 
		should: [Transfer ammount: 100 from: anAccount to: anAccount]
		raise: Error - MessageNotUnderstood
		withMessageText: Transfer canNotTransferToSameAccountErrorDescription.
	! !


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'jcs 5/27/2024 15:44:55'!
operateOnTransactionsWith: objectThatWillOperateOnTransactions

	self subclassResponsibility! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !



!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !



!Portfolio methodsFor: 'as yet unclassified' stamp: 'jcs 5/27/2024 15:50:02'!
operateOnTransactionsWith: objectThatWillOperateOnTransactions

	accounts do: [:anAccount | anAccount operateOnTransactionsWith: objectThatWillOperateOnTransactions ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'jcs 5/27/2024 15:36:04'!
operateOnTransactionsWith: objectThatWillOperateOnTransactions

	transactions do: [:aTransaction | aTransaction performOperationWith: objectThatWillOperateOnTransactions ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !



!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'summary' stamp: 'NC 5/26/2024 12:52:38'!
lineForAccountSummary

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !



!Deposit methodsFor: 'as yet unclassified' stamp: 'jcs 5/27/2024 15:36:46'!
performOperationWith: objectThatWillOperateOnTransactions

	objectThatWillOperateOnTransactions operateWithDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'jcs 5/23/2024 22:18:06'!
value

	^transfer value! !


!TransferLeg methodsFor: 'balance' stamp: 'jcs 5/23/2024 22:15:35'!
affectBalance: aBalance

	self subclassResponsibility! !


!TransferLeg methodsFor: 'initialization' stamp: 'jcs 5/23/2024 22:12:30'!
initalizeAsPartOf: aTransfer

	transfer := aTransfer ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'jcs 5/23/2024 22:13:00'!
asPartOf: aTransfer

	^self new initalizeAsPartOf: aTransfer! !


!classDefinition: #DepositLeg category: #'Portfolio-Solucion'!
TransferLeg subclass: #DepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!DepositLeg methodsFor: 'balance' stamp: 'jcs 5/23/2024 21:59:19'!
affectBalance: aBalance

	^aBalance + (transfer value)! !


!DepositLeg methodsFor: 'legs' stamp: 'jcs 5/23/2024 22:14:08'!
withdrawlLeg

	^transfer withdrawalLeg ! !



!DepositLeg methodsFor: 'as yet unclassified' stamp: 'jcs 5/27/2024 15:37:01'!
performOperationWith: objectThatWillOperateOnTransactions

	objectThatWillOperateOnTransactions operateWithDepositLeg: self! !


!classDefinition: #WithdrawlLeg category: #'Portfolio-Solucion'!
TransferLeg subclass: #WithdrawlLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!WithdrawlLeg methodsFor: 'balance' stamp: 'jcs 5/23/2024 21:59:06'!
affectBalance: aBalance

	^aBalance - (transfer value)! !


!WithdrawlLeg methodsFor: 'legs' stamp: 'jcs 5/23/2024 22:13:54'!
depositLeg

	^transfer depositLeg ! !



!WithdrawlLeg methodsFor: 'as yet unclassified' stamp: 'jcs 5/27/2024 15:37:17'!
performOperationWith: objectThatWillOperateOnTransactions

	objectThatWillOperateOnTransactions operateWithWithdrawlLeg: self! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !



!Withdraw methodsFor: 'as yet unclassified' stamp: 'jcs 5/27/2024 15:37:29'!
performOperationWith: objectThatWillOperateOnTransactions

	objectThatWillOperateOnTransactions operateWithWithdrawl: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Summary category: #'Portfolio-Solucion'!
Object subclass: #Summary
	instanceVariableNames: 'account generatedSummary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Summary methodsFor: 'initialization' stamp: 'jcs 5/27/2024 15:39:16'!
initializeFor: anAccount 
	
	account := anAccount.
	generatedSummary := OrderedCollection new.! !


!Summary methodsFor: 'summary generation' stamp: 'jcs 5/27/2024 15:47:26'!
generateAccountSummary

	| carriageReturn summary |
	account operateOnTransactionsWith: self.
	generatedSummary add: 'Balance = ', (account balance asString).
	summary := ''.
	carriageReturn := '
	'.
	generatedSummary do: [ :curStr | summary := summary,curStr,carriageReturn].

	^ summary! !


!Summary methodsFor: 'as yet unclassified' stamp: 'jcs 5/27/2024 15:40:07'!
operateWithDeposit: aDeposit

	generatedSummary add: 'Depósito por ', (aDeposit value asString), '.'! !

!Summary methodsFor: 'as yet unclassified' stamp: 'jcs 5/27/2024 15:41:30'!
operateWithDepositLeg: aDepositLeg

	generatedSummary add: 'Entrada por transferencia de ', (aDepositLeg value asString), '.'! !

!Summary methodsFor: 'as yet unclassified' stamp: 'jcs 5/27/2024 15:42:57'!
operateWithWithdrawl: aWithdrawl

	generatedSummary add: 'Extracción por ', (aWithdrawl value asString), '.'! !

!Summary methodsFor: 'as yet unclassified' stamp: 'jcs 5/27/2024 15:42:19'!
operateWithWithdrawlLeg: aWithdrawlLeg

	generatedSummary add: 'Salida por transferencia de ', (aWithdrawlLeg value asString), '.'! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Summary class' category: #'Portfolio-Solucion'!
Summary class
	instanceVariableNames: ''!

!Summary class methodsFor: 'instance creation' stamp: 'NC 5/25/2024 17:58:13'!
for: anAccount 

	^self new initializeFor: anAccount ! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositLeg withdrawlLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'jcs 5/23/2024 22:01:26'!
initializeAmmount: aMonetaryAmmount from: aSenderAccount to: aRecieverAccount 

	value := aMonetaryAmmount.
	
	depositLeg := DepositLeg asPartOf: self.
	aRecieverAccount register: depositLeg.
	withdrawlLeg := WithdrawlLeg asPartOf: self.
	aSenderAccount register: withdrawlLeg 
	! !


!Transfer methodsFor: 'legs' stamp: 'jcs 5/23/2024 21:29:21'!
depositLeg
	
	^depositLeg! !

!Transfer methodsFor: 'legs' stamp: 'jcs 5/23/2024 21:28:41'!
withdrawalLeg
	
	^withdrawlLeg ! !


!Transfer methodsFor: 'value' stamp: 'jcs 5/23/2024 22:01:34'!
value

	^value! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'NC 5/24/2024 21:22:03'!
ammount: aMonetaryAmmount from: aSenderAccount to: aRecieverAccount 

	self assertMonetaryValueIsValid: aMonetaryAmmount.
	
	self assertAccountsAreNotTheSameSender: aSenderAccount AndReciever: aRecieverAccount. 


	^self new initializeAmmount: aMonetaryAmmount from: aSenderAccount to: aRecieverAccount ! !


!Transfer class methodsFor: 'assertions' stamp: 'NC 5/24/2024 21:21:31'!
assertAccountsAreNotTheSameSender: aSenderAccount AndReciever: aRecieverAccount 

	aSenderAccount = aRecieverAccount ifTrue: [self error: self canNotTransferToSameAccountErrorDescription ]! !

!Transfer class methodsFor: 'assertions' stamp: 'NC 5/24/2024 21:19:40'!
assertMonetaryValueIsValid: anAmmountOfMoney

	anAmmountOfMoney strictlyPositive ifFalse: [self error: self canNotTransferANegativeAmmountErrorDescription ]! !


!Transfer class methodsFor: 'error descriptions' stamp: 'NC 5/24/2024 21:16:18'!
canNotTransferANegativeAmmountErrorDescription
	
	^'Transfer ammount must be a non negative value'! !

!Transfer class methodsFor: 'error descriptions' stamp: 'NC 5/24/2024 21:21:41'!
canNotTransferToSameAccountErrorDescription

	^'Can not transfer to same account'! !
