extends Control


@export_file("*.tscn") var playScene: String
@export_file("*.tscn") var optionsScene: String


func _on_exit_button_pressed() -> void:
	get_tree().quit()


func _on_play_button_pressed() -> void:
	Transition.change_scene(playScene)


func _on_options_button_pressed() -> void:
	Transition.change_scene(optionsScene)
