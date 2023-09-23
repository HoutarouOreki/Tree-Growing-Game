class_name AnimationAction extends ActionLeaf


@export var animations: Array[String] = []
@export var animation_node: AnimationPlayer


func tick(actor: Node, blackboard: Blackboard) -> int:
	var animal: Animal = actor
	if !animal.animations.is_playing():
		animal.animations.play(animations.pick_random(), 0.2)
	return RUNNING


func before_run(actor: Node, blackboard: Blackboard) -> void:
	var animal: Animal = actor
	animal.animations.play(animations.pick_random(), 0.2)
