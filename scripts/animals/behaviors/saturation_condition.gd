class_name SaturationCondition extends ConditionLeaf


@export_range(0.0, 100.0, 1) var required_saturation: float


func tick(actor: Node, blackboard: Blackboard) -> int:
	var dog: Dog = actor as Dog
	if dog.hunger_saturation >= required_saturation:
		return SUCCESS
	return FAILURE
