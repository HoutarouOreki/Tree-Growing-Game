class_name PlayerItemsCategory extends Resource


@export var name: Categories
@export var items: Array[StorageItem] = []


static func create(name: PlayerItemsCategory.Categories) -> PlayerItemsCategory:
	var category = PlayerItemsCategory.new()
	category.name = name
	return category


static func get_category_name_string(name: Categories) -> String:
	return Categories.keys()[name]


func get_name_string() -> String:
	return PlayerItemsCategory.get_category_name_string(name)


func add_item(newItem: StorageItem) -> void:
	for item in items:
		if item.name == newItem.name:
			item.count += newItem.count
			return

	items.append(newItem)


enum Categories {
	Other,
	Resources,
	Food,
}
