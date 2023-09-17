extends Node

var objects: Array[PopUpInfo] = []
var fade_duration_s = 0.5
var total_vertical_movement = 0.1

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for object in objects:
		if object.node is Node3D:
			var node = object.node as Node3D
			object.elapsed += delta
			node.position.y += total_vertical_movement * (delta / fade_duration_s)

	while objects.size() > 0 && objects[0].elapsed >= fade_duration_s:
		objects[0].node.position = objects[0].target_position
		objects.remove_at(0)


func add(node: Node3D):
	var dic = PopUpInfo.new()
	dic.elapsed = 0.0
	dic.node = node
	dic.target_position = node.position
	node.position.y -= total_vertical_movement
	objects.push_back(dic)

