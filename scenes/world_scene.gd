extends Node3D


func _enter_tree() -> void:
	if !SaveManager.current_save && !SaveManager.load_save("default"):
		SaveManager.create_save("default")


func _ready() -> void:
	var plant_nodes = PlantManager.generate_plant_nodes()
	for plantNode in plant_nodes:
		add_child(plantNode, true)
