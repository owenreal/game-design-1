extends Sprite2D


func _on_killbrick_body_entered(body: Node2D) -> void:
	if body.name == "plt_player":
		body.queue_free()
		OS.alert("You died!")
		get_tree().reload_current_scene()
