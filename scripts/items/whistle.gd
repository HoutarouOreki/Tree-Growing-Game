class_name Whistle extends BaseItem


@onready var audio_player: AudioStreamPlayer


func _enter_tree() -> void:
	audio_player = AudioStreamPlayer.new()
	audio_player.stream = preload("res://assets/sounds/items/whistle.mp3")
	audio_player.bus = "footsteps"
	add_child(audio_player)


func action(player: Player, event: InputEvent):
	audio_player.play()
	for node in get_tree().get_nodes_in_group(&"dogs"):
		var dog: Dog = node
		dog.on_whistle(player)
