class_name GrowingTree extends Node3D

var stages_lengths = [5, 5, 5, 5, 5]
var current_stage = -1
var stage_lifetime_remaining = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	stage_lifetime_remaining = stages_lengths[0]
	next_stage()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if current_stage == stages_lengths.size():
		return

	stage_lifetime_remaining -= delta
	if stage_lifetime_remaining <= 0.0:
		next_stage()


func next_stage():
	current_stage += 1

	if current_stage != stages_lengths.size():
		stage_lifetime_remaining = stages_lengths[current_stage]

	var modelContainer = $ModelContainer

	for child in modelContainer.get_children():
		FadeManager.fade_out(child, 2, true)

	var formatPath = "res://assets/models/trees/TreeStage{stage_number}.glb"
	var path = formatPath.format({"stage_number": current_stage})
	var newChild = load(path).instantiate()
	FadeManager.fade_in(newChild, 2)

	modelContainer.add_child(newChild)
