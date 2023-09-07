extends Node

@onready var storage: Storage = $"../Storage"
@onready var player: Player = $".."
@onready var hotbar: StorageUi = $"../Hotbar"


var selectedSlotIndex: int:
	get:
		return hotbar.selectedSlotIndex
	set (value):
		hotbar.selectedSlotIndex = value


func use_item(event):
	if storage.slots[selectedSlotIndex].item:
		storage.slots[selectedSlotIndex].item.action(player, event)


func _unhandled_input(event):
	if player.disabled:
		return

	if event.is_action_pressed("hotbar_next"):
		stop_process()
		selectedSlotIndex += 1
		if selectedSlotIndex >= storage.storage_size:
			selectedSlotIndex = 0
		start_process()

	if event.is_action_pressed("hotbar_previous"):
		stop_process()
		selectedSlotIndex -= 1
		if selectedSlotIndex < 0:
			selectedSlotIndex = storage.storage_size - 1
		start_process()

	notify_property_list_changed()
	if event.is_action_pressed("use_item"):
		use_item(event)


func _physics_process(delta: float) -> void:
	if !storage.slots[selectedSlotIndex].item:
		return

	storage.slots[selectedSlotIndex].item.process(player)


func start_process():
	if !storage.slots[selectedSlotIndex].item:
		return

	storage.slots[selectedSlotIndex].item.start_process(player)


func stop_process():
	if !storage.slots[selectedSlotIndex].item:
		return

	storage.slots[selectedSlotIndex].item.stop_process(player)
