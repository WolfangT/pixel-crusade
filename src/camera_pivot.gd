extends Node3D

## Speed of the camera 
@export var CAMERA_SPEED := 10
## Min y distance of the camera 
@export var MIN_ZOOM := 6
## Max y distance of the camera 
@export var MAX_ZOOM := 18

@export var MOUSE_SENSITIVITY := 0.5
@export var TILT_LOWER_LIMIT := deg_to_rad(-10.0)
@export var TILT_UPPER_LIMIT := deg_to_rad(80.0)

var zoom := 6.0
var _mouse_rotation := Vector2.ZERO
var _mouse_input := Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	_update_camera(delta)
	if Input.is_action_pressed("move_right"):
		position.x += CAMERA_SPEED * delta
	if Input.is_action_pressed("move_left"):
		position.x -= CAMERA_SPEED * delta
	if Input.is_action_pressed("move_back"):
		position.z += CAMERA_SPEED * delta
	if Input.is_action_pressed("move_forward"):
		position.z -= CAMERA_SPEED * delta
	if Input.is_action_just_released("zoom_in"):
		zoom -= CAMERA_SPEED * delta
	if Input.is_action_just_released("zoom_out"):
		zoom += CAMERA_SPEED * delta
	zoom = clamp(zoom, MIN_ZOOM, MAX_ZOOM)
	$Camera3D.position.y = zoom

func _unhandled_input(event):
	if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_mouse_input.x = -event.relative.x * MOUSE_SENSITIVITY
		_mouse_input.y = -event.relative.y * MOUSE_SENSITIVITY

func _update_camera(delta):
	_mouse_rotation.x += _mouse_input.x * delta
	_mouse_rotation.x = clamp(_mouse_rotation.x, TILT_UPPER_LIMIT, TILT_UPPER_LIMIT)
	_mouse_rotation.y += _mouse_input.y * delta
	_mouse_input = Vector2.ZERO
	$Camera3D.transform.basis = Basis.from_euler(Vector3(_mouse_rotation.y, 0.0, 0.0))
	#CAMERA_CONTROLLER.rotation.z = 0.0
	global_transform.basis = Basis.from_euler(Vector3(0.0, _mouse_rotation.x, 0.0))
