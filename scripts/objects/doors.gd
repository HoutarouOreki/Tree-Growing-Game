extends Node3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var area_forwards: Area3D = $DoorAreaForwards
@onready var area_backwards: Area3D = $DoorAreaBackwards

var state: State = State.closed:
	get:
		return state
	set (value):
		var old_value = state
		state = value
		on_state_change(old_value, value)


func get_animation_name(forwards: bool):
	return "door_animation" if forwards else "door_animation_mirrored"


func _on_door_area_entered(body: Node3D, forwards: bool) -> void:
	if state != State.closed:
		return

	state = State.opened_forwards if forwards else State.opened_backwards


func _on_door_area_exited(body: Node3D) -> void:
	if area_forwards.overlaps_body(body) || area_backwards.overlaps_body(body):
		return

	state = State.closed


func on_state_change(old_state: State, new_state: State) -> void:
	match new_state:
		State.closed:
			var forwards = old_state == State.opened_forwards
			var animation_name = get_animation_name(forwards)
			animation_player.play_backwards(animation_name)
		State.opened_forwards:
			animation_player.play(get_animation_name(true))
		State.opened_backwards:
			animation_player.play(get_animation_name(false))


enum State {closed, opened_forwards, opened_backwards}


func _on_door_area_forwards_entered(body: Node3D, extra_arg_0: bool) -> void:
	pass # Replace with function body.
