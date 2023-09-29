class_name AnimalFootsteps extends AudioStreamPlayer3D


@onready var animal: Animal = $".." as Animal

var interval: float

var sound0 = load("res://assets/sounds/footsteps/footstep_grass_000.ogg") as AudioStream
var sound1 = load("res://assets/sounds/footsteps/footstep_grass_001.ogg") as AudioStream
var sound2 = load("res://assets/sounds/footsteps/footstep_grass_002.ogg") as AudioStream
var sound3 = load("res://assets/sounds/footsteps/footstep_grass_003.ogg") as AudioStream
var sound4 = load("res://assets/sounds/footsteps/footstep_grass_004.ogg") as AudioStream
var sounds = [sound0, sound1, sound2, sound3, sound4]

var since_last_play = 0.0

var playing_footsteps: bool = false


func _get_configuration_warnings() -> PackedStringArray:
	if !animal:
		return ["Should be child of an Animal"]
	return []


func start_playing_footsteps():
	playing_footsteps = true


func stop_playing_footsteps():
	playing_footsteps = false
	since_last_play = interval + 0.4


func play_footsteps_sound():
	var sound = sounds.pick_random()
	stream = sound
	play()


func _process(delta):
	var speed = animal.velocity2.length()

	if !playing_footsteps:
		if speed > 0.4:
			start_playing_footsteps()
		return

	if speed <= 0.4:
		stop_playing_footsteps()
		return

	interval = 1 / (speed)

	if since_last_play == 0:
		play_footsteps_sound()

	since_last_play += delta

	if since_last_play > interval:
		since_last_play = 0
