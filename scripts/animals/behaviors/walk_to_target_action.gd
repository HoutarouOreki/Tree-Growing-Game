class_name WalkToTargetAction extends AnimationAction

var animal: Animal
var reached: bool
@export var max_speed: float = 1
@export var acceleration: float = 4
@export var new_target_distance: float = 10
var previous_max_speed: float
var previous_acceleration: float


func before_run(actor: Node, blackboard: Blackboard) -> void:
	animal = actor
	previous_max_speed = animal.max_velocity
	previous_acceleration = animal.acceleration_amount
	animal.max_velocity = max_speed
	animal.acceleration_amount = acceleration
	super.before_run(actor, blackboard)
	reached = !try_generate_new_target()


func try_generate_new_target() -> bool:
	for i in range(10):
		if new_target_attempt():
			return true

	return false


func new_target_attempt() -> bool:
	var ten_meters = Vector3(0, 0, new_target_distance).rotated(Vector3.UP, deg_to_rad(randf() * 360))
	var new_target = animal.global_position + ten_meters
	new_target = NavigationServer3D.map_get_closest_point(animal.navigation_agent.get_navigation_map(), new_target)
	animal.navigation_agent.target_position = new_target
	return animal.navigation_agent.is_target_reachable()


func after_run(actor: Node, blackboard: Blackboard) -> void:
	(actor as Animal).acceleration_direction = Vector2.ZERO
	(actor as Animal).max_velocity = previous_max_speed
	(actor as Animal).acceleration_amount = previous_acceleration
	animal = null


func interrupt(actor: Node, blackboard: Blackboard) -> void:
	after_run(actor, blackboard)


func tick(actor: Node, blackboard: Blackboard) -> int:
	if !animal || animal.navigation_agent.is_navigation_finished():
		reached = true
		after_run(actor, blackboard)
		return SUCCESS

	var next_path_position: Vector3 = animal.navigation_agent.get_next_path_position()
	var current_agent_position: Vector3 = animal.global_position
	var new_accel: Vector3 = (next_path_position - current_agent_position).normalized()
	animal.acceleration_direction = animal.to_v2(new_accel)
	return RUNNING
