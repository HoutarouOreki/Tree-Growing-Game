extends CanvasLayer


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var colorRect: ColorRect = $ColorRect


func change_scene(path: String) -> void:
	_change_scene(func ():
		get_tree().change_scene_to_file(path)
	)


func change_scene_packed(scene: PackedScene) -> void:
	_change_scene(func ():
		get_tree().change_scene_to_packed(scene)
	)


func reload_scene() -> void:
	_change_scene(func() :
		get_tree().reload_current_scene()
	)


func _change_scene(fn: Callable) -> void:
	colorRect.mouse_filter = Control.MOUSE_FILTER_STOP
	animation_player.play("transition")
	await animation_player.animation_finished
	fn.call()
	animation_player.play_backwards("transition")
	await animation_player.animation_finished
	colorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE


func advance_day(player: Player) -> void:
	player.disabled = true
	SaveManager.current_save.advance_day()
	SaveManager.store()
	Transition.reload_scene()
