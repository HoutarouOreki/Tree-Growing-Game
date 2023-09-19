extends Control


@export var player_items: PlayerItems
@onready var vboxContainer: VBoxContainer = $MarginContainer/VBoxContainer


func _ready() -> void:
	var playerItemsCategoryControlScene = preload("res://ui/player_items_category_control.tscn") as PackedScene
	for category in player_items.categories:
		var categoryControl = playerItemsCategoryControlScene.instantiate() as PlayerItemsCategoryControl
		categoryControl.itemsCategory = category
		vboxContainer.add_child(categoryControl)
