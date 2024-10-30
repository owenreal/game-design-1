extends Control

func _on_closebtn_pressed() -> void:
	self.visible = false
	var player = self.find_parent("plt_player")
	
func _process(delta: float) -> void:
	pass
	
