class_name AudioHelper extends Node


static func play_random_from(arr: Array[AudioStreamPlayer3D]) -> AudioStreamPlayer3D:
	var sound = arr.pick_random() as AudioStreamPlayer3D
	sound.play()
	return sound
