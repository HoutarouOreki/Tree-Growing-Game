extends ThrowableBaseItem


func _get_throwable_body() -> RigidBody3D:
	var ball_scene: PackedScene = preload("res://scenes/objects/tennis_ball.tscn")
	var ball: RigidBody3D = ball_scene.instantiate()
	return ball


func _body_thrown(body: RigidBody3D) -> void:
	for node in get_tree().get_nodes_in_group(&"dogs"):
		var dog: Dog = node as Dog
		dog.on_fetchable_thrown(body)


func _compute_velocity(in_velocity: Vector2) -> Vector2:
	return (in_velocity * Vector2(30, 30)).clamp(Vector2(-10, 2), Vector2(10, 30))
