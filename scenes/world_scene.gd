extends Node3D


var save: Save


func _enter_tree() -> void:
	if !SaveManager.current_save && !SaveManager.load_save("default"):
		SaveManager.create_save("default")


func _ready() -> void:
	var plant_nodes = PlantManager.generate_plant_nodes()
	for plantNode in plant_nodes:
		add_child(plantNode, true)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("save_game"):
		SaveManager.store()
		get_viewport().set_input_as_handled()
