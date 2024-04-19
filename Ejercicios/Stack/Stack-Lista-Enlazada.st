!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'currentTop'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accesing' stamp: 'jcs 4/19/2024 11:52:16'!
isEmpty
	
	^currentTop isEmpty! !

!OOStack methodsFor: 'accesing' stamp: 'jcs 4/19/2024 12:41:30'!
pop
	
	| currentTopElement |
	
	currentTopElement := currentTop top.
	currentTop := currentTop getPreviouslyStackedElement.
	^currentTopElement.
	! !

!OOStack methodsFor: 'accesing' stamp: 'jcs 4/19/2024 12:39:19'!
push: anElement
		
	currentTop := StackedElement basicNew initializeWith: anElement withPreviousElement: currentTop
	! !

!OOStack methodsFor: 'accesing' stamp: 'jcs 4/19/2024 11:52:49'!
size

	^currentTop size! !

!OOStack methodsFor: 'accesing' stamp: 'jcs 4/19/2024 12:19:24'!
top

	^currentTop top! !


!OOStack methodsFor: 'initialization' stamp: 'jcs 4/19/2024 11:39:47'!
initialize
	
	currentTop := StackBase basicNew ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'jcs 4/18/2024 21:20:40'!
stackEmptyErrorDescription
	
	^ 'recursar algo 2'! !


!classDefinition: #StackBase category: #'Stack-Exercise'!
OOStack subclass: #StackBase
	instanceVariableNames: 'nextElement'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackBase methodsFor: 'accesing' stamp: 'jcs 4/19/2024 11:43:22'!
isEmpty
	
	^true! !

!StackBase methodsFor: 'accesing' stamp: 'jcs 4/19/2024 11:43:35'!
size
	
	^0! !

!StackBase methodsFor: 'accesing' stamp: 'jcs 4/19/2024 11:42:56'!
top
	
	self error: self class stackEmptyErrorDescription! !


!classDefinition: #StackedElement category: #'Stack-Exercise'!
OOStack subclass: #StackedElement
	instanceVariableNames: 'previousElement containedElement parentClassInstance'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackedElement methodsFor: 'accesing' stamp: 'jcs 4/19/2024 11:44:40'!
isEmpty

	^false ! !

!StackedElement methodsFor: 'accesing' stamp: 'jcs 4/19/2024 11:50:00'!
size
	
	^1 + previousElement size! !

!StackedElement methodsFor: 'accesing' stamp: 'jcs 4/19/2024 12:19:33'!
top
	
	^containedElement! !


!StackedElement methodsFor: 'accesing - private' stamp: 'jcs 4/19/2024 12:41:13'!
getPreviouslyStackedElement

	^previousElement! !


!StackedElement methodsFor: 'initialization' stamp: 'jcs 4/19/2024 11:49:27'!
initializeWith: anElement withPreviousElement: previousStackedElement
	
	containedElement := anElement.
	previousElement := previousStackedElement.
! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
