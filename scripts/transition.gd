extends CanvasLayer


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var colorRect: ColorRect = $ColorRect


func change_scene(path: String) -> void:
	colorRect.mouse_filter = Control.MOUSE_FILTER_STOP
	animation_player.play("transition")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(path)
	animation_player.play_backwards("transition")
	await animation_player.animation_finished
	colorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE


func change_scene_packed(scene: PackedScene) -> void:
	colorRect.mouse_filter = Control.MOUSE_FILTER_STOP
	animation_player.play("transition")
	await animation_player.animation_finished
	get_tree().change_scene_to_packed(scene)
	animation_player.play_backwards("transition")
	await animation_player.animation_finished
	colorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE


func advance_day(player: Player) -> void:
	player.disabled = true
	SaveManager.current_save.advance_day()
	SaveManager.store()
	Transition.change_scene("res://scenes/world_scene.tscn")
