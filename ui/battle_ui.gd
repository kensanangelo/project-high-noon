extends Control

@export var player_1_bullet_count_label: Label
@export var player_2_bullet_count_label: Label
@export var player_1_steps: HBoxContainer
@export var player_2_steps: HBoxContainer
@export var fire_label: Label

var player_1_labels: Dictionary = {}
var player_2_labels: Dictionary = {}


func _ready():
	assert(player_1_bullet_count_label != null, "Player1BulletCount is not assigned")
	assert(player_2_bullet_count_label != null, "Player2BulletCount is not assigned")
	assert(player_1_steps != null, "Player1Steps is not assigned")
	assert(player_2_steps != null, "Player2Steps is not assigned")
	assert(fire_label != null, "FireLabel is not assigned")

	player_1_labels = {
		"bullet_count" = player_1_bullet_count_label,
		"steps" = player_1_steps
	}

	player_2_labels = {
		"bullet_count" = player_2_bullet_count_label,
		"steps" = player_2_steps
	}

	SignalBus.player_stepped.connect(update_player_steps)
	SignalBus.player_shot.connect(update_bullet_count)
	SignalBus.players_ready_to_shoot.connect(show_ready_to_shoot)

func get_correct_player_labels(player: Enums.PLAYERS):
	if player == Enums.PLAYERS.PLAYER_2:
		return player_2_labels
	else:
		return player_1_labels
	
func show_ready_to_shoot():
	fire_label.visible = true

func update_bullet_count(player: Enums.PLAYERS, new_count: int):
	var label_obj = get_correct_player_labels(player)
	label_obj['bullet_count'].text = str("Bullets: ", new_count)

func update_player_steps(player: Enums.PLAYERS, current_step: int):
	var label_obj = get_correct_player_labels(player)
	var steps_group = label_obj['steps']

	# Prevent a situation where the steps go over the max and error
	if(steps_group.get_child_count() < current_step):
		return

	var current_index = current_step - 1

	if player == Enums.PLAYERS.PLAYER_1:
		current_index = (steps_group.get_child_count() - 1) - (current_step - 1)

	var label_to_update = steps_group.get_child(current_index)
	label_to_update.add_theme_color_override("font_color", Color(0, 0, 0, 1))
