class_name IsWhistled extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	var dog: Dog = actor
	if dog.whistled_by_player:
		return SUCCESS
	else:
		return FAILURE
