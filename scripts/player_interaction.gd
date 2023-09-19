extends Node

@onready var player: Player = $".."
@onready var interactionRay: RayCast3D = $"../Neck/Camera3D/InteractionRay"


func _unhandled_input(event: InputEvent) -> void:
	if player.disabled:
		return

	if InputHelper.is_action_press("interact", event):
		get_viewport().set_input_as_handled()
		interact()


func interact():
	var collider = interactionRay.get_collider()
	if collider && collider.has_method("interact"):
		collider.call("interact", player)
