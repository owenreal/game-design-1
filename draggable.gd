extends RigidBody2D

var dragging = false
var offset = Vector2.ZERO

func _process(delta):
	if dragging:
		self.global_position = get_global_mouse_position() - offset
		self.freeze = true 

func _on_button_button_down() -> void:
	dragging = true
	offset = get_global_mouse_position() - self.global_position
	

func _on_button_button_up() -> void:
	dragging = false
