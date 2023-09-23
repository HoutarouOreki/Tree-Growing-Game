class_name Dog extends Animal


## If and only if a [Player] used a whistle to recall this dog,
## this will reference them.
var whistled_by_player: Player


func on_whistle(player: Player) -> void:
	whistled_by_player = player
