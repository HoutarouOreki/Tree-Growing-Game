class_name IsWhistled extends ConditionLeaf


func tick(actor: Node, _blackboard: Blackboard) -> int:
	var dog: Dog = actor
	print(dog.whistled_by_player)
	if dog.whistled_by_player:
		return SUCCESS
	else:
		return FAILURE
