@tool
class_name WalkToPlayerAction extends WalkToTargetAction


func get_target(actor: Node) -> Node3D:
	var dog: Dog = actor as Dog
	return dog.dog_owner
