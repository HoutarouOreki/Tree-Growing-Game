class_name PlantData extends Resource


@export var kind: PlantKind
@export var day: int
@export var position: Vector3


func get_stage() -> int:
	var days_left = day
	var stage = -1

	while days_left >= 0 && stage < kind.stages_lengths.size():
		days_left -= kind.stages_lengths[stage]
		stage += 1

	return stage


func get_model_path() -> String:
	return kind.get_model_path(get_stage())
