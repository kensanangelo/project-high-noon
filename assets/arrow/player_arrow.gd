extends Sprite2D


func _ready() -> void:
	if owner.player == Enums.Players.PLAYER_2:
		self.position = Vector2(-10, 4)
		self.scale = Vector2(1, -1)
	else:
		self.position = Vector2(10, 4)

	self.visible = false


func show_arrow() -> void:
	self.visible = true


func stop_arrow() -> void:
	self.visible = false
