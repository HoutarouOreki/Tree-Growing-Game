@tool
extends MarginContainer


@export var itemsCategory: PlayerItemsCategory
@onready var boxContainer: BoxContainer = $MarginContainer/VBoxContainer/BoxContainer
@onready var label: Label = $MarginContainer/VBoxContainer/Label


func _ready() -> void:
	generate_layout()


func generate_layout() -> void:
	for child in boxContainer.get_children():
		boxContainer.remove_child(child)
		child.queue_free()

	label.text = itemsCategory.name

	for item in itemsCategory.items:
		var uiSlot = (preload("res://ui/storage_ui_slot.tscn") as PackedScene).instantiate() as StorageUiSlot
		uiSlot.set_params(64, 4, item, false)
		boxContainer.add_child(uiSlot)
