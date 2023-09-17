extends Node


var transitionCanvas: TransitionCanvasLayer = preload("res://scenes/transition.tscn").instantiate()


func _ready() -> void:
	add_child(transitionCanvas)


func change_scene(path: String) -> void:
	transitionCanvas.change_scene(func ():
		get_tree().change_scene_to_file(path)
	)


func change_scene_packed(scene: PackedScene) -> void:
	transitionCanvas.change_scene(func ():
		get_tree().change_scene_to_packed(scene)
	)


func reload_scene() -> void:
	transitionCanvas.change_scene(func() :
		get_tree().reload_current_scene()
	)


func advance_day(player: Player) -> void:
	player.disabled = true
	SaveManager.current_save.advance_day()
	SaveManager.store()
	TransitionManager.reload_scene()
