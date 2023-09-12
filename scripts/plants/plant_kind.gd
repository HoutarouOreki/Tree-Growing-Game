class_name PlantKind extends Resource


const _plant_models_folder_path = "res://assets/models/plants/"


## The kind's name for displaying in-game.
@export var name: String

## Each plant kind has growth stages.
## This array defines each stage's length in days.
@export var stages_lengths: Array[int]

## The relative path,
## without [constant PlantKind._plant_models_folder_path].
@export var path: String


## The folder in which this plant kind's files are located.
func get_folder_path():
	return _plant_models_folder_path + path


func get_model_path(stage: int) -> String:
	if stage == 0:
		return _plant_models_folder_path + "Stage0.glb"
	return get_folder_path() + "Stage" + stage + ".glb"


func stages_count() -> int:
	return stages_lengths.size() + 1
