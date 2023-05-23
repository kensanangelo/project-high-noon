extends Node

var menu_scene_packed: PackedScene = preload("res://scenes/main_menu.tscn")

var battle_scene_packed: PackedScene = preload("res://scenes/battle_scene.tscn")

var game_over_screen_packed: PackedScene = preload("res://scenes/game_over_scene.tscn")


func start_battle(_num_players: int) -> void:
	get_tree().change_scene_to_packed(battle_scene_packed)


func go_to_menu() -> void:
	get_node("/root/GameOver").queue_free()
	get_tree().change_scene_to_packed(menu_scene_packed)


func end_battle(winner: Enums.BattleResults, reason: String) -> void:
	var game_over_screen: Node = game_over_screen_packed.instantiate()
	game_over_screen.state = winner
	game_over_screen.explanation = reason

	get_node("/root/Battle").queue_free()
	get_tree().get_root().add_child(game_over_screen)
