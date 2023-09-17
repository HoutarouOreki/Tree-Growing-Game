extends Node3D


func interact(player: Player):
	SaveManager.current_save.player_position = player.position
	TransitionManager.advance_day(player)
