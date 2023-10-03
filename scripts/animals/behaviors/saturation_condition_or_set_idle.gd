class_name SaturationConditionOrSetIdle extends SaturationCondition


func tick(actor: Node, blackboard: Blackboard) -> int:
	var result = super.tick(actor, blackboard)

	if result == FAILURE:
		(actor as Dog).set_idle()

	return result
