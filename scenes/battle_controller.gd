extends Node2D

## How many steps the players take before shooting
@export var total_steps := 5

var player_1: Dictionary = {
	"hit_max_steps" = false,
	"out_of_bullets" = false
}

var player_2: Dictionary = {
	"hit_max_steps" = false,
	"out_of_bullets" = false
}

func _ready() -> void:
	SignalBus.player_shot.connect(handle_shooting_rules)
	SignalBus.player_stepped.connect(handle_step)
	
func handle_step(player: Enums.Players, count: int):
	check_max_steps(player, count)
	notify_if_players_ready_to_shoot()

func check_max_steps(player: Enums.Players, count: int) -> void:
	if(count >= total_steps):
		if(player == Enums.Players.PLAYER_1):
			player_1.hit_max_steps = true
		else:
			player_2.hit_max_steps = true

func notify_if_players_ready_to_shoot() -> void:
	if(player_1.hit_max_steps and player_2.hit_max_steps):
		SignalBus.players_ready_to_shoot.emit()

func handle_shooting_rules(player: Enums.Players, count: int) -> void:
	check_preemptive_attack(player)
	check_out_of_bullets(player, count)

	check_tie()

## If a player shoots before both are at max steps, they lose
func check_preemptive_attack(shooter: Enums.Players) -> void:
	if(!player_1.hit_max_steps || !player_2.hit_max_steps):
		var winner := Enums.BATTLERESULTS.PLAYER_1_WINS

		if(shooter == Enums.Players.PLAYER_1):
			winner = Enums.BATTLERESULTS.PLAYER_2_WINS

		SceneManager.end_battle(winner)
		return

func check_out_of_bullets(player: Enums.Players, count: int) -> void:
	if(count == 0):
		if(player == Enums.Players.PLAYER_1):
			player_1.out_of_bullets = true
		else:
			player_2.out_of_bullets = true

func check_tie() -> void:
	if player_1.out_of_bullets and player_2.out_of_bullets:
		SceneManager.end_battle(Enums.BATTLERESULTS.TIE)
		
func get_opposite_player(player: Enums.Players):
	if player == Enums.Players.PLAYER_1:
		return Enums.Players.PLAYER_2
	else:
		return Enums.Players.PLAYER_1
