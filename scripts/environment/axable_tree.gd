class_name AxableTree extends StaticBody3D


@export var durability: int = 5

@onready var animations: AnimationPlayer = $TreeAnimations
@onready var animationContainer: Node3D = $AnimationContainer
@onready var sounds: TreeSounds = $AnimationContainer/ModelContainer/TreeSounds
var model: Node3D
var animation_direction_right: bool


func _ready() -> void:
	model = animationContainer.get_child(0).get_child(0)
	animations.animation_finished.connect(on_animation_finished)
	animation_direction_right = randi() % 2 == 1


func axe(player: Player) -> void:
	if animations.is_playing():
		return

	(sounds as TreeSounds).play_hit()

	if durability > 0:
		on_hit(player)
		return

	fall_down(player)


func fall_down(player: Player) -> void:
	collision_layer = 0
	update_rotation(player)
	animations.play("fall")
	(sounds as TreeSounds).play_break()


func on_hit(player: Player) -> void:
	durability -= 1
	update_rotation(player)
	animations.play("on_hit", -1, 1.5)


func update_rotation(player: Player) -> void:
	var player_xz = Vector2(player.global_position.x, player.global_position.z)
	var tree_xz = Vector2(global_position.x, global_position.z)
	var rotation_angle = -player_xz.angle_to_point(tree_xz) - rotation.y
	if animation_direction_right:
		rotation_angle += deg_to_rad(180)
	animationContainer.rotation.y = rotation_angle
	model.rotation.y = -rotation_angle


func on_animation_finished(animation_name: String) -> void:
	if animation_name == "fall":
		visible = false
		(sounds as TreeSounds).play_fall()
		await (sounds as TreeSounds).break_sound_finished
		queue_free()
