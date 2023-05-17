extends Node
signal player_steps
signal player_aims
signal player_shoots


func _unhandled_input(event) -> void:
	var player_string: String = "player_1"

	match owner.player:
		Enums.Players.PLAYER_1:
			player_string = "player_1"
		Enums.Players.PLAYER_2:
			player_string = "player_2"
		_:
			printerr("Incorrect player assigned")

	if event.is_action_released(str(player_string, "_shoot")):
		player_shoots.emit()
	elif event.is_action_pressed(str(player_string, "_shoot")):
		player_aims.emit()
	elif event.is_action_pressed(str(player_string, "_step")):
		player_steps.emit()
