extends GenericItemPlacement

const planted_tree_node_name = "tree"
const preview_tree_node_name = "preview tree"
const preview_transparency = 0.7


func _place(position: Vector3, collider: Node3D):
	if !can_plant_here(collider):
		return

	remove_preview(collider)
	var scene_resource = load("res://scenes/plants/plant_node.tscn") as PackedScene
	var instance = scene_resource.instantiate() as Node3D
	collider.add_child(instance)
	instance.name = planted_tree_node_name
	register_plant(instance.global_position)
	PopUpManager.add(instance)


func register_plant(position: Vector3):
	var plant_data = PlantData.new()
	plant_data.kind = load("res://assets/plant_kinds/apple_tree.tres")
	plant_data.position = position
	PlantManager.add_plant(plant_data)


func can_plant_here(collider: Node3D) -> bool:
	return collider.find_child(planted_tree_node_name, false, false) == null


func _getCollisionMask() -> int:
	return int(pow(2, 3))


func _preview(position: Vector3, collider: Node3D):
	pass


func _start_preview(position: Vector3, collider: Node3D):
	var previewNode = collider.find_child(preview_tree_node_name, false, false)
	if previewNode:
		collider.remove_child(previewNode)
		previewNode.queue_free()

	if !can_plant_here(collider):
		return

	var preview_scene_resource = preload("res://assets/models/plants/apple_tree/Stage1.glb") as PackedScene
	var instance = preview_scene_resource.instantiate() as Node3D
	FadeManager.set_transparency(instance, preview_transparency)
	collider.add_child(instance)
	instance.name = preview_tree_node_name


func _stop_preview(collider: Node3D):
	remove_preview(collider)


func remove_preview(collider: Node3D):
	var previewNode = collider.find_child(preview_tree_node_name, false, false)
	if !previewNode:
		return

	FadeManager.fade_out(previewNode, 0.1, true, preview_transparency)
