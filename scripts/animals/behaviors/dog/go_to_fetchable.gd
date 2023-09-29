@tool
class_name GoToFetchable extends WalkToTargetAction


func before_run(actor: Node, blackboard: Blackboard) -> void:
	super.before_run(actor, blackboard)
	var dog: Dog = actor as Dog
	dog.play_woof()


func tick(actor: Node, blackboard: Blackboard) -> int:
	var dog: Dog = actor as Dog
	if !dog.current_sound || !dog.current_sound.playing:
		dog.play_woof()
	return super.tick(actor, blackboard)


func get_target(actor: Node) -> Node3D:
	var dog: Dog = actor as Dog
	return dog.targeted_fetchable


func is_successful(actor: Node) -> bool:
	var dog: Dog = actor as Dog
	if !dog.fetchable_collection_area.has_overlapping_bodies():
		return false

	var bodies = dog.fetchable_collection_area.get_overlapping_bodies()
	return bodies.has(dog.targeted_fetchable)
