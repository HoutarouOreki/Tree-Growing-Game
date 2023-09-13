extends CanvasLayer


@onready var animation_player: AnimationPlayer = $AnimationPlayer


func change_scene(path: String) -> void:
	animation_player.play("transition")
	await animation_player.animation_finished
	get_tree().change_scene_to_file(path)
	animation_player.play_backwards("transition")


func advance_day(player: Player) -> void:
	player.disabled = true
	SaveManager.current_save.advance_day()
	SaveManager.store()
	Transition.change_scene("res://scenes/world_scene.tscn")
