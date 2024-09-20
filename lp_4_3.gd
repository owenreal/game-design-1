extends Control

func _on_btn_calc_pressed() -> void:
	var eggs = int($txtEggs.text)
	var dozens = eggs / 12
	var extra = eggs % 12
	var cost = 0
	
	if dozens < 0:
		$lblDozen.text = "Cost per dozen: Error"
	elif dozens < 4:
		$lblDozen.text = "Cost per dozen: $0.50"
		cost += 0.50
	elif dozens < 6:
		$lblDozen.text = "Cost per dozen: $0.45"
		cost += 0.45
	elif dozens < 11:
		$lblDozen.text = "Cost per dozen: $0.40"
		cost += 0.40
	elif dozens >= 11:
		$lblDozen.text = "Cost per dozen: $0.35"
		cost += 0.35
		
	var single = cost / 12
	var total = (dozens * cost) + single * extra 
	
	$lblCost.text = "Total Cost: $%.2f" % total 
	
func _on_btn_clear_pressed() -> void:
	$txtEggs.text = ""
	$lblDozen.text = "Cost per dozen:"
	$lblCost.text = "Total Cost" 


func _on_btn_exit_pressed() -> void:
	get_tree().quit()
