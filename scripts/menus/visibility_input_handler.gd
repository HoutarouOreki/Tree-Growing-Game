class_name VisibilityInputHandler extends Node


var parent: Control
@export var invisible_on_load: bool = true
var previous_mouse_mode: Input.MouseMode
@export var closing_actions: Array[String] = ["ui_cancel"]


func _ready() -> void:
	parent = get_parent()
	parent.visibility_changed.connect(onVisibilityChanged)
	if invisible_on_load:
		parent.visible = Engine.is_editor_hint()


func onVisibilityChanged() -> void:
	parent.set_process_unhandled_input(parent.visible)
	set_process_unhandled_input(parent.visible)
	if parent.visible:
		previous_mouse_mode = Input.mouse_mode
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE if parent.visible else previous_mouse_mode


func _unhandled_input(event: InputEvent) -> void:
	for closing_action in closing_actions:
		if event.is_action(closing_action) && Input.is_action_just_pressed(closing_action):
			get_viewport().set_input_as_handled()
			parent.hide()
			break
