class_name TreeSounds extends Node3D

signal break_sound_finished


@onready var hit_sounds: Array[AudioStreamPlayer3D] = [$HitSound1, $HitSound2]
@onready var break_sounds: Array[AudioStreamPlayer3D] = [$BreakSound1, $BreakSound2, $BreakSound3]
@onready var fall_sounds: Array[AudioStreamPlayer3D] = [$FallSound]


func play_hit():
	AudioHelper.play_random_from(hit_sounds)


func play_break():
	AudioHelper.play_random_from(break_sounds)


func play_fall():
	var sound = AudioHelper.play_random_from(fall_sounds)
	await sound.finished
	break_sound_finished.emit()
