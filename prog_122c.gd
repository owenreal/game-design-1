extends Control



func _on_btn_calc_pressed() -> void:
	for num in range(2, 10+1, 2):
		var line1 = str(num)
		$ItemList.add_item(line1)
	
	for num in range(3, 11+1, 3):
		var line2 = str(num)
		$ItemList2.add_item(line2)
		
	for num in range(4, 20+1, 4):
		var line3 = str(num)
		$ItemList3.add_item(line3)
		
	var step = 12
	for num in range(4, 100, step):
		var line4 = str(num)
		step += 8
		$ItemList4.add_item(line4)
		#fix more

func _on_btn_clear_pressed() -> void:
	var resets = [$ItemList, $ItemList2, $ItemList3, $ItemList4]
	for num in resets:
		num.clear()

func _on_btn_exit_pressed() -> void:
	get_tree().quit()
