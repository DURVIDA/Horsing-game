extends Control


func _on_volumeslider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/startmenu.tscn")
