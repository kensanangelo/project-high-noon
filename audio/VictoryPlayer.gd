extends AudioStreamPlayer


func play_victory() -> void:
	self.play()

	await self.finished
	queue_free()
