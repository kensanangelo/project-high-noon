extends CharacterBody2D

@export var player: Enums.PLAYERS
@export var player_controls: Node
@export var animator: PlayerAnimator

## How quickly the character moves
@export var speed := 100
## How far the character goes per step
@export var movement_step := 100

## How many bullets the player starts with
@export var bullets_left := 6

var target: Vector2 = Vector2.ZERO
var steps_taken: int = 0
var has_shot: bool = false


func _ready():
	# If player 1, we invert the movement
	# so the char goes left, not right
	if player == Enums.PLAYERS.PLAYER_1:
		movement_step *= -1

	if player_controls:
		player_controls.player_steps.connect(_on_player_steps)
		player_controls.player_shoots.connect(_on_player_shoots)
	else:
		printerr("Player controls not connected")

	assert(animator, "Animator not connected")


func _physics_process(_delta):
	# if close to target, clear target
	if self.position.distance_to(target) < 10:
		target = Vector2.ZERO
		animator.stop_walking()

	# if no target, dont move
	if target == Vector2.ZERO:
		return

	self.velocity = (target - self.position).normalized() * speed
	move_and_slide()


func _on_player_steps():
	if has_shot:
		return

	if target != Vector2.ZERO:
		return

	steps_taken += 1
	SignalBus.update_player_steps.emit(player, steps_taken)

	animator.start_walking()
	var new_x = self.position.x + movement_step
	target = Vector2(new_x, self.position.y)


func _on_player_shoots():
	if bullets_left <= 0:
		return

	bullets_left -= 1
	SignalBus.update_bullet_count.emit(player, bullets_left)
	animator.play_shooting()
	has_shot = true
