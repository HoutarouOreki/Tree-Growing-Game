@tool
class_name GoToFetchable extends WalkToTargetAction


func get_target(actor: Node) -> Node3D:
	var dog: Dog = actor as Dog
	return dog.targeted_fetchable


func is_successful(actor: Node) -> bool:
	var dog: Dog = actor as Dog
	if !dog.fetchable_collection_area.has_overlapping_bodies():
		return false

	var bodies = dog.fetchable_collection_area.get_overlapping_bodies()
	return bodies.has(dog.targeted_fetchable)
