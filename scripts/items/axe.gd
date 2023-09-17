extends GenericItemPlacement


func _getCollisionMask() -> int:
	return int(pow(2, 20))


func _place(position: Vector3, collider: Node3D, player: Player) -> void:
	collider.call("axe", player)


func _start_preview(position: Vector3, collider: Node3D, player: Player):
	var plantNode = collider as PlantNode
	if plantNode:
		plantNode.selectionMesh.visible = true


func _stop_preview(collider: Node3D, player: Player):
	if !collider:
		return

	var plantNode = collider as PlantNode
	if plantNode:
		plantNode.selectionMesh.visible = false
