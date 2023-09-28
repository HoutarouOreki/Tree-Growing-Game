class_name FollowTargetAction extends WalkToTargetAction


func _init() -> void:
	target_type = TargetType.Node


func before_run(actor: Node, blackboard: Blackboard) -> void:
	var dog: Dog = actor as Dog
	target = dog.dog_owner
	super.before_run(actor, blackboard)


func tick(actor: Node, blackboard: Blackboard) -> int:
	super.tick(actor, blackboard)
	return RUNNING
