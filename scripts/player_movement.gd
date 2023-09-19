extends Node


@onready var player: Player = $".."
@onready var neck: Node3D = $"../Neck"

const SPEED = 2.8
const ACCELERATION = 30.5
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):

	# Add the gravity.
	if not player.is_on_floor():
		player.velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	var movement_vector = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var input_dir = Vector2.ZERO if player.disabled else movement_vector
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var new_velocity = player.velocity.move_toward(
		direction * SPEED if direction else Vector3.ZERO,
		ACCELERATION * delta
	) * movement_vector.length()

	if (new_velocity * Vector3(input_dir.x, 0, input_dir.y)).is_zero_approx():
		FootstepsManager.stop_playing()
	else:
		FootstepsManager.start_playing(player)

	player.velocity.x = new_velocity.x
	player.velocity.z = new_velocity.z

	player.move_and_slide()

