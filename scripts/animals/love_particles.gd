class_name LoveParticles extends GPUParticles3D


@onready var animal: Animal = $".."
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(func(): emitting = false)


func emit_for(seconds: float) -> void:
	emitting = true
	timer.start(seconds)


func set_color(color: Color) -> void:
	var material = process_material as ParticleProcessMaterial
	material.color = color
	var surface_material = draw_pass_1.surface_get_material(0) as StandardMaterial3D
	surface_material.emission = color


func _physics_process(delta: float) -> void:
	@warning_ignore("unsafe_cast")
	var material = process_material as ParticleProcessMaterial
	if animal.velocity.is_zero_approx():
		material.damping_min = 0
		material.damping_max = 0
		material.initial_velocity_min = 0.2
		material.initial_velocity_max = 0.4
		material.direction = Vector3.UP
		material.spread = 90
	else:
		var speed = animal.velocity.length()
		material.damping_min = speed / 4
		material.damping_max = speed / 4
		material.direction = Vector3.BACK
		material.spread = 0
		material.initial_velocity_min = speed / 2
		material.initial_velocity_max = speed / 2
