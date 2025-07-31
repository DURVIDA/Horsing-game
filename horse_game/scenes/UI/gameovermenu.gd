extends Control

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	
func _on_restart_from_last_save_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/savemenu.tscn")


func _on_quit_to_title_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/startmenu.tscn")
