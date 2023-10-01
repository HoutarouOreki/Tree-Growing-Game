class_name EatAction extends AnimationAction


@export_range(0, 10, 3) var duration: float = 3.0
var running_time: float = 0.0


func before_run(actor: Node, blackboard: Blackboard) -> void:
	running_time = 0.0
	super.before_run(actor, blackboard)


func tick(actor: Node, blackboard: Blackboard) -> int:
	if running_time >= duration:
		running_time = 0.0
		return SUCCESS

	return super.tick(actor, blackboard)


func _physics_process(delta: float) -> void:
	running_time += delta
