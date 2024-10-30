extends Control

func _on_btn_calc_pressed() -> void:
	var defective = [119,179,189,190,191,192,193,194,195,221,780]
	var model = int($txtModel.text) 
	var result = false
	
	for num in defective:
		if num == model:
			$lblstat.text = "Car status: Defective"
			result = true
		elif not num == model and result == false:
			$lblstat.text = "Car status: Working" 

func _on_btn_clear_pressed() -> void:
	$txtModel.text = ""
	$lblstat.text = "Car status:"

func _on_btn_exit_pressed() -> void:
	get_tree().quit()
