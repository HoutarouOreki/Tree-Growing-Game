class_name Whistle extends BaseItem


@onready var audio_player: AudioStreamPlayer


func _enter_tree() -> void:
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = preload("res://assets/sounds/items/whistle.mp3")
	audio_player.bus = "footsteps"
	add_child(audio_player)


func action(player: CharacterBody3D, event: InputEvent):
	audio_player.play()
