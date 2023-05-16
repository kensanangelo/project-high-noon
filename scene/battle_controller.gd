extends Node2D

## How many steps the players take before shooting
@export var total_steps = 5

var player_1: Dictionary = {
	"hit_max_steps" = false,
	"out_of_bullets" = false
}

var player_2: Dictionary = {
	"hit_max_steps" = false,
	"out_of_bullets" = false
}

func _ready() -> void:
	SignalBus.update_bullet_count.connect(check_out_of_bullets)

func check_out_of_bullets(player: Enums.PLAYERS, count: int):
	if(count == 0):
		if(player == Enums.PLAYERS.PLAYER_1):
			player_1.out_of_bullets = true
		else:
			player_2.out_of_bullets = true

		check_tie()

func check_tie() -> void:
	if player_1.out_of_bullets and player_2.out_of_bullets:
		print('game ends: tie!')