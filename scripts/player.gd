class_name Player extends CharacterBody3D

var disabled: bool = false

@onready var itemRay: RayCast3D = $Neck/Camera3D/ItemRay
@onready var dayCycle: AnimationPlayer = $DayCycle


func _process(delta: float) -> void:
	if !disabled && dayCycle.current_animation_position > 23:
		Transition.advance_day(self)


func _ready() -> void:
	dayCycle.seek(6.5)
	global_position = SaveManager.current_save.player_position


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_PAGEUP):
		dayCycle.seek(dayCycle.current_animation_position + 1)
	if Input.is_key_pressed(KEY_PAGEDOWN):
		dayCycle.seek(dayCycle.current_animation_position - 1)
