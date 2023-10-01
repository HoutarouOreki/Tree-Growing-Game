class_name ThrowableBaseItem extends BaseItem


func action(player: Player, event: InputEvent):
	var throw_packed_scene: PackedScene = preload("res://scenes/minigames/throwing_minigame_scene.tscn")
	var throw_scene: ThrowingMinigameScene = throw_packed_scene.instantiate()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	throw_scene.thrown.connect(func(vel: Vector2):
		var velocity = _compute_velocity(vel)
		var angular_velocity = _compute_angular_velocity(vel)
		create_body(player, velocity, angular_velocity)
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		throw_scene.queue_free()
	)
	player.add_child(throw_scene)


func create_body(player: Player, velocity: Vector2, angular_velocity: Vector3):
	var body = _get_throwable_body()

	var look_transform = player.get_look_transform()
	body.position = look_transform.origin + look_transform.basis * Vector3.FORWARD
	body.linear_velocity = look_transform.basis * Vector3(velocity.x, velocity.y, -velocity.y)
	body.angular_velocity = look_transform.basis * angular_velocity

	get_tree().current_scene.add_child(body)
	_body_thrown(body)


func _compute_velocity(in_velocity: Vector2) -> Vector2:
	return in_velocity


func _compute_angular_velocity(in_velocity: Vector2) -> Vector3:
	return Vector3(randf(), randf(), randf())


func _get_throwable_body() -> RigidBody3D:
	return null


func _body_thrown(body: RigidBody3D) -> void:
	pass
