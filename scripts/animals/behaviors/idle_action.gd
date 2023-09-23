class_name IdleAction extends ActionLeaf

var animation_list: Array[String] = []


func before_run(actor: Node, blackboard: Blackboard) -> void:
	var animal: Animal = actor
	for animationName in animal.animations.get_animation_list():
		var animation_name: String = animationName
		if animation_name.contains("Idle"):
			animation_list.append(animation_name)


func tick(actor: Node, blackboard: Blackboard) -> int:
	var animal: Animal = actor
	if !animal.animations.is_playing():
		animal.animations.play(animation_list.pick_random())
	return RUNNING
