class_name ColliderAndPoint extends Resource

var collider: CollisionObject3D
var point: Vector3

static func create(collider, point) -> ColliderAndPoint:
	var c = ColliderAndPoint.new()
	c.collider = collider
	c.point = point
	return c
