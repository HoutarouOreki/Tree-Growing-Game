class_name Animal extends CharacterBody3D

@onready var navigation_agent: NavigationAgent3D = $"NavigationAgent3D"
@onready var model: Node3D = $CollisionShape3D

@onready var animations: AnimationPlayer = $AnimationPlayer
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


@export var max_velocity: float = 1.5
@export var acceleration_amount: float = 4
var acceleration_direction: Vector2
var current_speed: float = 0.0


var velocity2: Vector2:
	get:
		return Animal.to_v2(velocity)
	set (value):
		velocity.x = value.x
		velocity.z = value.y


func _init() -> void:
	safe_margin = 0.01


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += Vector3(0, -delta * gravity, 0)

	adjust_velocity(delta)
	if !velocity.is_zero_approx() && velocity2 != Vector2.ZERO:
		look_at(global_position + velocity, Vector3.UP, true)

	move_and_slide()


func adjust_velocity(delta: float) -> void:
	if !acceleration_direction.is_zero_approx():
		velocity2 += acceleration_direction * acceleration_amount * delta
		velocity2 = velocity2.limit_length(max_velocity)
		return

	if velocity2.is_zero_approx():
		velocity2 = Vector2.ZERO
		return

	var new_length = maxf(0, velocity2.length() - acceleration_amount * delta)
	velocity2 = velocity2.limit_length(new_length)


static func to_v2(v: Vector3) -> Vector2:
	return Vector2(v.x, v.z)


static func to_v3(v: Vector2) -> Vector3:
	return Vector3(v.x, 0, v.y)
