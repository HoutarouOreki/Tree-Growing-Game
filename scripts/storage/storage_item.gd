class_name StorageItem extends Resource

@export var name: String
@export var texture: Texture2D
@export_range(1, 9999, 1) var count: int
@export var actionScript: Script

func action(player: CharacterBody3D, event: InputEvent):
	if !actionScript:
		return

	var instance = actionScript.new()
	player.add_child(instance)
	instance.call("action", player, event)
	player.remove_child(instance)
