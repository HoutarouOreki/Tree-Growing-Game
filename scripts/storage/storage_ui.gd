@tool
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
	var i = 0
	for slot in storage.slots:
		add_slot_visual(slot, selectedSlotIndex == i)
		i += 1


func add_slot_visual(slot: StorageSlot, selected: bool):
	var storageUiSlot = (load("res://ui/storage_ui_slot.tscn") as PackedScene).instantiate() as StorageUiSlot
	storageUiSlot.set_params(slot_size, slot_padding, slot.item, selected)
	gridContainer.add_child(storageUiSlot)
