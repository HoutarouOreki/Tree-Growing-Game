class_name ThrowingMinigameScene extends Control


signal thrown(velocity: Vector2)

var selected: bool = false

var sample_interval_s: float = 0.1
var sample_duration_s: float = 1.0
var time_to_next_sample: float = 0.0
var position_samples: Array[Vector2] = []


func get_samples_count() -> int:
	return int(sample_duration_s / sample_interval_s)


func _physics_process(delta: float) -> void:
	if !selected:
		return

	if time_to_next_sample <= 0.0:
		handle_sample()

	time_to_next_sample -= delta


func _gui_input(event: InputEvent) -> void:
	if !selected && InputHelper.is_action_press("use_item", event):
		handle_start()

	if selected && InputHelper.is_action_release("use_item", event):
		handle_release()


func handle_start() -> void:
	time_to_next_sample = 0
	position_samples = []

	selected = true


func handle_sample() -> void:
	if position_samples.size() == get_samples_count():
		position_samples.pop_front()
	var pos = get_global_mouse_position()
	position_samples.push_back(pos)

	time_to_next_sample += sample_interval_s


func handle_release() -> void:
	selected = false

	var velocity_sum = Vector2.ZERO
	for i in range(position_samples.size() - 1):
		var a = position_samples[i]
		var b = position_samples[i + 1]
		var vel = (b - a) * sample_interval_s
		velocity_sum += vel

	var velocity_avg = velocity_sum / position_samples.size()
	var final_velocity = velocity_avg / get_max_velocity()
	thrown.emit(final_velocity * Vector2(1, -1))
	print(final_velocity)
	hide()


func get_max_velocity() -> Vector2:
	return get_viewport_rect().size * sample_interval_s
