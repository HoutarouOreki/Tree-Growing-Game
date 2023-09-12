class_name Player extends CharacterBody3D

var disabled: bool = false

@onready var itemRay: RayCast3D = $Neck/Camera3D/ItemRay
@onready var dayCycle: AnimationPlayer = $DayCycle

func _ready() -> void:
	pass #dayCycle.seek(6)


func _unhandled_input(event: InputEvent) -> void:
	if Input.is_key_pressed(KEY_PAGEUP):
		dayCycle.seek(dayCycle.current_animation_position + 1)
	if Input.is_key_pressed(KEY_PAGEDOWN):
		dayCycle.seek(dayCycle.current_animation_position - 1)
