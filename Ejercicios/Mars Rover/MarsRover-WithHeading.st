!classDefinition: #MarsRoverTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #MarsRoverWindowDirectionTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowDirectionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowDirectionTest methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:27:40'!
test0x00DirectionEmptyWithNewRover

	| aRover aRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindowDirection for: aRover.
		
	self assert: (aRoverWindow currentDirection) equals: ''! !

!MarsRoverWindowDirectionTest methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:38:05'!
test0x01DirectionChangesAfterTurningRightOnce

	| aRover aRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindowDirection for: aRover.
	aRover process: 'r'.
		
	self assert: (aRoverWindow currentDirection) equals: 'East'! !

!MarsRoverWindowDirectionTest methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:38:18'!
test0x02DirectionChangesAfterTurningRightTwice

	| aRover aRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindowDirection for: aRover.
	aRover process: 'rr'.
		
	self assert: (aRoverWindow currentDirection) equals: 'South'! !

!MarsRoverWindowDirectionTest methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:40:22'!
test0x03DirectionChangesAfterTurningLeft

	| aRover aRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindowDirection for: aRover.
	aRover process: 'l'.
		
	self assert: (aRoverWindow currentDirection) equals: 'West'! !

!MarsRoverWindowDirectionTest methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:43:51'!
test0x04DirectionDoesNotChangeAfterTurningAMultipleOf360Degrees

	| aRover aRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindowDirection for: aRover.
	aRover process: 'rrrrllllrrll'.
		
	self assert: (aRoverWindow currentDirection) equals: 'North'! !

!MarsRoverWindowDirectionTest methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:45:28'!
test0x05RoverCanHaveMultipleDirectionLoggers

	| aRover aRoverWindow anotherRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindowDirection for: aRover.
	anotherRoverWindow := MarsRoverWindowDirection for: aRover.
	aRover process: 'll'.
		
	self assert: (aRoverWindow currentDirection) equals: 'South'.
	self assert: (anotherRoverWindow currentDirection) equals: 'South'! !


!classDefinition: #MarsRoverWindowPositionTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowPositionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowPositionTest methodsFor: 'tests' stamp: 'jcs 5/28/2024 22:25:24'!
test0x00PositionIsEmptyWithNewRover

	| aRover aRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindowPosition for: aRover.
	
	"self should: [aRoverWindow currentPosition] raise: Error - MessageNotUnderstood description: RoverWindow errorParameterNotKnown."
	
	self assert: (aRoverWindow currentPosition) equals: ''
! !

!MarsRoverWindowPositionTest methodsFor: 'tests' stamp: 'jcs 5/28/2024 22:25:37'!
test0x01PositionIsCorrectAfterMovingForward

	| aRover aRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindowPosition for: aRover.
	aRover process: 'f'.
	
	self assert: (aRoverWindow currentPosition) equals: '1@2'
! !

!MarsRoverWindowPositionTest methodsFor: 'tests' stamp: 'jcs 5/28/2024 22:25:52'!
test0x02PositionIsCorrectAfterMovingBackward

	| aRover aRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindowPosition for: aRover.
	aRover process: 'b'.
	
	self assert: (aRoverWindow currentPosition) equals: '1@0'
! !

!MarsRoverWindowPositionTest methodsFor: 'tests' stamp: 'jcs 5/28/2024 22:26:03'!
test0x03PositionIsCorrectAfterMultipleCommands

	| aRover aRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindowPosition for: aRover.
	aRover process: 'ff'.
	
	self assert: (aRoverWindow currentPosition) equals: '1@3'
! !

!MarsRoverWindowPositionTest methodsFor: 'tests' stamp: 'jcs 5/28/2024 22:22:18'!
test0x04OneRoverCanHaveMultipleLoggers

	| aRover aRoverWindow anotherRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindowPosition for: aRover.
	anotherRoverWindow := MarsRoverWindowPosition for: aRover.
	aRover process: 'f'.
	
	self assert: (aRoverWindow currentPosition) equals: '1@2'.
	self assert: (anotherRoverWindow currentPosition) equals: '1@2'! !


!classDefinition: #MarsRoverWindowTest category: #'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverWindowTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:57:39'!
test0x00EmptyWindowForDirectionAndPositionOnNewlyCreatedRover

	| aRover aRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindow for: aRover.
		
	self assert: (aRoverWindow currentDirection) equals: ''.
	self assert: (aRoverWindow currentPosition) equals: ''.! !

!MarsRoverWindowTest methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 23:05:23'!
test0x01PositionAndDirectionChangeAfterProcessingCommands

	| aRover aRoverWindow |
	
	aRover := MarsRover 	at: 1@1 heading: MarsRoverHeadingNorth.
	aRoverWindow := MarsRoverWindow for: aRover.
	aRover process: 'rf'.
		
	self assert: (aRoverWindow currentDirection) equals: 'East'.
	self assert: (aRoverWindow currentPosition) equals: '2@1'.! !


!classDefinition: #MarsRover category: #'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionLoggers directionLoggers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'jcs 5/28/2024 22:46:04'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self.
	positionLoggers := Set new.
	directionLoggers := Set new! !


!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:02'!
headEast
	
	head := MarsRoverHeadingEast for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:12'!
headNorth
	
	head := MarsRoverHeadingNorth for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:17'!
headSouth
	
	head := MarsRoverHeadingSouth for: self! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:17:24'!
headWest
	
	head := MarsRoverHeadingWest for: self ! !

!MarsRover methodsFor: 'heading' stamp: 'jcs 5/28/2024 22:46:59'!
rotateLeft
	
	head rotateLeft.
	directionLoggers do: [:directionLogger | directionLogger updateDirection: head]! !

!MarsRover methodsFor: 'heading' stamp: 'jcs 5/28/2024 22:47:06'!
rotateRight
	
	head rotateRight.
	directionLoggers do: [:directionLogger | directionLogger updateDirection: head]! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'jcs 5/28/2024 22:29:51'!
moveBackward
	
	head moveBackward.
	positionLoggers do: [: aLogger| aLogger updatePosition: position] ! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:01'!
moveEast
	
	position := position + (1@0)! !

!MarsRover methodsFor: 'moving' stamp: 'jcs 5/28/2024 22:29:51'!
moveForward
	
	head moveForward.
	positionLoggers do: [: aLogger| aLogger updatePosition: position] ! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:12'!
moveNorth
	
	position := position + (0@1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:13:34'!
moveSouth
	
	position := position + (0@-1)! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 8/22/2019 12:15:32'!
moveWest
	
	position := position + (-1@0)! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'logging' stamp: 'jcs 5/28/2024 22:46:16'!
addDirectionLogger: aLogger

	directionLoggers add: aLogger ! !

!MarsRover methodsFor: 'logging' stamp: 'jcs 5/28/2024 22:30:30'!
addPositionLogger: aLogger

	positionLoggers add: aLogger! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: #'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!classDefinition: #MarsRoverHeadingNorth category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!classDefinition: #MarsRoverHeadingSouth category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!classDefinition: #MarsRoverHeadingWest category: #'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!classDefinition: #MarsRoverWindow category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindow
	instanceVariableNames: 'directionLogger positionLogger'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 23:02:28'!
currentDirection

	^directionLogger currentDirection ! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 23:03:13'!
currentPosition

	^positionLogger currentPosition ! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:59:47'!
initializeFor: aRover

	positionLogger := MarsRoverWindowPosition for: aRover.
	directionLogger := MarsRoverWindowDirection for: aRover.! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 23:02:50'!
updateDirection: newDirection

	^directionLogger updateDirection: newDirection ! !

!MarsRoverWindow methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 23:03:28'!
updatePosition: newPosition

	^positionLogger updatePosition: newPosition ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindow class' category: #'MarsRover-WithHeading'!
MarsRoverWindow class
	instanceVariableNames: ''!

!MarsRoverWindow class methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 23:00:09'!
for: aRover

	^self new initializeFor: aRover ! !


!classDefinition: #MarsRoverWindowDirection category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindowDirection
	instanceVariableNames: 'rover lastKnownDirection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowDirection methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:37:15'!
initializeFor: aRover

	rover := aRover.
	rover addDirectionLogger: self.
	lastKnownDirection := ''! !

!MarsRoverWindowDirection methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:43:31'!
updateDirection: newDirection

	(newDirection isKindOf: MarsRoverHeadingEast) ifTrue: [lastKnownDirection := 'East'].
	(newDirection isKindOf: MarsRoverHeadingSouth) ifTrue: [lastKnownDirection := 'South'].
	(newDirection isKindOf: MarsRoverHeadingWest) ifTrue: [lastKnownDirection := 'West'].
	(newDirection isKindOf: MarsRoverHeadingNorth) ifTrue: [lastKnownDirection := 'North'].
! !


!MarsRoverWindowDirection methodsFor: 'accessing' stamp: 'jcs 5/28/2024 22:28:06'!
currentDirection
	
	^lastKnownDirection! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindowDirection class' category: #'MarsRover-WithHeading'!
MarsRoverWindowDirection class
	instanceVariableNames: ''!

!MarsRoverWindowDirection class methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:51:25'!
for: aRover

	^self new initializeFor: aRover ! !


!classDefinition: #MarsRoverWindowPosition category: #'MarsRover-WithHeading'!
Object subclass: #MarsRoverWindowPosition
	instanceVariableNames: 'rover lastKnownPosition'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverWindowPosition methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:30:30'!
initializeFor: aRover

	rover := aRover.
	rover addPositionLogger: self.
	lastKnownPosition := ''.! !

!MarsRoverWindowPosition methodsFor: 'as yet unclassified' stamp: 'HAW 5/27/2024 21:45:38'!
updatePosition: newPosition

	lastKnownPosition := newPosition asString.! !


!MarsRoverWindowPosition methodsFor: 'positional' stamp: 'HAW 5/27/2024 21:45:22'!
currentPosition
	
	^ lastKnownPosition! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverWindowPosition class' category: #'MarsRover-WithHeading'!
MarsRoverWindowPosition class
	instanceVariableNames: ''!

!MarsRoverWindowPosition class methodsFor: 'as yet unclassified' stamp: 'HAW 5/27/2024 21:20:40'!
errorParameterNotKnown

	^'mala noticia mi gente'! !

!MarsRoverWindowPosition class methodsFor: 'as yet unclassified' stamp: 'jcs 5/28/2024 22:51:28'!
for: aRover

	^self new initializeFor: aRover ! !