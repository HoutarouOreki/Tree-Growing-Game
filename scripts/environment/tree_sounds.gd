class_name TreeSounds extends Node3D

signal break_sound_finished


@onready var hit_sounds: Array[AudioStreamPlayer3D] = [$HitSound1, $HitSound2]
@onready var break_sounds: Array[AudioStreamPlayer3D] = [$BreakSound1, $BreakSound2, $BreakSound3]
@onready var fall_sounds: Array[AudioStreamPlayer3D] = [$FallSound]


func play_hit():
	_play_random_from(hit_sounds)


func play_break():
	_play_random_from(break_sounds)


func play_fall():
	var sound = _play_random_from(fall_sounds)
	await sound.finished
	break_sound_finished.emit()


func _play_random_from(arr: Array[AudioStreamPlayer3D]) -> AudioStreamPlayer3D:
	var sound = arr.pick_random() as AudioStreamPlayer3D
	sound.play()
	return sound
