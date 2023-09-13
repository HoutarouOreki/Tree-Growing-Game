extends GenericItemPlacement

const preview_transparency = 0.7
const preview_node_name = "preview tree"

func _place(position: Vector3, collider: Node3D) -> void:
	var scene_resource = load("res://scenes/prepared_ground.tscn")
	var instance = scene_resource.instantiate() as Node3D
	instance.position = position
	get_tree().current_scene.add_child(instance)
	PopUpManager.add(instance)


func _getCollisionMask() -> int:
	return pow(2, 2)


func _getAvoidanceMask() -> int:
	return 0xFFFF & ~_getCollisionMask()


func _start_preview(position: Vector3, collider: Node3D):
	var scene_resource = load("res://scenes/ground_cursor.tscn")
	var instance = scene_resource.instantiate() as Node3D
	FadeManager.set_transparency(instance, preview_transparency)
	collider.add_child(instance)
	instance.name = preview_node_name


func _preview(position: Vector3, collider: Node3D):
	var previewNode = collider.find_child(preview_node_name, false, false) as Node3D
	if !previewNode:
		return

	previewNode.global_position = position


func _stop_preview(collider: Node3D):
	remove_preview(collider)


func remove_preview(collider: Node3D):
	var previewNode = collider.find_child(preview_node_name, false, false)
	if !previewNode:
		return

	collider.remove_child(previewNode)
	previewNode.queue_free()
