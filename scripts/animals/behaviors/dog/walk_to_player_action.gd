class_name WalkToPlayerAction extends WalkToTargetAction


func before_run(actor: Node, blackboard: Blackboard) -> void:
	var dog: Dog = actor as Dog
	target = dog.whistled_by_player
	super.before_run(actor, blackboard)


func tick(actor: Node, blackboard: Blackboard) -> int:
	var dog: Dog = actor as Dog

	var result = super.tick(actor, blackboard)
	if result == SUCCESS:
		dog.whistled_by_player = null

	return result
