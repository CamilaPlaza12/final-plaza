Class {
	#name : 'ProbabilityTest',
	#superclass : 'TestCase',
	#category : 'IngSoft2-Tests',
	#package : 'IngSoft2-Tests'
}

{ #category : 'tests' }
ProbabilityTest >> test01When1000BoardsAreCreatedThenProbabilityGeneratorOfAtomicBombBetween1And3 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(CellGenerator setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) atomicBombs ].
	self assert: (sum // 1000 between: 1 and: 3)
]

{ #category : 'tests' }
ProbabilityTest >> test02When1000BoardsAreCreatedThenProbabilityGeneratorOfHyperJumpBetween7And9 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(CellGenerator setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) hyperJumps ].
	
	
	self assert: ((sum // 1000) between: 7 and: 9)
]

{ #category : 'tests' }
ProbabilityTest >> test03When1000BoardsAreCreatedThenProbabilityGeneratorOfMoonWalkBetween9And11 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(CellGenerator setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) moonWalks ].
	self assert: ((sum // 1000) between: 9 and: 11)
]

{ #category : 'tests' }
ProbabilityTest >> test04When1000BoardsAreCreatedThenProbabilityGeneratorOfNoEffectBetween29And31 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(CellGenerator setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) noEffects ].	
	self assert: ((sum // 1000) between: 29 and: 31)
]

{ #category : 'tests' }
ProbabilityTest >> test05When1000BoardsAreCreatedThenProbabilityGeneratorOfSpeedUpBetween19And21 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(CellGenerator setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) speedUps ].	
	self assert: ((sum // 1000) between: 19 and: 21)
]

{ #category : 'tests' }
ProbabilityTest >> test06When1000BoardsAreCreatedThenProbabilityGeneratorOfWormHoleBetween19And21 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(CellGenerator setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) wormHoles ].	
	
	self assert: ((sum // 1000) between: 19 and: 21)
]

{ #category : 'tests' }
ProbabilityTest >> test07WhenADeckOf1000CardsIsCreatedThenCardGeneratorProbabilityOfSpeedsBetween0and10 [

	| randomCards sum|
	randomCards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCards add:
			(CardGenerator setWithCards: 100) ].
	1 to: randomCards size do: [ :index | 
	sum := sum + (randomCards at: index) speeds ].
	self assert: (sum // 1000 between: 0 and: 10)
]

{ #category : 'tests' }
ProbabilityTest >> test08WhenADeckOf1000CardsIsCreatedThenCardGeneratorProbabilityOfOverloadsBetween0and10 [

	| randomCards sum|
	randomCards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCards add:
			(CardGenerator setWithCards: 100) ].
	1 to: randomCards size do: [ :index | 
	sum := sum + (randomCards at: index) overloads].
	self assert: (sum // 1000 between: 0 and: 10)
]

{ #category : 'tests' }
ProbabilityTest >> test09WhenADeckOf1000CardsIsCreatedThenCardGeneratorProbabilityOfAccelerationsBetween0and10 [

	| randomCards sum|
	randomCards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCards add:
			(CardGenerator setWithCards: 100) ].
	1 to: randomCards size do: [ :index | 
	sum := sum + (randomCards at: index) accelerations].
	self assert: (sum // 1000 between: 0 and: 10)
]

{ #category : 'tests' }
ProbabilityTest >> test10WhenADeckOf1000CardsIsCreatedThenCardGeneratorProbabilityOfCancellationsBetween0and10 [

	| randomCards sum|
	randomCards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCards add:
			(CardGenerator setWithCards: 100) ].
	1 to: randomCards size do: [ :index | 
	sum := sum + (randomCards at: index) cancellations].
	self assert: (sum // 1000 between: 0 and: 10)
]

{ #category : 'tests' }
ProbabilityTest >> test11WhenADeckOf1000CardsIsCreatedThenCardGeneratorProbabilityOfRedosBetween0and10 [

	| randomCards sum|
	randomCards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCards add:
			(CardGenerator setWithCards: 100) ].
	1 to: randomCards size do: [ :index | 
	sum := sum + (randomCards at: index) redos].
	self assert: (sum // 1000 between: 0 and: 10)
]

{ #category : 'tests' }
ProbabilityTest >> test12WhenADeckOf1000CardsIsCreatedThenCardGeneratorProbabilityOfRepeatsBetween0and10 [

	| randomCards sum|
	randomCards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCards add:
			(CardGenerator setWithCards: 100) ].
	1 to: randomCards size do: [ :index | 
	sum := sum + (randomCards at: index) repeats].
	self assert: (sum // 1000 between: 0 and: 10)
]

{ #category : 'tests' }
ProbabilityTest >> test13When1000BoardsAreCreatedThenProbabilityGeneratorOfCardsBetween9And11 [

	| randomCellEffects sum |
	randomCellEffects := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCellEffects add:
			(CellGenerator setWithCellEffects: 100) ].
	1 to: randomCellEffects size do: [ :index | 
	sum := sum + (randomCellEffects at: index) cards ].	
	self assert: ((sum // 1000) between: 9 and: 11)
]

{ #category : 'tests' }
ProbabilityTest >> test14WhenADeckOf1000CardsIsCreatedThenCardGeneratorProbabilityOfDoublesBetween0and10 [

	| randomCards sum|
	randomCards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCards add:
			(CardGenerator setWithCards: 100) ].
	1 to: randomCards size do: [ :index | 
	sum := sum + (randomCards at: index) doubles].
	self assert: (sum // 1000 between: 0 and: 10)
]

{ #category : 'tests' }
ProbabilityTest >> test15WhenADeckOf1000CardsIsCreatedThenCardGeneratorProbabilityOfFreedomsBetween0and10 [

	| randomCards sum|
	randomCards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCards add:
			(CardGenerator setWithCards: 100) ].
	1 to: randomCards size do: [ :index | 
	sum := sum + (randomCards at: index) freedoms].
	self assert: (sum // 1000 between: 0 and: 10)
]

{ #category : 'tests' }
ProbabilityTest >> test16WhenADeckOf1000CardsIsCreatedThenCardGeneratorProbabilityOfReversesBetween0and10 [

	| randomCards sum|
	randomCards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCards add:
			(CardGenerator setWithCards: 100) ].
	1 to: randomCards size do: [ :index | 
	sum := sum + (randomCards at: index) reverses].
	self assert: (sum // 1000 between: 0 and: 10)
]

{ #category : 'tests' }
ProbabilityTest >> test17WhenADeckOf1000CardsIsCreatedThenCardGeneratorProbabilityOfSkipsBetween0and10 [

	| randomCards sum|
	randomCards := OrderedCollection new.
	sum := 0.
	1 to: 1000 do: [ :index | 
		randomCards add:
			(CardGenerator setWithCards: 100) ].
	1 to: randomCards size do: [ :index | 
	sum := sum + (randomCards at: index) skips].
	self assert: (sum // 1000 between: 0 and: 10)
]
