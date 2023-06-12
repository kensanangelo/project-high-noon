extends Button
signal clicked

@export var click_player: AudioStreamPlayer

func _ready() -> void:
	self.pressed.connect(on_button_pressed)

func on_button_pressed() -> void:
	await play_click()
	self.clicked.emit()


func play_click() -> void:
	click_player.play()

	await click_player.finished
