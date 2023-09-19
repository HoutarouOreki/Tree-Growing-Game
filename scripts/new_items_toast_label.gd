class_name NewItemsToastLabel extends Control


@onready var animations: AnimationPlayer = $AnimationPlayer
@onready var timer: Timer = $Timer
@onready var label: Label = $Label
@export var text: String:
	get:
		return text
	set (value):
		text = value
		if label:
			label.text = value


func _ready() -> void:
	label.text = text
	animations.play("fade_in")
	timer.start()
	await timer.timeout
	delete()


func delete() -> void:
	animations.play_backwards("fade_in")
	animations.queue("shrink")
	await animations.animation_finished
	if !Engine.is_editor_hint():
		queue_free()
