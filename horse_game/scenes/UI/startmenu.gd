extends Control



func _on_start_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/savemenu.tscn")

func _on_resume_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/optionsmenu.tscn")

func _on_quit_pressed() -> void:
	get_tree().quit()
