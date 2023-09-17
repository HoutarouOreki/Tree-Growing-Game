class_name ColliderAndPoint extends Resource

var collider: CollisionObject3D
var point: Vector3

@warning_ignore("shadowed_variable")
static func create(collider: CollisionObject3D, point: Vector3) -> ColliderAndPoint:
	var c = ColliderAndPoint.new()
	c.collider = collider
	c.point = point
	return c
