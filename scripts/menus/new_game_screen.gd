extends Control


@onready var name_input: LineEdit = $MarginContainer/VBoxContainer/VBoxContainer/HBoxContainer/NameTextEdit
@export_file("*.tscn") var world_scene: String


func _on_create_button_pressed() -> void:
	SaveManager.create_save(name_input.text)
	TransitionManager.change_scene(world_scene)
