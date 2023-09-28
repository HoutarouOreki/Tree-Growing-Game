class_name Dog extends Animal


@onready var commands_control: DogCommandsControl = $DogCommandsControl as DogCommandsControl
@onready var fetchable_container: Node3D = $RootNode/AnimalArmature/Skeleton3D/BoneAttachment3D/FetchableContainer as Node3D
@onready var fetchable_collection_area: Area3D = $FetchableCollectionArea as Area3D

@export var dog_owner: Player

var state: DogState = DogState.Idle:
	get:
		return state
	set (value):
		if value != DogState.Fetching:
			drop_fetchable()
		state = value

var targeted_fetchable: RigidBody3D


func on_whistle() -> void:
	state = DogState.BeingRecalled


func on_follow() -> void:
	state = DogState.Following


func on_sit() -> void:
	state = DogState.Sitting


func set_idle() -> void:
	state = DogState.Idle


func interact(player: Player) -> void:
	commands_control.show()


func on_fetchable_thrown(fetchable: Node3D) -> void:
	if targeted_fetchable:
		return
	targeted_fetchable = fetchable
	state = DogState.Fetching


func pick_up_fetchable() -> void:
	targeted_fetchable.get_parent().remove_child(targeted_fetchable)
	fetchable_container.add_child(targeted_fetchable)
	targeted_fetchable.position = Vector3.ZERO
	targeted_fetchable.set_physics_process(false)


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
	targeted_fetchable.set_physics_process(true)
	targeted_fetchable = null

	for child in fetchable_container.get_children():
		fetchable_container.remove_child(child)


enum DogState {
	Idle,
	Sitting,
	Following,
	BeingRecalled,
	Fetching,
}
