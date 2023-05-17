extends Node

var game_over_screen_packed: PackedScene = preload("res://scenes/game_over_scene.tscn")


func end_battle(winner: Enums.BattleResults) -> void:
	var game_over_screen: Node = game_over_screen_packed.instantiate()
	game_over_screen.state = winner

	get_node("/root/Battle").queue_free()
	get_tree().get_root().add_child(game_over_screen)
