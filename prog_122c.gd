extends Control



func _on_btn_calc_pressed() -> void:
	for num in range(2, 10+1, 2):
		var line1 = str(num)
		$ItemList.add_item(line1)
	
	for num in range(3, 11+1, 2):
		var line2 = str(num)
		$ItemList2.add_item(line2)
		
	for num in range(4, 20+1, 4):
		var line3 = str(num)
		$ItemList3.add_item(line3)
		
	var times = 0
	var addby = 12
	var current = 4
	while times < 5:
		var line4 = str(current)
		$ItemList4.add_item(line4)
		current = current + addby
		addby += 8
		times += 1
		
func _on_btn_clear_pressed() -> void:
	var resets = [$ItemList, $ItemList2, $ItemList3, $ItemList4]
	for num in resets:
		num.clear()

func _on_btn_exit_pressed() -> void:
	get_tree().quit()
