@tool
class_name StorageItem extends Resource

@export var name: String
@export var texture: Texture2D
@export_range(1, 9999, 1) var count: int
@export var actionScript: Script

func action(player: Player, event: InputEvent):
	if !actionScript:
		return

	var instance = get_or_create_instance(player)
	instance.call("action", player, event)


func start_process(player: Player):
	if !actionScript:
		return

	var instance = get_or_create_instance(player)
	instance.call("start_process", player)


func process(player: Player):
	if !actionScript:
		return

	var instance = get_or_create_instance(player)
	instance.call("process", player)


func stop_process(player: Player):
	if !actionScript:
		return

	var instance = player.find_child(name, false, false)
	if !instance:
		return

	instance.call("stop_process", player)

	player.remove_child(instance)
	instance.queue_free()


func get_or_create_instance(player: Player):
	var instance = player.find_child(name, false, false)
	if !instance:
		instance = actionScript.new()
		player.add_child(instance)
		instance.name = self.name

	return instance
