extends Node3D


var save: Save


func _ready() -> void:
	var plant_nodes = PlantManager.generate_plant_nodes()
	for plantNode in plant_nodes:
		add_child(plantNode)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("save_game"):
		PlantManager.save()
		get_viewport().set_input_as_handled()
