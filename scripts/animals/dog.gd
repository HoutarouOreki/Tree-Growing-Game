class_name Dog extends Animal


@onready var commands_control: DogCommandsControl = $DogCommandsControl as DogCommandsControl
@onready var fetchable_container: Node3D = $RootNode/AnimalArmature/Skeleton3D/BoneAttachment3D/FetchableContainer as Node3D
@onready var fetchable_collection_area: Area3D = $FetchableCollectionArea as Area3D
@onready var love_particles: LoveParticles = $LoveParticles as LoveParticles

@export var dog_owner: Player

var woofs_sounds: Array[AudioStreamPlayer3D]
var panting_sounds: Array[AudioStreamPlayer3D]
var woof_sounds: Array[AudioStreamPlayer3D]
var current_sound: AudioStreamPlayer3D

var state: DogState = DogState.Idle:
	get:
		return state
	set (value):
		if value != DogState.Fetching && value != DogState.Snacking:
			drop_fetchable()
		state = value

var targeted_fetchable: RigidBody3D
var love: float


func _ready() -> void:
	for node in $"Sounds".get_children():
		if node.name.begins_with("WoofSound"):
			woof_sounds.append(node)
		elif node.name.begins_with("WoofsSound"):
			woofs_sounds.append(node)
		elif node.name.begins_with("PantingSound"):
			panting_sounds.append(node)


func on_whistle() -> void:
	state = DogState.BeingRecalled


func on_follow() -> void:
	state = DogState.Following


func on_sit() -> void:
	state = DogState.Sitting


func on_pet() -> void:
	emit_love(Color.GOLD)


func set_idle() -> void:
	state = DogState.Idle


func interact(player: Player) -> void:
	var radial_menu: DogRadialMenu = DogRadialMenu.new(self)
	add_child(radial_menu)


func on_fetchable_thrown(fetchable: Node3D) -> void:
	if targeted_fetchable:
		return
	targeted_fetchable = fetchable
	state = DogState.Fetching


func on_snack_thrown(snack: Node3D) -> void:
	if targeted_fetchable:
		return
	targeted_fetchable = snack
	state = DogState.Snacking


func pick_up_fetchable() -> void:
	targeted_fetchable.get_parent().remove_child(targeted_fetchable)
	fetchable_container.add_child(targeted_fetchable)
	targeted_fetchable.freeze = true
	targeted_fetchable.position = Vector3.ZERO
	targeted_fetchable.rotation = Vector3.ZERO


func drop_fetchable() -> void:
	if fetchable_container.get_child_count() == 0:
		targeted_fetchable = null
		return

	var position = targeted_fetchable.global_position
	var forward_a_bit = basis * (Vector3.FORWARD * -0.5)
	position += forward_a_bit
	if fetchable_container.get_child_count() > 0:
		fetchable_container.remove_child(targeted_fetchable)
		get_tree().current_scene.add_child(targeted_fetchable)
	targeted_fetchable.global_position = position
	targeted_fetchable.linear_velocity = Vector3.ZERO
	targeted_fetchable.angular_velocity = Vector3.ZERO
	targeted_fetchable.freeze = false
	targeted_fetchable = null

	for child in fetchable_container.get_children():
		fetchable_container.remove_child(child)


func eat_target(saturation: float) -> void:
	fetchable_container.remove_child(targeted_fetchable)
	targeted_fetchable.queue_free()
	targeted_fetchable = null


func play_woof() -> void:
	if current_sound:
		current_sound.stop()
	current_sound = AudioHelper.play_random_from(woof_sounds)


func play_panting() -> void:
	current_sound = AudioHelper.play_random_from(panting_sounds)


func emit_love(color: Color) -> void:
	love_particles.set_color(color)
	love_particles.emit_for(3)
	love += 2


enum DogState {
	Idle,
	Sitting,
	Following,
	BeingRecalled,
	Fetching,
	Snacking,
}
