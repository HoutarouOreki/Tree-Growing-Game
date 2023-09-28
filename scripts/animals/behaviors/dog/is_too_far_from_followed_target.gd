class_name IsTooFarFromFollowedTarget extends ConditionLeaf


@export_range(0.1, 100, 0.1, "or_greater") var inner_range: float
@export_range(0.1, 100, 0.1, "or_greater") var outer_range: float


var needs_to_reach_inner: bool


func tick(actor: Node, _blackboard: Blackboard) -> int:
	var dog: Dog = actor as Dog
	var following_node = dog.dog_owner
	var distance = dog.global_position.distance_to(following_node.global_position)

	if distance <= inner_range:
		needs_to_reach_inner = false

	if needs_to_reach_inner && distance > inner_range:
		return SUCCESS
	elif distance > outer_range:
		needs_to_reach_inner = true
		return SUCCESS

	return FAILURE
