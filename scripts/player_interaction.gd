extends Node

@onready var player: Player = $".."
@onready var interactionRay: RayCast3D = $"../Neck/Camera3D/InteractionRay"


func _unhandled_input(event: InputEvent) -> void:
	if player.disabled:
		return
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_RIGHT):
		interact()


func interact():
	var collider = interactionRay.get_collider()
	if collider && collider.has_method("interact"):
		collider.call("interact", player)
