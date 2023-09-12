extends Node

const saves_directory = "user://saves/"


var current_save: Save


func _ready() -> void:
	if !DirAccess.dir_exists_absolute(saves_directory):
		DirAccess.make_dir_absolute(saves_directory)


func get_saves() -> Array[Save]:
	var arr: Array[Save] = []

	for file in DirAccess.get_files_at(saves_directory):
		arr.append(ResourceLoader.load(saves_directory + file))

	return arr


func store() -> void:
	ResourceSaver.save(current_save, saves_directory + current_save.name + ".tres")


func load_save(name: String) -> bool:
	name = name.trim_suffix(".tres")
	current_save = ResourceLoader.load(saves_directory + name + ".tres")

	return current_save != null


func create_save(name: String) -> void:
	current_save = Save.new()
	current_save.name = name
