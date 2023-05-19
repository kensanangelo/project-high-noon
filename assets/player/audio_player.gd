extends Node

@export var hurt_player: AudioStreamPlayer2D
@export var shoot_player: AudioStreamPlayer2D
@export var step_player: AudioStreamPlayer2D
@export var empty_player: AudioStreamPlayer2D
@export var cocked_player: AudioStreamPlayer2D


func _ready() -> void:
	assert(hurt_player != null, "hurt_player is not connected")
	assert(shoot_player != null, "shoot_player is not connected")
	assert(step_player != null, "step_player is not connected")
	assert(empty_player != null, "empty_player is not connected")
	assert(cocked_player != null, "cocked_player is not connected")


func play_hurt() -> void:
	play_sound(hurt_player)


func play_shoot() -> void:
	play_sound(shoot_player)


func play_step() -> void:
	play_sound(step_player)


func play_cocked() -> void:
	cocked_player.play()


func play_empty() -> void:
	empty_player.play()


func play_sound(player: AudioStreamPlayer2D) -> void:
	randomize()
	player.set_pitch_scale(randf_range(0.8, 1.2))
	player.play()


func stop_all() -> void:
	hurt_player.stop()
	shoot_player.stop()
	step_player.stop()
