extends Node

@export var victory_player: AudioStreamPlayer
@export var effect_player: AudioStreamPlayer
@export var wind_player: AudioStreamPlayer
@export var fight_player: AudioStreamPlayer

@export var hit_bullet_track = preload("res://audio/effects/bullet_ping.mp3")
@export var hit_env_track = preload("res://audio/effects/bullet_hit_wood.mp3")

## How long between horse sound checks
@export var effect_timer_wait_time: float = 3.0
## Percent chance of horse sound playing every X seconds
@export var effect_chance: float = 0.1

var effect_timer: Timer = Timer.new()

var horse_track: AudioStream = load("res://audio/effects/horse_walking.mp3")

var hawk_track: AudioStream = load("res://audio/effects/hawk_cry.mp3")

var possible_sounds: Array = [
	{"name": "horse", "chance": 0.1, "file": horse_track, "volume": -42.144},
	{"name": "hawk", "chance": 0.1, "file": hawk_track, "volume": -21.746}
]


func _ready() -> void:
	assert(victory_player != null, "victory_player is not connected")
	assert(fight_player != null, "fight_player is not connected")
	assert(wind_player != null, "wind_player is not connected")
	assert(effect_player != null, "effect_player is not connected")

	effect_timer.set_wait_time(effect_timer_wait_time)
	effect_timer.set_one_shot(false)
	effect_timer.timeout.connect(try_play_random_sound)
	self.add_child(effect_timer)

func play_fight() -> void:
	fight_player.play()


func play_gameover() -> void:
	# We wait a bit before playing the victory sound
	var temp_timer := Timer.new()
	temp_timer.set_wait_time(0.5)
	temp_timer.set_one_shot(true)
	self.add_child(temp_timer)
	temp_timer.start()

	await temp_timer.timeout

	victory_player.play()
	temp_timer.queue_free()


func play_ambient() -> void:
	wind_player.play()
	effect_timer.start()


func stop_ambient() -> void:
	wind_player.stop()
	effect_timer.stop()
	effect_player.stop()


func try_play_random_sound() -> void:
	if effect_player.is_playing():
		return

	randomize()
	possible_sounds.shuffle()
	var sound: Dictionary = possible_sounds[0]

	randomize()
	if randf() < sound.chance:
		randomize()
		print("playing sound: " + sound.name)
		effect_player.set_stream(sound.file)
		effect_player.set_volume_db(sound.volume)
		effect_player.set_pitch_scale(randf_range(0.8, 1.2))
		effect_player.play()


func play_hit_bullet(pos: Vector2) -> void:
	create_audio_node(hit_bullet_track, pos, -10.0)


func play_hit_env(pos: Vector2) -> void:
	create_audio_node(hit_env_track, pos, -10.0)


func create_audio_node(track: AudioStream, pos: Vector2, volume: float) -> void:
	var audio_node := AudioStreamPlayer2D.new()
	audio_node.set_stream(track)
	audio_node.set_volume_db(volume)
	audio_node.global_position = pos
	$Bullets.add_child(audio_node)

	audio_node.play()

	await audio_node.finished

	audio_node.queue_free()
