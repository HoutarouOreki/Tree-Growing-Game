class_name FirstPersonCamera extends Camera3D

@export_range(0.0, 1.0) var sensitivity: float = 0.25
@onready var neck := $".."
@onready var player = $"../.."

# Mouse state
var _mouse_position = Vector2(0.0, 0.0)
var _total_pitch = 0.0

func _input(event):
	# Receives mouse motion
	if event is InputEventMouseMotion:
		_mouse_position = event.relative

	if event is InputEventMouseButton:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	elif event.is_action_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

# Updates mouselook and movement every frame
func _process(_delta):
	if !player.disabled && Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		_update_mouselook()

func _update_mouselook():
	_mouse_position *= sensitivity
	var yaw = _mouse_position.x
	var pitch = _mouse_position.y
	_mouse_position = Vector2(0, 0)

	# Prevents looking up/down too far
	pitch = clamp(pitch, -90 - _total_pitch, 90 - _total_pitch)
	_total_pitch += pitch

	neck.rotate_y(deg_to_rad(-yaw))
	rotate_object_local(Vector3(1,0,0), deg_to_rad(-pitch))
