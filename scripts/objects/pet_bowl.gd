class_name PetBowl extends StaticBody3D


@onready var fill_mesh: MeshInstance3D = $FillMesh


func is_filled() -> bool:
	return fill_mesh.visible


func fill() -> void:
	fill_mesh.visible = true


func eat_up() -> void:
	fill_mesh.visible = false


func interact(player: Player) -> void:
	fill()
