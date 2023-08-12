extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if Input.is_action_just_pressed("use_item"):
		var camera = get_viewport().get_camera_3d()
		var mousePos = get_viewport().get_mouse_position()
		var rayLength = 3
		var rayQuery = PhysicsRayQueryParameters3D.new()
		rayQuery.from = camera.project_ray_origin(mousePos)
		rayQuery.to = rayQuery.from + camera.project_ray_normal(mousePos) * rayLength
		var space = get_world_3d().direct_space_state
		var result = space.intersect_ray(rayQuery)
		print(result)
		if !result.is_empty():
			on_plant(result["position"])

func on_plant(position: Vector3):
	var scene_resource = load("res://assets/models/trees/TreeStage0.glb")
	var instance = scene_resource.instantiate() as Node3D
	instance.position = position
	get_tree().root.add_child(instance)
	FadeInManager.add(instance)
