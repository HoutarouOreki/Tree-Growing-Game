class_name SaveDisplayButton extends Control


@export var save: Save
@onready var name_label: Label = $"MarginContainer/HBoxContainer/MarginContainer/NameLabel"
@onready var date_label: Label = $"MarginContainer/HBoxContainer/DateLabel"


func _ready() -> void:
	if !save:
		return

	name_label.text = save.name
	var time_dict = Time.get_datetime_dict_from_datetime_string(save.save_date, false)
	_format_time_dict(time_dict)
	date_label.text = "{year}-{month}-{day} {hour}:{minute}".format(time_dict)


func _format_time_dict(time_dict: Dictionary):
	const keys = ["month", "day", "hour", "minute"]
	for key in keys:
		_format_key(time_dict, key)


func _format_key(time_dict: Dictionary, key: StringName):
	time_dict[key] = "%02d" % time_dict[key]


func _on_button_pressed() -> void:
	SaveManager.load_save(save.name)
	Transition.change_scene("res://scenes/world_scene.tscn")
