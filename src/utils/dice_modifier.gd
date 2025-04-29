extends Resource
class_name DiceModifier

@export var extra := 0 # the Sum of 3, 4 or 1D6
@export var dice := 0 # Plus or minus dice
@export var fixed := 0 # Plus or minus points to the dice result

func _init(_dice:=0, _fixed:=0, _extra:=0):
	dice = _dice
	fixed = _fixed
	extra = _extra

static func sum(modifiers:Array[DiceModifier]):
	var _dice = 0
	var _fixed = 0
	var _extra = 0
	for modifier in modifiers:
		_dice += modifier.dice
		_fixed += modifier.fixed
		_extra += modifier.extra
	return DiceModifier.new(_dice, _fixed, _extra)