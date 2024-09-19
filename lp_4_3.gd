extends Control

func _on_btn_calc_pressed() -> void:
	var eggs = int($txtEggs.text)
	var cost = 0.50
	var dozens = eggs / 12
	
	if dozens < 0:
		$lblCost.text = "Cost per dozen: Error"
	elif dozens < 4:
		$lblCost.text = "Cost per dozen: " str(cost)
	elif dozens < 6:
		pass

func _on_btn_clear_pressed() -> void:
	$txtEggs.text = ""
	$lblCost.text = "Cost per dozen:"


func _on_btn_exit_pressed() -> void:
	get_tree().quit()
