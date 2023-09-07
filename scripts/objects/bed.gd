extends Node3D


func interact(player: Player):
	var black = ColorRect.new()
	player.disabled = true
	black.color = Color8(0, 0, 0, 255)
	black.set_anchors_preset(Control.PRESET_FULL_RECT)
	FadeManager.fade_in(black, 1, func():
		during_transition(player, black)
	)
	add_child(black)

func during_transition(player: Player, black: ColorRect):
	var time = player.dayCycle.current_animation_position
	time += 8
	if time >= 24:
		time -= 24
	player.dayCycle.seek(time)
	FadeManager.fade_out(black, 1, true, 0, func():
		player.disabled = false
	)
