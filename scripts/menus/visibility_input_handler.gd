class_name VisibilityInputHandler extends Node


var parent: Control


func _ready() -> void:
	parent = get_parent()
	parent.visibility_changed.connect(onVisibilityChanged)
	onVisibilityChanged()


func onVisibilityChanged() -> void:
	parent.set_process_unhandled_input(parent.visible)
	set_process_unhandled_input(parent.visible)
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if parent.visible else Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action("ui_cancel") && Input.is_action_just_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		parent.hide()
