class_name PlantNode extends Node3D


var data: PlantData


static func create(data: PlantData) -> PlantNode:
	var node = PlantNode.new()
	node.data = data
	node.global_position = data.position

	var model = load(data.get_model_path()).instantiate()
	model.name = "Model"
	node.add_child(model)

	return node
