extends Control

func _on_btn_calc_pressed() -> void:
	var kilo = float($txtKWH.text)
	
	var base = kilo * 0.0475
	var sur = base * 0.1
	var city = base * 0.03
	var late = base * 0.04
	
	var total = base + sur + city
	var total2 = total + late
	
	$lblBase.text = "Base Total: " + str(base)
	$lblSur.text = "Surcharge: " + str(sur)
	$lblCity.text = "City Tax: " + str(city)
	$lblTotal.text = "Total: " + str(total)
	$lblLate.text = "Late Total: " + str(total2) 

func _on_btn_show_pressed() -> void:
	$lblBase.text = "Base Total:"
	$lblSur.text = "Surcharge:"
	$lblCity.text = "City Tax:" 
	$lblTotal.text = "Total:" 
	$lblLate.text = "Late Total:" 

func _on_btn_exit_pressed() -> void:
	get_tree().quit() 
