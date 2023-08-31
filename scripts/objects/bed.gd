extends Node3D

@export var timeManager: AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func interact():
	var time = timeManager.current_animation_position
	time += 8
	if time >= 24:
		time -= 24
	timeManager.seek(time)
