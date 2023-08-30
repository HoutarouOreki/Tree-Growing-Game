extends Node3D


func action(player: CharacterBody3D, event: InputEvent):
	print("h")
	var camera = get_viewport().get_camera_3d()
	var mousePos = get_viewport().get_mouse_position()
	var rayLength = 3
	var rayQuery = PhysicsRayQueryParameters3D.new()
	rayQuery.from = camera.project_ray_origin(mousePos)
	rayQuery.to = rayQuery.from + camera.project_ray_normal(mousePos) * rayLength
	rayQuery.collision_mask = 4
	var space = get_world_3d().direct_space_state
	var result = space.intersect_ray(rayQuery)
	if !result.is_empty():
		on_plant(result["position"])

func on_plant(position: Vector3):
	var scene_resource = load("res://scenes/growing_tree.tscn")
	var instance = scene_resource.instantiate() as Node3D
	instance.position = position
	get_tree().root.add_child(instance)
	PopUpManager.add(instance)
	var timer = Timer.new()
	add_child(timer)
	timer.start(0.2)
	timer.autostart = true
	await timer.timeout
	var grassScatter = get_tree().root.get_node("World Scene/GrassScatter")
	grassScatter.rebuild()
