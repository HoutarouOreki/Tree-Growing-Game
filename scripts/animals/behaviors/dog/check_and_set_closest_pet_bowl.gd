class_name CheckAndSetClosestPetBowl extends ConditionLeaf


func tick(actor: Node, blackboard: Blackboard) -> int:
	var filled_bowls = get_filled_bowls()
	if !filled_bowls || filled_bowls.size() == 0:
		blackboard.erase_value("closest_filled_pet_bowl")
		return FAILURE

	var dog: Dog = actor as Dog
	var dog_pos = dog.global_position
	filled_bowls.sort_custom(func(a: PetBowl, b: PetBowl):
		return a.global_position.distance_squared_to(dog_pos) < b.global_position.distance_squared_to(dog_pos)
	)

	blackboard.set_value("closest_filled_pet_bowl", filled_bowls.front())
	return SUCCESS


func get_filled_bowls() -> Array[PetBowl]:
	var bowls = get_tree().get_nodes_in_group("pet_bowls")
	var filled_bowls: Array[PetBowl] = []

	for _bowl in bowls:
		var bowl = _bowl as PetBowl
		if bowl.is_filled():
			filled_bowls.append(bowl)

	return filled_bowls
