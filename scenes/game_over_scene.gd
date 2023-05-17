extends Control

@export var label: Label
var state: Enums.BattleResults = Enums.BattleResults.TIE


func _ready() -> void:
	assert(label != null, "Game Over Label is null")

	var text := ""

	match state:
		Enums.BattleResults.PLAYER_1_WINS:
			text = "Player 1 Wins"
		Enums.BattleResults.PLAYER_2_WINS:
			text = "Player 2 Wins"
		Enums.BattleResults.TIE:
			text = "You tied!"

	label.text = text
