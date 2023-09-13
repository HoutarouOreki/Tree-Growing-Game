extends Node3D


func interact(player: Player):
	SaveManager.current_save.player_position = player.position
	Transition.advance_day(player)
