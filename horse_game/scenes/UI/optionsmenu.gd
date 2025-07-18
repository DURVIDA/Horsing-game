extends Control


func _on_volumeslider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/startmenu.tscn")


func _on_musiccheck_toggled(toggled_on: bool) -> void:
	if toggled_on == false:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),true)
	else:
		AudioServer.set_bus_mute(AudioServer.get_bus_index("Music"),false)


func _on_mousesensslider_value_changed(_value: float) -> void:
	pass


func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/controlsmenu.tscn")


func _on_bindings_pressed() -> void:
	pass # Replace with function body.
