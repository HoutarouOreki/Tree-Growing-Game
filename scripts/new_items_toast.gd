extends Control


@export var playerItems: PlayerItems
@onready var vboxContainer: VBoxContainer = $MarginContainer/VBoxContainer


func _ready() -> void:
	if playerItems:
		playerItems.item_gained.connect(on_item_gained)


func on_item_gained(name: String, amount: int) -> void:
	var label = (preload("res://ui/new_items_toast_label.tscn") as PackedScene).instantiate() as NewItemsToastLabel
	label.text = name + " +" + str(amount)
	vboxContainer.add_child(label)
