class_name AnimationAction extends ActionLeaf


@export var animations: Array[String] = []
@export_range(0.01, 10, 0.1, "suffix:x") var animation_speed_multiplier: float = 1


func tick(actor: Node, blackboard: Blackboard) -> int:
	var animal: Animal = actor
	if !animal.animations.is_playing():
		animal.animations.play(animations.pick_random(), 0.2, animation_speed_multiplier)
	return RUNNING


func before_run(actor: Node, blackboard: Blackboard) -> void:
	var animal: Animal = actor
	animal.animations.play(animations.pick_random(), 0.2, animation_speed_multiplier)
