extends BaseItem


func action(player: Player, event: InputEvent):
	var ball_scene: PackedScene = preload("res://scenes/objects/tennis_ball.tscn")
	var ball: RigidBody3D = ball_scene.instantiate()

	var look_transform = player.get_look_transform()
	ball.position = look_transform.origin + look_transform.basis * Vector3.FORWARD
	ball.linear_velocity = look_transform.basis * (Vector3.FORWARD * 20)

	get_tree().current_scene.add_child(ball)
