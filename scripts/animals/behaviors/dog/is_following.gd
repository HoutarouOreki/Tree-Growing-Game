class_name IsFollowing extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	var dog: Dog = actor as Dog
	if dog.following_target:
		return SUCCESS
	else:
		return FAILURE
