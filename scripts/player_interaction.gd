extends Node

@onready var player: Player = $".."
@onready var interactionRay: RayCast3D = $"../Neck/Camera3D/InteractionRay"


func _unhandled_input(event: InputEvent) -> void:
	if player.disabled:
		return
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		interact()
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_MIDDLE) && player.day_night_player:
		player.day_night_player.seek(6)


func interact():
	var collider = interactionRay.get_collider()
	if collider && collider.has_method("interact"):
		collider.interact(player)
