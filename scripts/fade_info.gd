class_name FadeInfo extends Object

var node: Node3D
var from: float
var to: float
var duration_s: float
var progress_s: float = 0.0
var remove_on_complete: bool

static func create(node: Node3D, from: float, to: float, duration_s: float, remove_on_complete: bool) -> FadeInfo:
	var fadeInfo = FadeInfo.new()
	fadeInfo.node = node
	fadeInfo.from = from
	fadeInfo.to = to
	fadeInfo.duration_s = duration_s
	fadeInfo.remove_on_complete = remove_on_complete
	return fadeInfo
