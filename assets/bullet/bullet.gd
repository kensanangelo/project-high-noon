class_name Bullet
extends CharacterBody2D

## How fast the bullet travels
@export var speed := 100
## How long the bullet is alive before it destroys itself
@export var lifetime := 1.0

var parent_player: Enums.Players
var direction := 0.0


func _ready() -> void:
	var timer = Timer.new()
	timer.wait_time = lifetime
	timer.autostart = true
	add_child(timer)
	timer.timeout.connect(die)


func setup(_position, _direction, parent: Enums.Players):
	parent_player = parent
	self.rotation_degrees = _direction
	self.position = _position
	self.velocity = Vector2(speed, 0).rotated(rotation)


func _physics_process(delta):
	var collision := move_and_collide(velocity * delta)

	if collision:
		var collider: Node = collision.get_collider()

		# If it hits the player that created it, ignore completely
		# We do this because the bullet spawns inside the creator's hitbox
		if collider is Player && collider.name == Enums.PlayerNodeNames[parent_player]:
			return

		if collider is Player:
			collider.gets_hit()
		elif collider is Bullet:
			SignalBus.bullets_collided.emit(collision.get_position(), self.name, collider.name)
		else:
			SignalBus.bullet_hits_env.emit(collision.get_position())

		die()


func die() -> void:
	SignalBus.bullet_ends.emit()
	queue_free()
