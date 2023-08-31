extends CharacterBody3D


const SPEED = 2.8
const ACCELERATION = 30.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var neck := $Neck
@export var storage: Storage

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backwards")
	var direction = (neck.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()

	var new_velocity = velocity.move_toward(direction * SPEED if direction else Vector3.ZERO, ACCELERATION * delta)

	if (new_velocity * Vector3(input_dir.x, 0, input_dir.y)).is_zero_approx():
		FootstepsManager.stop_playing()
	else:
		FootstepsManager.start_playing(self)

	velocity.x = new_velocity.x
	velocity.z = new_velocity.z

	move_and_slide()


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		interact()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE):
		$"../DayCycle".seek(6)


func interact():
	var camera = get_viewport().get_camera_3d()
	var mousePos = get_viewport().get_mouse_position()
	var rayLength = 3
	var rayQuery = PhysicsRayQueryParameters3D.new()
	rayQuery.from = camera.project_ray_origin(mousePos)
	rayQuery.to = rayQuery.from + camera.project_ray_normal(mousePos) * rayLength
	var space = get_world_3d().direct_space_state
	var result = space.intersect_ray(rayQuery)
	if !result.is_empty():
		var obj = result["collider"] as CollisionObject3D
		if obj.has_method("interact"):
			obj.interact()
