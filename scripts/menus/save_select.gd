extends Control


@onready var saves_flow_container: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/MarginContainer/SavesFlowContainer
@export var new_game_scene: PackedScene


func _ready() -> void:
	for save in SaveManager.get_saves():
		var button = load("res://scenes/menus/save_display_button.tscn").instantiate() as SaveDisplayButton
		button.save = save
		saves_flow_container.add_child(button)


func _on_new_game_button_pressed() -> void:
	Transition.change_scene_packed(new_game_scene)
