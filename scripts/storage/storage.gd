@tool
class_name Storage extends Node

@export_range(0, 100, 1) var storage_size: int = 10 : set = _setStorageSize
var slots: Array[StorageSlot]

@export_group("Starting items")
@export var starting_items: Array[StorageItem] : set = _setStartingItems


# Called when the node enters the scene tree for the first time.
func _ready():
	generateSlots()


func generateSlots():
	slots.clear()
	for i in range(storage_size):
		var storageSlot = StorageSlot.new()
		storageSlot.item = starting_items[i]
		slots.append(storageSlot)


func _setStorageSize(value: int):
	storage_size = value
	_setStartingItems(starting_items)
	generateSlots()
	notify_property_list_changed()


func _setStartingItems(value: Array[StorageItem]):
	value.resize(storage_size)
	starting_items = value
