extends Node

const saves_directory = "user://saves/"


@export var current_save: Save


func _ready() -> void:
	if !DirAccess.dir_exists_absolute(saves_directory):
		DirAccess.make_dir_absolute(saves_directory)


## Returns local [Save]s in chronological order, starting from most recent.
func get_saves() -> Array[Save]:
	var arr: Array[Save] = []

	for file in DirAccess.get_files_at(saves_directory):
		arr.append(ResourceLoader.load(saves_directory + file))

	arr.sort_custom(func (a: Save, b: Save):
		return a.save_date >= b.save_date
	)

	return arr


func store() -> void:
	current_save.save_date = Time.get_datetime_string_from_system(false, true)
	ResourceSaver.save(current_save, saves_directory + current_save.name + ".tres")


func load_save(name: String) -> bool:
	name = name.trim_suffix(".tres")
	current_save = ResourceLoader.load(saves_directory + name + ".tres")

	return current_save != null


func create_save(name: String) -> void:
	current_save = Save.new()
	current_save.name = _make_safe_name(name)
	store()


func _make_safe_name(name: String) -> String:
	name = name.strip_edges()

	var forbiddenNames = ["con", "prn", "aux", "nul", "com1", "com2", "com3", "com4", "com5", "com6", "com7", "com8", "com9", "lpt1", "lpt2", "lpt3", "lpt4", "lpt5", "lpt6", "lpt7", "lpt8", "lpt9"]
	if forbiddenNames.has(name.to_lower()):
		name = "default name"

	var takenNames = []
	for save in get_saves():
		takenNames.append(save.name)

	if takenNames.has(name):
		var appendixNumber = 2
		while takenNames.has(name + " " + str(appendixNumber)):
			appendixNumber += 1
		return name + " " + str(appendixNumber)

	return name
