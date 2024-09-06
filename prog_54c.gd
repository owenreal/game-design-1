extends Control

func _on_btn_calc_pressed() -> void:
	var radius = float($txtRadius.text)
	var pi = 3.14159
	
	var area = pi * radius ** 2
	var circumference = 2 * pi * radius
	
	$lblArea.text = "Area: " + str(area) 
	$lblCir.text = "Circumference: " + str(circumference)

func _on_btn_clear_pressed() -> void:
	pass
func _on_btn_exit_pressed() -> void:
	get_tree().quit()
