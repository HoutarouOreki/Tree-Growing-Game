@tool
extends Control


@export var storage: Storage


func _ready() -> void:
	visible = Engine.is_editor_hint()
