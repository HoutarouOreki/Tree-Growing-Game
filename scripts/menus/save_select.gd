extends Control


@onready var saves_flow_container: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/SavesFlowContainer
@export_file("*.tscn") var new_game_scene: String


func _ready() -> void:
	for save in SaveManager.get_saves():
		var button = (load("res://scenes/menus/save_display_button.tscn") as PackedScene).instantiate() as SaveDisplayButton
		button.save = save
		saves_flow_container.add_child(button)


func _on_new_game_button_pressed() -> void:
	TransitionManager.change_scene(new_game_scene)
