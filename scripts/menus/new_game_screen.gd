extends Control


@onready var name_input: LineEdit = $MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/NameTextEdit
@export var world_scene: PackedScene


func _on_create_button_pressed() -> void:
	SaveManager.create_save(name_input.text)
	Transition.change_scene_packed(world_scene)
