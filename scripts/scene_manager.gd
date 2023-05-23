extends Node

var game_over_screen_packed: PackedScene = preload("res://scenes/game_over_scene.tscn")

var battle_scene_packed: PackedScene = preload("res://scenes/battle_scene.tscn")


func start_battle(_num_players: int) -> void:
	get_tree().change_scene_to_packed(battle_scene_packed)


func end_battle(winner: Enums.BattleResults) -> void:
	var game_over_screen: Node = game_over_screen_packed.instantiate()
	game_over_screen.state = winner

	get_node("/root/Battle").queue_free()
	get_tree().get_root().add_child(game_over_screen)
