extends Control

func _on_btn_calc_pressed() -> void:
	$ItemList.add_item("Number   Square   Square Root   Cube   4th Root")
	for num in range(1, 20+1):
		var square = num**2
		var root = sqrt(num)
		var cube = num**3
		var fourth = sqrt(sqrt(num))
		
		var line = str(num) + "   " + str(square) + "   " + str(root) + "   " + str(cube) + "   " + str(fourth)
		$ItemList.add_item(line) 
func _on_btn_clear_pressed() -> void:
	$ItemList.clear()

func _on_btn_exit_pressed() -> void:
	get_tree().quit()
