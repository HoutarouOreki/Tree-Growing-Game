@tool
class_name StorageUi extends Control

@export var storage: Storage
@export_range(0, 100000, 1) var slot_size: int = 32
@onready var gridContainer := $CenterContainer/GridContainer

func _get_configuration_warnings():
	if !storage:
		return ["Storage node is missing"]

# Called when the node enters the scene tree for the first time.
func _ready():
	if storage.is_node_ready():
		on_change()
	else:
		storage.ready.connect(on_change)
	child_order_changed.connect(on_change)
	storage.property_list_changed.connect(on_change)
	property_list_changed.connect(on_change)
	print("h4")


func on_change():
	if !storage:
		return
	
	while gridContainer.get_child_count() > 0:
		gridContainer.remove_child(gridContainer.get_child(0))
		
	generate_layout()


func generate_layout():
	for slot in storage.slots:
		print("h2")
		add_slot_visual(slot)
		
func add_slot_visual(slot: StorageSlot):
	var itemContainer = Control.new()
	gridContainer.add_child(itemContainer)
	itemContainer.custom_minimum_size = Vector2(slot_size, slot_size)
	var label = TextureRect.new()
	#label.texture = load("res://assets/textures/checker.png")
	#label.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	#label.size = Vector2(slot_size, slot_size)
	#itemContainer.add_child(label)
	print(slot.item)
	if !slot.item:
		return
	
	itemContainer.add_child(create_item_visual(slot.item))

func create_item_visual(item: StorageItem) -> Control:
	var texture = TextureRect.new()
	texture.texture = item.texture
	texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture.stretch_mode = texture.STRETCH_KEEP_ASPECT_CENTERED
	texture.size = Vector2(slot_size, slot_size)
	return texture
