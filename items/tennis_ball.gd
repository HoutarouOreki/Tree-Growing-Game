extends BaseItem


func action(player: Player, event: InputEvent):
	var throw_packed_scene: PackedScene = preload("res://scenes/minigames/throwing_minigame_scene.tscn")
	var throw_scene: ThrowingMinigameScene = throw_packed_scene.instantiate()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	throw_scene.thrown.connect(func(vel: Vector2):
		var velocity = (vel * Vector2(30, 30)).clamp(Vector2(-10, 2), Vector2(10, 30))
		create_ball(player, velocity)
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	)
	player.add_child(throw_scene)


func create_ball(player: Player, velocity: Vector2):
	var ball_scene: PackedScene = preload("res://scenes/objects/tennis_ball.tscn")
	var ball: RigidBody3D = ball_scene.instantiate()

	var look_transform = player.get_look_transform()
	ball.position = look_transform.origin + look_transform.basis * Vector3.FORWARD
	ball.linear_velocity = look_transform.basis * Vector3(velocity.x, velocity.y, -velocity.y)

	get_tree().current_scene.add_child(ball)

	for node in get_tree().get_nodes_in_group(&"dogs"):
		var dog: Dog = node as Dog
		dog.on_fetchable_thrown(ball)
