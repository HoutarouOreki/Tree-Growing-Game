class_name AxableTree extends StaticBody3D


const FALLING_TIME: float = 1.5


var timeSinceAxed: float
var startTransform: Transform3D
var targetTransform: Transform3D


func _process(delta: float) -> void:
	if !targetTransform:
		return

	if timeSinceAxed >= FALLING_TIME:
		queue_free()
		return

	timeSinceAxed += delta
	var eased_progress = ease(timeSinceAxed / FALLING_TIME, 3)

	transform = startTransform.interpolate_with(targetTransform, eased_progress)


func axe(player: Player):
	collision_layer = 0
	var fallingRotationAxis = player.get_basis_vertically_locked().z.normalized()
	startTransform = transform
	targetTransform = transform
	targetTransform.basis = startTransform.basis.rotated(fallingRotationAxis, deg_to_rad(90))
