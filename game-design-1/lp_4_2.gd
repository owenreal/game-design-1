extends Control

func _on_btn_calc_pressed() -> void:
	var heavy = "Too Heavy"
	var large = "Too Large"
	var accept = "Acceptable Package Size"
	
	var weight = int($txtKg.text)
	var length = int($txtLen.text)
	var width = int($txtWid.text)
	var height = int($txtHeight.text)
	
	var cubic = length * width * height
	
	if weight > 27 and cubic >= 100000:
		$lblResult.text = "Too Heavy and Too Large"
	elif cubic >= 100000: 
		$lblResult.text = "Too Large"
	elif weight > 27:
		$lblResult.text = "Too Heavy"
	else:
		$lblResult.text = "Acceptable Package Size"
	
func _on_btn_clear_pressed() -> void:
	var resets = [$txtKg, $txtLen, $txtWid, $txtHeight]
	$lblResult.text = "Result:" 
	for num in resets:
		num.text = ""
	
func _on_btn_exit_pressed() -> void:
	get_tree().quit()
