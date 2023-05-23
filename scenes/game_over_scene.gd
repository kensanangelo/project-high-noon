extends Control

@export var result_label: Label
@export var explanation_label: Label
@export var menu_button: Button

var state: Enums.BattleResults = Enums.BattleResults.TIE
var explanation: String = ""


func _ready() -> void:
	assert(result_label != null, "Game Over Label is null")
	assert(explanation_label != null, "Explanation Label is null")

	var text := ""

	match state:
		Enums.BattleResults.PLAYER_1_WINS:
			text = "Player 1 Wins"
		Enums.BattleResults.PLAYER_2_WINS:
			text = "Player 2 Wins"
		Enums.BattleResults.TIE:
			text = "You tied!"

	result_label.text = text
	explanation_label.text = explanation

	menu_button.button_up.connect(on_menu_button_pressed)


func on_menu_button_pressed() -> void:
	SceneManager.go_to_menu()
