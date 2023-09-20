class_name PlayerItems extends Resource


signal item_gained(name: String, amount: int)


@export var categories: Array[PlayerItemsCategory]


func add_item(newItem: StorageItem) -> void:
	var matchingCategory: PlayerItemsCategory

	for category in categories:
		if category.name == newItem.category:
			matchingCategory = category

	if !matchingCategory:
		matchingCategory = PlayerItemsCategory.create(newItem.category)
		categories.append(matchingCategory)

	matchingCategory.add_item(newItem.duplicate(true))
	item_gained.emit(newItem.name, newItem.count)


