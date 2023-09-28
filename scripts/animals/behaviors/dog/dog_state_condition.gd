class_name DogStateCondition extends ConditionLeaf


@export var state: Dog.DogState


func tick(actor: Node, _blackboard: Blackboard) -> int:
	var dog: Dog = actor as Dog
	if dog.state == state:
		return SUCCESS
	else:
		return FAILURE
