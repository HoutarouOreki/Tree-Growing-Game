@tool
class_name StorageUi extends Control

@export var storage: Storage
@export var player: CharacterBody3D
@export_range(0, 100000, 1) var slot_size: int = 32
@export_range(0, 100000, 1) var slot_padding: int = 4
@onready var gridContainer := $CenterContainer/GridContainer

var selectedSlotIndex: int = 0

func _get_configuration_warnings():
	var array = []
	if !storage:
		array.append("Storage node is missing")
	if !player:
		array.append("Player node is missing")
	return array


func _unhandled_input(event):
	if event.is_action_pressed("hotbar_next"):
		stop_process()
		selectedSlotIndex += 1
	if selectedSlotIndex >= storage.storage_size:
		selectedSlotIndex = 0

	if event.is_action_pressed("hotbar_previous"):
		stop_process()
		selectedSlotIndex -= 1
	if selectedSlotIndex < 0:
		selectedSlotIndex = storage.storage_size - 1
	notify_property_list_changed()
	if event.is_action_pressed("use_item"):
		use_item(event)


func use_item(event):
	if storage.slots[selectedSlotIndex].item:
		storage.slots[selectedSlotIndex].item.action(player, event)


# Called when the node enters the scene tree for the first time.
func _ready():
	if storage.is_node_ready():
		on_change()
	else:
		storage.ready.connect(on_change)
	child_order_changed.connect(on_change)
	storage.property_list_changed.connect(on_change)
	property_list_changed.connect(on_change)


func _physics_process(delta: float) -> void:
	if !storage.slots[selectedSlotIndex].item:
		return

	storage.slots[selectedSlotIndex].item.process(player)


func stop_process():
	if !storage.slots[selectedSlotIndex].item:
		return

	storage.slots[selectedSlotIndex].item.stop_process(player)


func on_change():
	if !storage:
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
