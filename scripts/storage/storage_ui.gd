class_name StorageUi extends Control

@export var storage: Storage
@onready var player := $".."
@export_range(0, 100000, 1) var slot_size: int = 32
@export_range(0, 100000, 1) var slot_padding: int = 4
@onready var gridContainer := $CenterContainer/GridContainer

var selectedSlotIndex: int = 0:
	get:
		return selectedSlotIndex
	set (value):
		selectedSlotIndex = value
		on_change()

func _get_configuration_warnings():
	var array = []
	if !storage:
		array.append("Storage node is missing")
	if !player:
		array.append("Player node is missing")
	return array


# Called when the node enters the scene tree for the first time.
func _ready():
	if storage.is_node_ready():
		on_change()
	else:
		storage.ready.connect(on_change)
	child_order_changed.connect(on_change)
	storage.property_list_changed.connect(on_change)
	property_list_changed.connect(on_change)


func on_change():
	if !is_instance_valid(gridContainer) || !is_instance_valid(storage):
		return

	while gridContainer.get_child_count() > 0:
		gridContainer.remove_child(gridContainer.get_child(0))

	generate_layout()


func generate_layout():
	for slot in storage.slots:
		add_slot_visual(slot)

func add_slot_visual(slot: StorageSlot):
	var itemContainer = Control.new()
	gridContainer.add_child(itemContainer)
	itemContainer.custom_minimum_size = Vector2(slot_size, slot_size)
	var background = ColorRect.new()
	if slot == storage.slots[selectedSlotIndex]:
		background.color = Color8(100, 100, 100)
	else:
		background.color = Color8(50, 50, 50)
	background.size = Vector2(slot_size, slot_size)
	itemContainer.add_child(background)

	if !slot.item:
		return

	background.add_child(create_item_visual(slot.item))

func create_item_visual(item: StorageItem) -> Control:
	var texture = TextureRect.new()
	texture.texture = item.texture
	texture.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	texture.stretch_mode = texture.STRETCH_KEEP_ASPECT_CENTERED
	texture.size = Vector2(slot_size - slot_padding * 2, slot_size - slot_padding * 2)
	texture.position = Vector2(slot_padding, slot_padding)
	return texture
