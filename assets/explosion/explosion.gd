extends AnimatedSprite2D


func _ready():
	self.play("explode")
	await self.animation_finished
	queue_free()
