extends Control

@export var label: Label
var state = Enums.BATTLERESULTS.TIE


func _ready():
	assert(label != null, "Game Over Label is null")

	var text = ""

	match state:
		Enums.BATTLERESULTS.PLAYER_1_WINS:
			text = "Player 1 Wins"
		Enums.BATTLERESULTS.PLAYER_2_WINS:
			text = "Player 2 Wins"
		Enums.BATTLERESULTS.TIE:
			text = "You tied!"

	label.text = text
