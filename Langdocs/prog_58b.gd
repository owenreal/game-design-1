extends Control

func _on_btn_calc_pressed() -> void:
	var A = int($txtA.text)
	var B = int($txtB.text)
	var C = int($txtC.text) 
	
	var root1 = (-B + sqrt(B**2 - 4 * A * C)) /2 * A
	var root2 = (-B - sqrt(B**2 - 4 * A * C)) /2 * A
	
	$lblRoots.text = str(root1) + " and " + str(root2)

func _on_btn_clear_pressed() -> void:
	$txtA.text = ""
	$txtB.text = ""
	$txtC.text = ""
	$lblRoots.text = ""

func _on_btn_exit_pressed() -> void:
	get_tree().quit()
