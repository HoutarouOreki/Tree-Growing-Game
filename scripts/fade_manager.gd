@tool
extends Node

var infos: Array[FadeInfo] = []
var infos_to_remove: Array[int] = []


func fade_in(node: Node, duration_s: float, callback: Callable = Callable()):
	set_transparency(node, 1)
	infos.append(FadeInfo.create(node, 1, 0, duration_s, false, callback))


func fade_out(node: Node, duration_s: float, remove_on_complete: bool, start_transparency: float = 0, callback: Callable = Callable()):
	set_transparency(node, 0)
	infos.append(FadeInfo.create(node, start_transparency, 1, duration_s, remove_on_complete, callback))


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var index = -1
	for info in infos:
		index += 1
		if !is_instance_valid(info.node):
			infos_to_remove.append(index)
			continue
		var node = info.node as Node
		info.progress_s += delta
		if info.progress_s >= info.duration_s:
			info.progress_s = info.duration_s
			infos_to_remove.append(index)

		var progress = info.progress_s / info.duration_s
		var value_range = info.to - info.from
		var value = info.from + value_range * progress
		set_transparency(node, value)

	remove_completed()


func remove_completed():
	while infos_to_remove.size() > 0:
		var index = infos_to_remove.pop_back() as int
		var fadeInfo = infos.pop_at(index) as FadeInfo
		if fadeInfo.callback:
			fadeInfo.callback.call()
		if fadeInfo.remove_on_complete && is_instance_valid(fadeInfo.node):
			fadeInfo.node.queue_free()


func set_transparency(node: Node, transparency: float):
	if node is Node3D:
		set_transparency_3d(node, transparency)
	elif node is CanvasItem:
		set_transparency_canvas(node, transparency)


func set_transparency_3d(node: Node3D, transparency: float):
	var children = node.get_children()
	for child in children:
		if child.get_child_count() > 0:
			set_transparency(child, transparency)
		var mesh = child as VisualInstance3D
		if !mesh:
			continue
		mesh.transparency = transparency


func set_transparency_canvas(node: CanvasItem, transparency: float):
	node.modulate.a = 1.0 - transparency
