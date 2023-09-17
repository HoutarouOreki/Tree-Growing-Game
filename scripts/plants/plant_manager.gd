extends Node


var plants: Array[PlantData]:
	get:
		return SaveManager.current_save.plants


func add_plant(plantData: PlantData) -> void:
	plants.append(plantData)


func remove_plant(plantData: PlantData) -> void:
	plants.erase(plantData)


func generate_plant_nodes() -> Array[PlantNode]:
	var arr: Array[PlantNode] = []

	for plantData in plants:
		var node = PlantNode.create(plantData)
		arr.append(node)

	return arr
