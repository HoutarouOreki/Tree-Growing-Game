@tool
class_name GenericItemPlacement extends Node3D


var last_collider: Node3D


func get_collider_and_point(player: Player) -> ColliderAndPoint:
	var collider = player.itemRay.get_collider() as CollisionObject3D
	var position = player.itemRay.get_collision_point()

	if !collider:
		return null

	if collider.collision_layer & _getAvoidanceMask() != 0:
		return null

	return ColliderAndPoint.create(collider, position)


func process(player: Player):
	var info = get_collider_and_point(player)

	if !info:
		if last_collider:
			if !is_instance_valid(last_collider):
				last_collider = null
			_stop_preview(last_collider)
			last_collider = null
		return

	if info.collider != last_collider:
		if last_collider:
			if !is_instance_valid(last_collider):
				last_collider = null
			_stop_preview(last_collider)
		last_collider = info.collider
		_start_preview(position, last_collider)

	_preview(info.point, info.collider)


func action(player: CharacterBody3D, event: InputEvent):
	var info = get_collider_and_point(player)

	if info:
		_place(info.point, info.collider)


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


func start_process(player: Player):
	player.itemRay.collision_mask = _getCollisionMask() | _getAvoidanceMask()


func stop_process(player: CharacterBody3D):
	if !last_collider:
		return
		
	if !is_instance_valid(last_collider):
		last_collider = null

	_stop_preview(last_collider)
	last_collider = null
