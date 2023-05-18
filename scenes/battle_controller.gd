extends Node2D

@export var explosions_container: Node
@export var bullet_container: Node
## How many steps the players take before shooting
@export var total_steps := 5
@export var game_over_delay := 2.5

var bullet_class = preload("res://assets/bullet/bullet.tscn")
var explosion_class = preload("res://assets/explosion/explosion.tscn")

var player_1: Dictionary = {
	"hit_max_steps" = false,
	"out_of_bullets" = false
}

var player_2: Dictionary = {
	"hit_max_steps" = false,
	"out_of_bullets" = false
}

var bullet_counter: int = 0
var bullets_have_collided: Array[String] = []

func _ready() -> void:
	assert(explosions_container != null, "Explosions container is null")
	assert(bullet_container != null, "Bullet container is null")

	SignalBus.player_shot.connect(handle_shooting_rules)
	SignalBus.player_stepped.connect(handle_step)
	SignalBus.player_died.connect(handle_player_died)
	SignalBus.bullet_fired.connect(handle_bullet_fired)
	SignalBus.bullets_collided.connect(handle_bullets_collided)
	SignalBus.bullet_ends.connect(handle_bullet_ends)
	
func handle_step(player: Enums.Players, count: int) -> void:
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

func handle_player_died(player: Enums.Players) -> void:
	var winner := get_opposite_player(player)
	var result := generate_result_from_winner(winner)
	end_game(result)

func handle_bullet_fired(pos: Vector2, angle: float, from: Enums.Players) -> void:
	var bullet: Bullet = bullet_class.instantiate()
	# Create a unique bullet name
	bullet.name = "Bullet" + str(bullet_counter)
	bullet.setup(pos, angle, from)
	bullet_container.add_child(bullet)

	bullet_counter += 1

func handle_bullets_collided(pos: Vector2, bullet1: String, bullet2: String) -> void:
	# If the bullets have already collided, don't render another explosion
	if bullets_have_collided.has(bullet1) || bullets_have_collided.has(bullet2):
		return
	
	# Add to our list of bullets
	bullets_have_collided.append(bullet1)
	bullets_have_collided.append(bullet2)

	var explosion: AnimatedSprite2D = explosion_class.instantiate()
	explosion.global_position = pos
	explosions_container.add_child(explosion)

func handle_bullet_ends() -> void:
	# This could happen before a queue_free, so there might be 1 or 0 children even though it's empty
	if bullet_container.get_child_count() <= 1:
		check_tie()

## If a player shoots before both are at max steps, they lose
func check_preemptive_attack(shooter: Enums.Players) -> void:
	if(!player_1.hit_max_steps || !player_2.hit_max_steps):
		var winner := get_opposite_player(shooter)
		var result := generate_result_from_winner(winner)
		end_game(result)
		return

func check_out_of_bullets(player: Enums.Players, count: int) -> void:
	if(count == 0):
		if(player == Enums.Players.PLAYER_1):
			player_1.out_of_bullets = true
		else:
			player_2.out_of_bullets = true

func check_tie() -> void:
	if player_1.out_of_bullets and player_2.out_of_bullets:
		end_game(Enums.BattleResults.TIE)
		
func get_opposite_player(player: Enums.Players) -> Enums.Players:
	if player == Enums.Players.PLAYER_1:
		return Enums.Players.PLAYER_2
	else:
		return Enums.Players.PLAYER_1

func generate_result_from_winner(winner: Enums.Players) -> Enums.BattleResults:
	if winner == Enums.Players.PLAYER_2:
		return Enums.BattleResults.PLAYER_2_WINS
	else:
		return Enums.BattleResults.PLAYER_1_WINS

func end_game(results: Enums.BattleResults) -> void:
	SignalBus.players_disabled.emit()

	var timer = Timer.new()
	timer.wait_time = game_over_delay
	timer.autostart = true
	add_child(timer)

	await timer.timeout

	SceneManager.end_battle(results)
	
