extends Control


var player_items: PlayerItems:
	get:
		return (SaveManager.current_save as GameSave).items
@onready var vboxContainer: VBoxContainer = $MarginContainer/VBoxContainer


func _ready() -> void:
	generate_layout()
	player_items.item_gained.connect(func(_a, _b): generate_layout())


func generate_layout() -> void:
	for child in vboxContainer.get_children():
		child.queue_free()

	var playerItemsCategoryControlScene = preload("res://ui/player_items_category_control.tscn") as PackedScene
	for category in player_items.categories:
		var categoryControl = playerItemsCategoryControlScene.instantiate() as PlayerItemsCategoryControl
		categoryControl.itemsCategory = category
		vboxContainer.add_child(categoryControl)
