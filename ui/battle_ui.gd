extends Control

@export var player_1_bullet_count_label: Label
@export var player_2_bullet_count_label: Label


func _ready():
	assert(player_1_bullet_count_label != null, "Player1BulletCount is not assigned")
	assert(player_2_bullet_count_label != null, "Player2BulletCount is not assigned")

	SignalBus.update_bullet_count.connect(update_bullet_count)


func update_bullet_count(player: Enums.PLAYERS, new_count: int):
	if player == Enums.PLAYERS.PLAYER_1:
		player_1_bullet_count_label.text = str("Bullets: ", new_count)
	elif player == Enums.PLAYERS.PLAYER_2:
		player_2_bullet_count_label.text = str("Bullets: ", new_count)
