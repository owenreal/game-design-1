extends RigidBody2D

var dragging = false
var offset = Vector2.ZERO

func _process(delta):
	if dragging:
		self.global_position = get_global_mouse_position() - offset
		self.freeze = true 
		$CollisionShape2D.disabled = true
	else:
		self.freeze = false
		$CollisionShape2D.disabled = false

func _on_button_button_down() -> void:
	dragging = true
	offset = get_global_mouse_position() - self.global_position
	
func _on_button_button_up() -> void:
	dragging = false

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("enemies"):
		body.queue_free()
