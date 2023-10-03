class_name ExecuteBoolFunction extends ConditionLeaf


@export var function_name: StringName
@export var arguments: Array = []


func tick(actor: Node, blackboard: Blackboard) -> int:
	var result = actor.callv(function_name, arguments)

	if result:
		return SUCCESS
	return FAILURE
