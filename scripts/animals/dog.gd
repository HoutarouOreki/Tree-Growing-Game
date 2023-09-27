class_name Dog extends Animal


## If and only if a [Player] used a whistle to recall this dog,
## this will reference them.
var whistled_by_player: Player


var following_target: Node3D


func on_whistle(player: Player) -> void:
	whistled_by_player = player


func on_follow(node: Node3D) -> void:
	following_target = node


func on_unfollow(node: Node3D) -> void:
	if following_target == node:
		following_target = null


func on_stay() -> void:
	following_target = null
	whistled_by_player = null
