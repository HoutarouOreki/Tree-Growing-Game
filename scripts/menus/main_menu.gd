extends Control


@export var playScene: PackedScene
@export var optionsScene: PackedScene


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_play_button_pressed() -> void:
	Transition.change_scene_packed(playScene)


func _on_options_button_pressed() -> void:
	Transition.change_scene_packed(optionsScene)
