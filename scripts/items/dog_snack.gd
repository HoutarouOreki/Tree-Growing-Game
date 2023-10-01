extends ThrowableBaseItem


func _get_throwable_body() -> RigidBody3D:
	var scene: PackedScene = preload("res://scenes/objects/dog_treat.tscn")
	var obj: RigidBody3D = scene.instantiate()
	return obj


func _body_thrown(body: RigidBody3D) -> void:
	for node in get_tree().get_nodes_in_group(&"dogs"):
		var dog: Dog = node as Dog
		dog.on_snack_thrown(body)


func _compute_velocity(in_velocity: Vector2) -> Vector2:
	return (in_velocity * Vector2(30, 30)).clamp(Vector2(-10, 2), Vector2(10, 30))


func _compute_angular_velocity(in_velocity: Vector2) -> Vector3:
	var angular_speed = randf() * 4
	return Vector3(angular_speed, angular_speed, angular_speed)
