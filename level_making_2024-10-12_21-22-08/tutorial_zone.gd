extends Area2D

@export var tutorial_text = "Tutorial Text Here"
@export var activated = false

func _on_body_entered(body: Node2D) -> void:
	if activated == false and body.name == "plt_player":
		var tutorial = body.find_child("tutorial")
		var label = tutorial.find_child("tutorialText")
		label.text = tutorial_text
		tutorial.visible = true
		activated = true
