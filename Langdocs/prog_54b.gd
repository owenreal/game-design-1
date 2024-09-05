extends Control

func _on_btn_calc_pressed() -> void:
	var num1 = int($num1.text)
	var num2 = int($num2.text)
	var num3 = int($num3.text)
	var num4 = int($num4.text)
	
	var sum = num1 + num2 + num3 + num4
	var average = sum / 4
	
	# $lblSum.text = 
	# $lblAverage.text = 

func _on_btn_clear_pressed() -> void:
	pass

func _on_btn_exit_pressed() -> void:
	get_tree().quit()
