extends Control

@export var single_player_button: Button
@export var two_player_button: Button
@export var how_to_play_button: Button
@export var options_button: Button

@export var click_player: AudioStreamPlayer


func _ready() -> void:
	two_player_button.button_up.connect(on_two_player_button_pressed)


func on_two_player_button_pressed() -> void:
	await play_click()
	SceneManager.start_battle(2)


func play_click() -> void:
	click_player.play()

	await click_player.finished
