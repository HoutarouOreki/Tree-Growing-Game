@tool
class_name GenericItemPlacement extends Node3D


var collider: Node3D


func process(player: CharacterBody3D):
	var camera = get_viewport().get_camera_3d()
	var mousePos = get_viewport().get_mouse_position()
	var rayLength = 3
	var rayQuery = PhysicsRayQueryParameters3D.new()
	rayQuery.from = camera.project_ray_origin(mousePos)
	rayQuery.to = rayQuery.from + camera.project_ray_normal(mousePos) * rayLength
	rayQuery.collision_mask = _getCollisionMask() + _getAvoidanceMask()
	var space = get_world_3d().direct_space_state
	var result = space.intersect_ray(rayQuery)

	if result.is_empty() || (result["collider"] as CollisionObject3D).collision_layer & _getAvoidanceMask() != 0:
		if collider:
			_stop_preview(collider)
			collider = null
		return

	if result["collider"] != collider:
		if collider:
			_stop_preview(collider)
		collider = result["collider"]
		_start_preview(result["position"], collider)

	_preview(result["position"], result["collider"])


func action(player: CharacterBody3D, event: InputEvent):
	var camera = get_viewport().get_camera_3d()
	var mousePos = get_viewport().get_mouse_position()
	var rayLength = 3
	var rayQuery = PhysicsRayQueryParameters3D.new()
	rayQuery.from = camera.project_ray_origin(mousePos)
	rayQuery.to = rayQuery.from + camera.project_ray_normal(mousePos) * rayLength
	rayQuery.collision_mask = _getCollisionMask() + _getAvoidanceMask()
	var space = get_world_3d().direct_space_state
	var result = space.intersect_ray(rayQuery)
	if !result.is_empty():
		if (result["collider"] as CollisionObject3D).collision_layer & _getAvoidanceMask() == 0:
			_place(result["position"], result["collider"])


func _getCollisionMask() -> int:
	return 0xFFFF


func _getAvoidanceMask() -> int:
	return 0


func _place(position: Vector3, collider: Node3D) -> void:
	pass


func _preview(position: Vector3, collider: Node3D):
	pass


func _start_preview(position: Vector3, collider: Node3D):
	pass


func _stop_preview(collider: Node3D):
	pass


func stop_process(player: CharacterBody3D):
	if !collider:
		return

	_stop_preview(collider)
	collider = null
