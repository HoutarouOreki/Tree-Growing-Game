class_name ExecuteFunctionAction extends ActionLeaf


@export var function_name: StringName


func tick(actor: Node, blackboard: Blackboard) -> int:
	actor.call(function_name)
	return SUCCESS
