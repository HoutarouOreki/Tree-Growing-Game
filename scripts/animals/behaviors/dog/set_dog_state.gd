class_name SetDogState extends ActionLeaf


@export var state: Dog.DogState


func tick(actor: Node, blackboard: Blackboard) -> int:
	var dog: Dog = actor as Dog
	dog.state = state
	return SUCCESS
