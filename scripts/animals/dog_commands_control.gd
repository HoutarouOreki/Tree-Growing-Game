@tool
class_name DogCommandsControl extends Control


@onready var dog: Dog = $".." as Dog:
	set (value):
		dog = value
		notify_property_list_changed()

var player: Player


func _get_configuration_warnings() -> PackedStringArray:
	if !dog:
		return ["Should be a child of a Dog node."]
	return []


func _on_sit_button_pressed() -> void:
	dog.on_sit()
	hide()


func _on_follow_button_pressed() -> void:
	dog.on_follow()
	hide()


func _on_free_button_pressed() -> void:
	dog.set_idle()
	hide()
