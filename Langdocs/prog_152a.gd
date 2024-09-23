extends Control

func _on_btn_calc_pressed() -> void:
	var mySum = 0
	var lcv = 3 # loop control
	while lcv <= 9669:
		mySum += lcv
		$ItemList.add_item(str(mySum)) 
		lcv += 3
	# for lcv in range (3, 9670, 3): 

func _on_btn_clear_pressed() -> void:
	$ItemList.clear() 

func _on_btn_exit_pressed() -> void:
	get_tree().quit()
