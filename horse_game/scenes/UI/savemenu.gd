extends Control

func _on_slot_1_pressed() -> void:
	Gamestate.slot = 1
	var data = SaveManager.load_game(1)
	apply_loaded_data(data)
	Gamestate.slot = 1
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_slot_2_pressed() -> void:
	Gamestate.slot = 2
	var data = SaveManager.load_game(2)
	apply_loaded_data(data)
	Gamestate.slot = 2
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_slot_3_pressed() -> void:
	Gamestate.slot = 3
	var data = SaveManager.load_game(3)
	apply_loaded_data(data)
	Gamestate.slot = 3
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func apply_loaded_data(data: Dictionary) -> void:
	if data:
		# Example: assuming your player is autoloaded
		Gamestate.food = data.get("food", 0)
		Gamestate.money = data.get("money", 0)
		Gamestate.stored_food = data.get("stored_food", 10)
		Gamestate.food_level = data.get("food_level" , 1)
		print("✅ Loaded: %s" % data)
	else:
		print("❌ Failed to load or no data found.")
