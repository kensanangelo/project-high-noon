extends Control

@export var single_player_button: Button
@export var two_player_button: Button
@export var how_to_play_button: Button
@export var options_button: Button


func _ready() -> void:
	two_player_button.clicked.connect(on_two_player_button_pressed)


func on_two_player_button_pressed() -> void:
	SceneManager.start_battle(2)
