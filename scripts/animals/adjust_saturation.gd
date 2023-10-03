class_name AdjustSaturationAction extends ActionLeaf


@export_range(-100, 100, 1) var saturation_change: float


func tick(actor: Node, blackboard: Blackboard) -> int:
	var dog: Dog = actor as Dog
	dog.hunger_saturation += saturation_change
	return SUCCESS
