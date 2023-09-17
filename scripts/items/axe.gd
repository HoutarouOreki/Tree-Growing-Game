extends GenericItemPlacement


func _getCollisionMask() -> int:
	return int(pow(2, 8))


func _place(position: Vector3, collider: Node3D) -> void:
	var plantNode = collider as PlantNode
	PlantManager.remove_plant(plantNode.data)
	plantNode.queue_free()


func _start_preview(position: Vector3, collider: Node3D):
	var plantNode = collider as PlantNode
	plantNode.selectionMesh.visible = true


func _stop_preview(collider: Node3D):
	if !collider:
		return

	var plantNode = collider as PlantNode
	plantNode.selectionMesh.visible = false
