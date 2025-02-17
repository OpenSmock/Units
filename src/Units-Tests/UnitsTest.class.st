Class {
	#name : 'UnitsTest',
	#superclass : 'TestCase',
	#category : 'Units-Tests',
	#package : 'Units-Tests'
}

{ #category : 'testing' }
UnitsTest >> testAdd [
	"Adding or subtracting units does appropriate conversions."
	| u |
	u :=  (14 units: #foot) + (10 units: #metre).
	self assert: (u printString = '46.80839895013123 feet').

]

{ #category : 'testing' }
UnitsTest >> testCompare [
	"Unit values can also be compared (provided they are dimensionally consistent."
	self assert: ((1 units: #inch) < (3 units: #centimetre)).

]

{ #category : 'testing' }
UnitsTest >> testConvert [
	"You can also explicitly convert values."
	| u |
	u :=  (15 units: #mile) / (1 units: #hour)
				convertTo: (Unit metre / Unit second).
	self assert: (u printString = '6.7056 metres per second').

]

{ #category : 'testing' }
UnitsTest >> testCreate [
	"Create unit values by sending #units: to a number."
	| u |
	u := 2 units: #inch.
	self assert: (u printString = '2 inches').

]

{ #category : 'testing' }
UnitsTest >> testCreateAdditionalUnit [
	"Creating additional units is easy:"
	| microfortnight |
	microfortnight := PrefixedUnit
		prefixName: 'micro'
		unit: (DerivedUnit
			abbreviation: 'FN'
			name: 'fortnight'
			pluralName: 'fortnights'
				value: (14 units: #days)).

	self assert: ((1 units: microfortnight) baseUnits asString = '(756/625) seconds').
]

{ #category : 'testing' }
UnitsTest >> testDivide [
	"You can divide unit values."
	| u |
	u :=  (2 units: #inch) / (3 units: #second).
	self assert: (u printString = '(2/3) inches per second').

]

{ #category : 'testing' }
UnitsTest >> testEqual [
	"Test different equality"

	self assert: 2 g equals: 2.
	self deny: 2 g equals: 3.
	self deny: 2 L equals: 2 g.
	self
		assertCollection: {
				1 g.
				2 g.
				3 g.
				4 g }
		hasSameElements: {
				3 g.
				4 g.
				2 g.
				1g }.
	self
		assertCollection: {
				1 g.
				2 g.
				3 g.
				'toto' }
		includesAll: { 'toto' }.
	self
		denyCollection: {
				1 g.
				2 g.
				3 g.
				4 g }
		includesAny: { 'toto' }
]

{ #category : 'testing' }
UnitsTest >> testExpand [
	"You can expand 'derived' units  into base SI units."
	| u |
	u :=  (3 units: #newton) baseUnits.
	self assert: (u printString = '3 kilogram metres per square second').
	
	"To see grams rather than kilograms, factor with respect to grams."
	u := (3 units: #newton) factor: Unit gram.
	self assert: (u printString = '3000 gram metres per square second').

]

{ #category : 'testing' }
UnitsTest >> testNewton [
	"You can use 'derived' units such as the newton."
	| u |
	u :=  3 units: #newton.
	self assert: (u printString = '3 newtons').

]

{ #category : 'testing' }
UnitsTest >> testReduce [
	self assert: 5 km / 5000 m equals: 1
]

{ #category : 'testing' }
UnitsTest >> testSqrt [
	"if we take the root of a squared unit, we need to make sure to reduce the 
	unit and not use a ComplexUnit"
	self assert: (2 units: Unit km squared) sqrt unit class equals: PrefixedUnit
]
