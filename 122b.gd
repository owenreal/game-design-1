extends Control

func _on_btn_show_pressed() -> void:
	var line = ""
	for num in range(2, 36+1, 2):
			line += str(num)
			$ItemList.add_item(line)

#fix this its weird

func _on_btn_clear_pressed() -> void:
	$ItemList.clear()


func _on_btn_exit_pressed() -> void:
	get_tree().quit()
