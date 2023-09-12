extends Node


var plants: Array[PlantData]:
	get:
		return SaveManager.current_save.plants


func add_plant(plantData: PlantData) -> void:
	plants.append(plantData)


func generate_plant_nodes() -> Array[PlantNode]:
	var arr: Array[PlantNode] = []

	for plantData in plants:
		var node = PlantNode.create(plantData)
		arr.append(node)

	return arr


func save():
	SaveManager.store()


func _ready() -> void:
	if !SaveManager.load_save("default"):
		SaveManager.create_save("default")

	plants = SaveManager.current_save.plants
