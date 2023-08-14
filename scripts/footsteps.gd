class_name Footsteps extends Node

const INTERVAL_S = 0.4

var sound0 = load("res://assets/sounds/footsteps/footstep_grass_000.ogg") as AudioStream
var sound1 = load("res://assets/sounds/footsteps/footstep_grass_001.ogg") as AudioStream
var sound2 = load("res://assets/sounds/footsteps/footstep_grass_002.ogg") as AudioStream
var sound3 = load("res://assets/sounds/footsteps/footstep_grass_003.ogg") as AudioStream
var sound4 = load("res://assets/sounds/footsteps/footstep_grass_004.ogg") as AudioStream
var sounds = [sound0, sound1, sound2, sound3, sound4]

var since_last_play = 0.0
var playing = false
var parent: Node3D

func start_playing(parent: Node3D):
	playing = true
	self.parent = parent

func stop_playing():
	playing = false
	since_last_play = 0.8

func play():
	var stream = AudioStreamPlayer3D.new()
	stream.bus = "Footsteps"
	stream.stream = sounds.pick_random()
	# stream.max_db = -12
	stream.connect("finished", stream.queue_free)
	parent.add_child(stream)
	stream.play()

func _process(delta):
	if !playing:
		return

	if since_last_play == 0:
		play()

	since_last_play += delta

	if since_last_play > INTERVAL_S:
		since_last_play = 0

