class_name TransitionCanvasLayer extends CanvasLayer


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var colorRect: ColorRect = $ColorRect


func change_scene(fn: Callable) -> void:
	colorRect.mouse_filter = Control.MOUSE_FILTER_STOP
	animation_player.play("transition")
	await animation_player.animation_finished
	fn.call()
	get_tree().paused = false
	animation_player.play_backwards("transition")
	await animation_player.animation_finished
	colorRect.mouse_filter = Control.MOUSE_FILTER_IGNORE
