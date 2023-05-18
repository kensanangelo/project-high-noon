extends Sprite2D

## How far the arrow will oscilate in either direction
@export var rotation_range := 45.0
## How fast the arrow will oscilate
@export var rotation_speed := 5.0
## The current time of the arrow
var time := 0.0
## The starting rotation of the arrow
var default_rotation := 90.0


func _ready() -> void:
	if owner.player == Enums.Players.PLAYER_2:
		self.position = Vector2(-10, 4)
		self.scale = Vector2(1, -1)
	else:
		self.position = Vector2(10, 4)

	self.visible = false


func _physics_process(delta):
	if not self.visible:
		return

	# oscilate the arrow
	time += delta * rotation_speed
	var new_rotation = default_rotation + sin(time) * rotation_range

	self.rotation_degrees = new_rotation


func start_arrow() -> void:
	self.visible = true


func stop_arrow() -> void:
	self.visible = false

func get_angle() -> float:
	return self.rotation_degrees