class_name FirstPersonCamera extends Camera3D

@export_range(0.0, 1.0) var sensitivity: float = 0.25
@onready var neck: Node3D = $".."
@onready var player: Player = $"../.."

# Mouse state
var _mouse_position = Vector2(0.0, 0.0)
var _total_pitch = 0.0


func _input(event):
	# Receives mouse motion
	if event is InputEventMouseMotion:
		_mouse_position = event.relative


# Updates mouselook and movement every frame
func _process(delta):
	if player.disabled:
		return

	var yaw_pitch = Vector2.ZERO
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		yaw_pitch += _get_mouselook()
	yaw_pitch += _get_joystick_look(delta)

	_update_look(yaw_pitch)


func _get_mouselook() -> Vector2:
	_mouse_position *= sensitivity
	var yaw = _mouse_position.x
	var pitch = _mouse_position.y
	_mouse_position = Vector2(0, 0)
	return Vector2(yaw, pitch)


func _get_joystick_look(delta: float) -> Vector2:
	var vector = Input.get_vector("look_left", "look_right", "look_up", "look_down")
	const speed: float = 170.0

	var yaw = vector.x * delta * speed
	var pitch = vector.y * delta * speed

	return Vector2(yaw, pitch)


func _update_look(yaw_pitch: Vector2) -> void:
	var yaw = yaw_pitch.x

	# Prevents looking up/down too far
	var pitch = clamp(yaw_pitch.y, -90 - _total_pitch, 90 - _total_pitch)
	_total_pitch += pitch

	neck.rotate_y(deg_to_rad(-yaw))
	rotate_object_local(Vector3(1,0,0), deg_to_rad(-pitch))
