class_name Player extends CharacterBody3D

var disabled: bool = false

@onready var itemRay: RayCast3D = $Neck/Camera3D/ItemRay
@onready var dayCycle: AnimationPlayer = $DayCycle
@onready var pauseScreen: Control = $PauseScreen
@onready var neck: Node3D = $Neck
@onready var camera: Camera3D = $Neck/Camera3D


func get_basis_vertically_locked() -> Basis:
	return neck.basis


func _process(delta: float) -> void:
	if !disabled && dayCycle.current_animation_position > 23:
		TransitionManager.advance_day(self)


func _ready() -> void:
	dayCycle.seek(6.5)
	global_position = SaveManager.current_save.player_position
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_PAGEUP):
		dayCycle.seek(dayCycle.current_animation_position + 1)
	elif Input.is_key_pressed(KEY_PAGEDOWN):
		dayCycle.seek(dayCycle.current_animation_position - 1)
	elif Input.is_action_just_pressed("ui_cancel"):
		get_tree().paused = true
		pauseScreen.show()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		return

	get_viewport().set_input_as_handled()
