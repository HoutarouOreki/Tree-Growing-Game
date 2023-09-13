class_name Save extends Resource


@export var name: String
@export var plants: Array[PlantData] = []
@export var save_date: String

## Where the player will spawn when the scene loads.
@export var player_position: Vector3


func advance_day() -> void:
	for plant in plants:
		plant.day += 1
