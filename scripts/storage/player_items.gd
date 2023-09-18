class_name PlayerItems extends Resource

@export var categories: Array[PlayerItemsCategory]
@export var otherItems: Array[StorageItem]


func add_item(newItem: StorageItem) -> void:
	for category in categories:
		if try_stack_item(newItem, category.items):
			return

	if try_stack_item(newItem, otherItems):
		return

	otherItems.append(newItem)


func try_stack_item(newItem: StorageItem, arr: Array[StorageItem]) -> bool:
	for item in arr:
		if item.name == newItem.name:
			item.count += newItem.count
			return true

	return false
