class_name ExecuteFunctionAction extends ActionLeaf


@export var function_name: StringName
@export var arguments: Array = []


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.callv(function_name, arguments)
	return SUCCESS
