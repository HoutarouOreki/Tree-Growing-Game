class_name Dog extends Animal


@onready var commands_control: DogCommandsControl = $DogCommandsControl as DogCommandsControl
var state: DogState = DogState.Idle

@export var dog_owner: Player


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


enum DogState {
	Idle,
	Sitting,
	Following,
	BeingRecalled
}
