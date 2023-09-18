extends Node3D


func interact(player: Player):
	(SaveManager.current_save as GameSave).player_position = player.global_position
	(SaveManager.current_save as GameSave).neck_rotation_deg_y = player.neck.rotation_degrees.y + 180
	TransitionManager.advance_day(player)
