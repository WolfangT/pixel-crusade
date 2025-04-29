extends Node

const PIXEL_SIZE := 0.0048
const HEROIC_SCALE := 57.2
const W_H_RATIO := 1.4

# Basic Variables
@export var ModelName: String
@export var CustomName: String
@export var MovementDistance: int
@export var BaseSize: String # In mm
@export var MovementType: String
@export var RangeCharacteristic: DiceModifier
@export var MeleeCharacteristic: DiceModifier
@export var ArmorCharacteristic: DiceModifier
@export var KeywordsList: Array[String]
@export var CharacterSprite2D: CompressedTexture2D


func _init() -> void:
	pass
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var base_model := _get_base_model(BaseSize)
	var base_size = _get_base_size(BaseSize)
	if $Pivot/Base.mesh == null and base_model != null:
		$Pivot/Base.mesh = load(base_model)
		$Pivot/Base.scale.x = HEROIC_SCALE / 1000
		$Pivot/Base.scale.y = HEROIC_SCALE / 1000
		$Pivot/Base.scale.z = HEROIC_SCALE / 1000
	if $Pivot/Sprite2D.texture == null and CharacterSprite2D != null:
		$Pivot/Sprite2D.texture = CharacterSprite2D
	$Pivot/Sprite2D.pixel_size = PIXEL_SIZE
	$Pivot/Sprite2D.position.y = base_size * W_H_RATIO * HEROIC_SCALE / 2
	$CollisionShape3D.shape.radius = base_size / 2 * HEROIC_SCALE
	$CollisionShape3D.shape.height = base_size * 1.4 * HEROIC_SCALE
	$CollisionShape3D.position.y = base_size * 0.7 * HEROIC_SCALE * W_H_RATIO / 2
	
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


# Utility functions
func _get_base_model(size: String) -> String:
	match size:
		"25":
			return "res://assets/bases/base_25.glb"
		"32":
			return "res://assets/bases/base_32.obj"
		"40":
			return "res://assets/bases/base_40.glb"
		"50":
			return "res://assets/bases/base_50.glb"
		"50":
			return "res://assets/bases/base_60.glb"
		"30x60":
			return "res://assets/bases/base_30x60.glb"
	return ""

func _get_base_size(size: String) -> float:
	match size:
		"25":
			return 25.0 / 1000
		"32":
			return 32.0 / 1000
		"40":
			return 40.0 / 1000
		"50":
			return 50.0 / 1000
		"50":
			return 60.0 / 1000
		"30x60":
			return 60.0 / 1000
	push_error("Not valid size of %s" % size)
	return 0
