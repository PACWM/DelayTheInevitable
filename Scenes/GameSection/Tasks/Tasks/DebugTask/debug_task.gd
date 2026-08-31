extends Task



func _on_area_2d_body_entered(_body: Node2D) -> void:
	completed.emit(self)
	despawn()
