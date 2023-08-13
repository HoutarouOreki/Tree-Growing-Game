extends Node

var infos: Array[FadeInfo] = []
var infos_to_remove: Array[int] = []


func fade_in(node: Node3D, duration_s: float):
	set_transparency(node, 1)
	infos.append(FadeInfo.create(node, 1, 0, duration_s, false))
	
	
func fade_out(node: Node3D, duration_s: float, remove_on_complete: bool):
	set_transparency(node, 0)
	infos.append(FadeInfo.create(node, 0, 1, duration_s, remove_on_complete))


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var index = 0
	for info in infos:
		var node = info.node as Node3D
		info.progress_s += delta
		if info.progress_s >= info.duration_s:
			info.progress_s = info.duration_s
			infos_to_remove.append(index)
			
		var progress = info.progress_s / info.duration_s
		var value_range = info.to - info.from
		var value = info.from + value_range * progress
		set_transparency(node, value)
		index += 1
	
	remove_completed()


func remove_completed():
	while infos_to_remove.size() > 0:
		var index = infos_to_remove.pop_back() as int
		var fadeInfo = infos.pop_at(index) as FadeInfo
		if fadeInfo.remove_on_complete:
			fadeInfo.node.queue_free()


func set_transparency(node: Node3D, transparency: float):
	var children = node.get_children()
	for child in children:
		if child.get_child_count() > 0:
			set_transparency(child, transparency)
		var mesh = child as MeshInstance3D
		if !mesh:
			continue
		mesh.transparency = transparency
