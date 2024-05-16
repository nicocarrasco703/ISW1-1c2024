!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'NC 5/14/2024 19:18:19'!
test01ReceptiveAccountAddedToPortfolioSuccesfully

	| portfolio receptiveAccount1|
	portfolio := Portfolio new.
	receptiveAccount1 := ReceptiveAccount new.

	portfolio addAccount: receptiveAccount1.
	
	self assert: (portfolio accountHasBeenAdded: receptiveAccount1)! !

!PortfolioTest methodsFor: 'tests' stamp: 'NC 5/14/2024 19:18:29'!
test02PortfolioAddedToPortfolioSuccesfully

	| mainPortfolio aPortfolio|
	mainPortfolio := Portfolio new.
	aPortfolio := Portfolio new.

	mainPortfolio addPortfolio: aPortfolio.
	
	self assert: (mainPortfolio portfolioHasBeenAdded: aPortfolio)! !

!PortfolioTest methodsFor: 'tests' stamp: 'NC 5/14/2024 19:27:50'!
test03ReceptiveAccountAddedToPortfolioRecievedATransaction

	| portfolio receptiveAccount depositTransaction|
	portfolio := Portfolio new.
	receptiveAccount := ReceptiveAccount new.

	portfolio addAccount: receptiveAccount.
	
	depositTransaction := Deposit register: 100 on: receptiveAccount.
	
	"falla porque deberia dar true, pero usando detect devuelve la posicion de la cuenta que registro el deposito en las cuentas del portfolio"
	self assert: (portfolio hasRegistered: depositTransaction)! !

!PortfolioTest methodsFor: 'tests' stamp: 'jcs 5/15/2024 18:49:26'!
test04TransactionsMadeWithReceptiveAccountRegisteredInPortfolio

	| portfolio receptiveAccount_A receptiveAccount_B depositTransaction withdrawlTransaction transactions|
	portfolio := Portfolio new.
	receptiveAccount_A := ReceptiveAccount new.
	receptiveAccount_B := ReceptiveAccount new.

	portfolio addAccount: receptiveAccount_A.
	portfolio addAccount: receptiveAccount_B.
	
	depositTransaction := Deposit register: 100 on: receptiveAccount_A.
	withdrawlTransaction := Withdraw register: 50 on: receptiveAccount_B.
	transactions := Bag with: depositTransaction with: withdrawlTransaction.
	
	self assert: (portfolio transactions) equals: transactions ! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcs 5/13/2024 21:25:05'!
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'jcs 5/13/2024 21:32:19'!
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


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'jcs 5/13/2024 21:21:21'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts portfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'NC 5/14/2024 19:09:54'!
accountHasBeenAdded: aReceptiveAccount 
	^accounts includes: aReceptiveAccount! !

!Portfolio methodsFor: 'testing' stamp: 'NC 5/14/2024 19:10:14'!
portfolioHasBeenAdded: aPortfolio
	^portfolios includes: aPortfolio! !


!Portfolio methodsFor: 'initialization' stamp: 'NC 5/14/2024 19:05:04'!
initialize

	accounts := Set new.
	portfolios := Set new.! !


!Portfolio methodsFor: 'portfolios' stamp: 'NC 5/14/2024 19:04:54'!
addPortfolio: aPortfolio

	portfolios add: aPortfolio! !


!Portfolio methodsFor: 'accounts' stamp: 'NC 5/14/2024 18:49:15'!
addAccount: anAccount

	accounts add: anAccount! !

!Portfolio methodsFor: 'accounts' stamp: 'jcs 5/15/2024 18:41:58'!
hasRegistered: aTransaction 
	"aca nose si usar detect, pero lo que querriamos es ver si alguna cuenta registro la transaccion"
	^(accounts count: [:anAccount | anAccount hasRegistered: aTransaction]) > 0! !

!Portfolio methodsFor: 'accounts' stamp: 'jcs 5/15/2024 18:58:16'!
transactions
	
	| allTransactions |
	
	allTransactions := Bag new.
	accounts do: [:anAccount | allTransactions addAll: (anAccount transactions)].
	^allTransactions ! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
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


!ReceptiveAccount methodsFor: 'balance' stamp: 'jcs 5/13/2024 21:43:39'!
balance

	| totalBalance |
	
	totalBalance := 0.
	transactions do: [:aTransaction | 
		(aTransaction isKindOf: Deposit) ifTrue: [totalBalance := totalBalance + aTransaction value].	
		(aTransaction isKindOf: Withdraw ) ifTrue: [totalBalance := totalBalance - aTransaction value].		
	].
	^totalBalance ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !
