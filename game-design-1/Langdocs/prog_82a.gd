extends Control

func _on_btn_calc_pressed() -> void:
	var speedLimit = int($txtLimit.text)
	var carSpeed = int($txtSpeed.text)
	var milesOver = carSpeed - speedLimit
	var fine = 20.0 + (milesOver * 5)
	
	$lblFine.text = "$ %.2f" % fine

func _on_btn_clear_pressed() -> void:
	$Label.text = "Speed Limit:"
	$Label2.text = "Vehicle Speed:"
	$Label3.text = "Fine:"
	$lblFine.text = "$"
	
	$txtLimit.text = ""
	$txtSpeed.text = ""
	
func _on_btn_exit_pressed() -> void:
	get_tree().quit() 
