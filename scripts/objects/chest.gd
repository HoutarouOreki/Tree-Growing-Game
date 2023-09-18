extends StaticBody3D

@onready var screen: Control = $StorageScreen


func interact(player: Player):
	screen.show()
