extends Node

var dir: String = "left"


func _ready():
	if owner.player == Enums.Players.PLAYER_2:
		self.position = Vector2(-10, 4)
		self.scale = Vector2(1, -1)
	else:
		self.position = Vector2(10, 4)

	self.visible = false


func show_arrow():
	self.visible = true


func stop_arrow():
	self.visible = false
