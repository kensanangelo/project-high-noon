class_name Bullet
extends CharacterBody2D

var direction = 0

var speed = 100
var parent_player: Enums.Players


func setup(_position, _direction, parent: Enums.Players):
	parent_player = parent
	rotation_degrees = _direction
	position = _position
	velocity = Vector2(speed, 0).rotated(rotation)


func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)

	if collision:
		var collider: Node = collision.get_collider()

		# If it hits a player that was not it's creator
		# We do this because the bullet spawns inside the creator's hitbox
		if collider is Player && collider.name != Enums.PlayerNodeNames[parent_player]:
			collider.gets_hit()
			queue_free()

# TODO Add a timer to destroy the bullet after a certain amount of time
