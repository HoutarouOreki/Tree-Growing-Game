@tool
class_name WalkToTargetAction extends AnimationAction

var last_blackboard: Blackboard
var animal: Animal
@export var max_speed: float = 1
@export var acceleration: float = 4
@export var desired_distance_to_target: float = 2
@export var teleport_to_closest_navigation_point: bool
@export var impossible_to_reach_time_threshold_s: float = 8.0

@export var target_type: TargetType = TargetType.Random:
	set (value):
		target_type = value
		notify_property_list_changed()

var random_target_distance: float = 10
var target: Node3D
var impossible_to_reach_current: float = 0


func _get_property_list() -> Array[Dictionary]:
	var properties: Array[Dictionary] = []
	if target_type == TargetType.Random:
		properties.append({
			"name": "random_target_distance",
			"type": TYPE_FLOAT,
			"usage": PROPERTY_USAGE_DEFAULT
		})
	elif target_type == TargetType.Node:
		properties.append({
			"name": "target",
			"type": TYPE_NODE_PATH,
		})

	return properties


func before_run(actor: Node, blackboard: Blackboard) -> void:
	last_blackboard = blackboard
	impossible_to_reach_current = 0
	animal = actor
	animal.max_velocity = max_speed
	animal.acceleration_amount = acceleration
	super.before_run(actor, blackboard)
	if target_type == TargetType.Random:
		try_generate_new_random_target()
	else:
		animal.navigation_agent.target_position = get_target(actor, blackboard).global_position


func try_generate_new_random_target() -> bool:
	for i in range(10):
		if new_target_attempt():
			return true

	animal.navigation_agent.target_position = animal.position
	return false


func new_target_attempt() -> bool:
	var ten_meters = Vector3(0, 0, random_target_distance).rotated(Vector3.UP, deg_to_rad(randf() * 360))
	var new_target = animal.global_position + ten_meters
	new_target = NavigationServer3D.map_get_closest_point(animal.navigation_agent.get_navigation_map(), new_target)
	animal.navigation_agent.target_position = new_target
	return animal.navigation_agent.is_target_reachable()


func after_run(actor: Node, blackboard: Blackboard) -> void:
	animal.acceleration_direction = Vector2.ZERO
	animal.acceleration_amount = 0


func interrupt(actor: Node, blackboard: Blackboard) -> void:
	after_run(actor, blackboard)


func tick(actor: Node, blackboard: Blackboard) -> int:
	last_blackboard = blackboard
	if is_successful(actor, blackboard):
		return SUCCESS

	teleport_if_needed()

	if impossible_to_reach_current > impossible_to_reach_time_threshold_s:
		return FAILURE

	if target_type == TargetType.Node && animal.navigation_agent.target_position.distance_squared_to(get_target(actor, blackboard).global_position) > 1:
		animal.navigation_agent.target_position = get_target(actor, blackboard).global_position

	var next_path_position: Vector3 = animal.navigation_agent.get_next_path_position()
	var current_agent_position: Vector3 = animal.global_position
	var new_accel: Vector3 = (next_path_position - current_agent_position).normalized()
	animal.acceleration_direction = Animal.to_v2(new_accel)
	return RUNNING


func teleport_if_needed() -> void:
	if !teleport_to_closest_navigation_point:
		return

	const teleport_distance_to_map_threshold = 0.5

	if !animal.navigation_agent.is_target_reachable():
		animal.global_position = animal.navigation_agent.target_position
		animal.velocity = Vector3.ZERO
		return

	var nav_map_rid = animal.navigation_agent.get_navigation_map()
	var closest_point_on_map = NavigationServer3D.map_get_closest_point(nav_map_rid, animal.global_position)
	var distance = animal.global_position.distance_to(closest_point_on_map)
	if distance > teleport_distance_to_map_threshold:
		animal.global_position = closest_point_on_map + Vector3.UP * teleport_distance_to_map_threshold
		animal.velocity = Vector3.ZERO


func get_target(actor: Node, blackboard: Blackboard) -> Node3D:
	return target


func _physics_process(delta: float) -> void:
	if animal && get_target(animal, last_blackboard) && is_impossible_to_reach(animal, last_blackboard):
		impossible_to_reach_current += delta
	else:
		impossible_to_reach_current = 0


func is_successful(actor: Node, blackboard: Blackboard) -> bool:
	var pos = animal.navigation_agent.target_position

	if target_type == TargetType.Node:
		pos = get_target(actor, blackboard).global_position

	return pos.distance_to(animal.global_position) <= desired_distance_to_target


func is_impossible_to_reach(actor: Node, blackboard: Blackboard) -> bool:
	if !animal.navigation_agent.is_target_reachable():
		return true

	if target_type == TargetType.Node:
		var nav_map_rid = animal.navigation_agent.get_navigation_map()
		var targets_position = get_target(actor, blackboard).global_position
		var closest_point_on_map = NavigationServer3D.map_get_closest_point(nav_map_rid, targets_position)
		return closest_point_on_map.distance_to(targets_position) >= desired_distance_to_target

	return false


enum TargetType { Random, Node }
