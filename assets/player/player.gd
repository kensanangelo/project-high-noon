class_name Player
extends CharacterBody2D

@export var player: Enums.Players
@export var player_controls: Node
@export var animator: PlayerAnimator
@export var arrow: Sprite2D

## How quickly the character moves
@export var speed := 100
## How far the character goes per step
@export var movement_step := 100
## How many bullets the player starts with
@export var bullets_left := 6

var target: Vector2 = Vector2.ZERO
var steps_taken: int = 0
var steps_limit: int = 5
var has_shot: bool = false
var is_disabled: bool = false


func _ready() -> void:
	# If player 1, we invert the movement
	# so the char goes left, not right
	if player == Enums.Players.PLAYER_1:
		movement_step *= -1

	SignalBus.players_disabled.connect(disable_player)

	enable_player()

	assert(animator, "Animator not connected")
	assert(arrow, "Arrow not connected")


func _physics_process(_delta) -> void:
	# if close to target, clear target
	if self.position.distance_to(target) < 10:
		target = Vector2.ZERO
		animator.stop_walking()

	# if no target, dont move
	if target == Vector2.ZERO:
		return

	self.velocity = (target - self.position).normalized() * speed
	move_and_slide()


func _on_player_steps() -> void:
	if steps_taken >= steps_limit:
		animator.turn_around()
		return

	if has_shot:
		return

	if target != Vector2.ZERO:
		return

	steps_taken += 1
	SignalBus.player_stepped.emit(player, steps_taken)

	animator.start_walking()
	var new_x := self.position.x + movement_step
	target = Vector2(new_x, self.position.y)


func _on_player_aims() -> void:
	if bullets_left <= 0:
		return

	animator.turn_around()
	arrow.start_arrow()


func _on_player_shoots() -> void:
	arrow.stop_arrow()

	if bullets_left <= 0:
		return

	SignalBus.bullet_fired.emit(calculate_bullet_pos(), calculate_shot_angle(), player)

	bullets_left -= 1
	animator.play_shooting()
	SignalBus.player_shot.emit(player, bullets_left)
	has_shot = true


func gets_hit() -> void:
	if is_disabled:
		return

	SignalBus.player_died.emit(player)
	animator.play_dying()


func enable_player() -> void:
	# sets disabled flag
	is_disabled = false

	# connects controls
	if player_controls:
		player_controls.player_steps.connect(_on_player_steps)
		player_controls.player_aims.connect(_on_player_aims)
		player_controls.player_shoots.connect(_on_player_shoots)
	else:
		printerr("Player controls not connected")


func disable_player() -> void:
	# sets disabled flag
	is_disabled = true

	# disabled controls
	player_controls.player_steps.disconnect(_on_player_steps)
	player_controls.player_aims.disconnect(_on_player_aims)
	player_controls.player_shoots.disconnect(_on_player_shoots)

	# cancels current movement
	target = Vector2.ZERO


func calculate_bullet_pos() -> Vector2:
	var new_pos := self.global_position + Vector2(0, 4)

	if player == Enums.Players.PLAYER_1:
		return new_pos + Vector2(10.0, 0)

	return new_pos - Vector2(10.0, 0)


func calculate_shot_angle() -> float:
	if player == Enums.Players.PLAYER_1:
		return arrow.get_angle() - 90.0

	return arrow.get_angle() + 90.0
