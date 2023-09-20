extends Control


@onready var vboxContainer: VBoxContainer = $MarginContainer/VBoxContainer


func _ready() -> void:
		(SaveManager.current_save as GameSave).items.item_gained.connect(on_item_gained)


func on_item_gained(name: String, amount: int) -> void:
	var label = (preload("res://ui/new_items_toast_label.tscn") as PackedScene).instantiate() as NewItemsToastLabel
	label.text = name + " +" + str(amount)
	vboxContainer.add_child(label)
