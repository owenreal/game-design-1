extends Control

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.process_mode = Node.PROCESS_MODE_ALWAYS

func _on_resume_pressed() -> void:
	self.hide()
	get_tree().paused = false

func _on_quit_pressed() -> void:
	get_tree().quit()
