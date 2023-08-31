@tool
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


func process(player: CharacterBody3D):
	if !actionScript:
		return

	var instance = player.find_child(name, false, false)
	if !instance:
		instance = actionScript.new()
		player.add_child(instance)
		instance.name = self.name

	instance.call("process", player)


func stop_process(player: CharacterBody3D):
	if !actionScript:
		return

	var instance = player.find_child(name, false, false)
	if !instance:
		instance = actionScript.new()
		player.add_child(instance)
		instance.name = self.name

	instance.call("stop_process", player)

	player.remove_child(instance)
	instance.queue_free()
