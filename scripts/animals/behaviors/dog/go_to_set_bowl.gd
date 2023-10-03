@tool
class_name GoToSetPetBowl extends WalkToTargetAction


func get_target(actor: Node, blackboard: Blackboard) -> Node3D:
	return blackboard.get_value("closest_filled_pet_bowl") as PetBowl


func tick(actor: Node, blackboard: Blackboard) -> int:
	if !get_target(actor, blackboard):
		return FAILURE

	return super.tick(actor, blackboard)
