class_name Save extends Resource


@export var name: String
@export var plants: Array[PlantData] = []
@export var save_date: String
@export var day: int

## Where the player will spawn when the scene loads.
@export var player_position: Vector3


func advance_day() -> void:
	day += 1
	for plant in plants:
		plant.day += 1
