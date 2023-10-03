class_name EmptyBowlAction extends ActionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	var bowl = blackboard.get_value("closest_filled_pet_bowl") as PetBowl
	blackboard.erase_value("closest_filled_pet_bowl")
	bowl.eat_up()
	return SUCCESS
