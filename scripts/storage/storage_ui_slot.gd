@tool
class_name StorageUiSlot extends Control


@export_range(0, 100000, 1) var slot_size: int = 32

@export_range(0, 100000, 1) var slot_padding: int = 4
@export var item: StorageItem
@onready var textureRect: TextureRect = $TextureRect
@onready var selectedOverlay: ColorRect = $SelectedOverlay
@export var selected: bool


func _ready() -> void:
	update_layout()


func update_layout() -> void:
	if !is_node_ready():
		return

	custom_minimum_size = Vector2(slot_size, slot_size)
	if item:
		textureRect.texture = item.texture
	else:
		textureRect.texture = null

	textureRect.size = Vector2(slot_size - slot_padding * 2, slot_size - slot_padding * 2)
	textureRect.position = Vector2(slot_padding, slot_padding)

	selectedOverlay.visible = selected


@warning_ignore("shadowed_variable")
func set_params(slotSize: int, slotPadding: int, item: StorageItem, selected: bool):
	slot_size = slotSize
	slot_padding = slotPadding
	self.item = item
	self.selected = selected
	update_layout()
