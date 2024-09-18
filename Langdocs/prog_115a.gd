extends Control
var pressed = false 

func _on_btn_calc_pressed() -> void:
	if pressed == false:
		$ItemList.add_item("Number")
		for num in range(2, 36+1, 2):
			var line = str(num)
			$ItemList.add_item(line) 
			pressed = true 


func _on_btn_clear_pressed() -> void:
	$ItemList.clear()
	pressed = false 


func _on_btn_exit_pressed() -> void:
	get_tree().quit() 
