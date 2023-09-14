extends Control


@export_file("*.tscn") var main_menu_scene: String


func _on_resume_button_pressed() -> void:
	unpause()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		unpause()
		get_viewport().set_input_as_handled()


func unpause() -> void:
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	hide()


func _on_exit_button_pressed() -> void:
	Transition.change_scene("res://scenes/menus/main_menu.tscn")
