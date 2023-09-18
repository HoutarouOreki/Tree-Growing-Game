extends Control


@export_file("*.tscn") var main_menu_scene: String


func onVisibilityChanged() -> void:
	get_tree().paused = visible


func _ready() -> void:
	visibility_changed.connect(onVisibilityChanged)
	onVisibilityChanged()


func _on_resume_button_pressed() -> void:
	hide()


func _on_exit_button_pressed() -> void:
	TransitionManager.change_scene("res://scenes/menus/main_menu.tscn")
