class_name PlantNode extends StaticBody3D


@export var data: PlantData
@onready var selectionMesh: MeshInstance3D = $SelectionMesh


static func create(plantData: PlantData) -> PlantNode:
	var scene = (load("res://scenes/plants/plant_node.tscn") as PackedScene).instantiate()
	scene.data = plantData
	scene.position = plantData.position

	var model = (load(plantData.get_model_path()) as PackedScene).instantiate()
	model.name = "Model"
	scene.add_child(model)

	return scene
