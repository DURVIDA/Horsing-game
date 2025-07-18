extends Node

# Number of save slots
const SAVE_SLOT_COUNT = 3


# Save file prefix
const SAVE_PATH := "user://save_slot_"

func save_game(data: Dictionary) -> void:
	if Gamestate.slot < 1 or Gamestate.slot > SAVE_SLOT_COUNT:
		push_error("Invalid save slot: %d" % Gamestate.slot)
		return
	
	var file_path = "%s%d.json" % [SAVE_PATH, Gamestate.slot]
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	print("✅ Game saved to slot %d" % Gamestate.slot, Gamestate.money, Gamestate.horsefood, Gamestate.stored_horsefood)


func load_game(slot: int) -> Dictionary:
	if slot < 1 or slot > SAVE_SLOT_COUNT:
		push_error("Invalid load slot: %d" % slot)
		return {}
	
	var file_path = "%s%d.json" % [SAVE_PATH, slot]
	
	if not FileAccess.file_exists(file_path):
		return {
			"horsefood": 0,
			"money": 100,
			"stored_horsefood": 0,
			"food_level": 1,
			"player_position": { "x": 127, "y": 2, "z": 181 }
		}

	var file = FileAccess.open(file_path, FileAccess.READ)
	var content = file.get_as_text()
	file.close()
	
	var data = JSON.parse_string(content)
	if typeof(data) == TYPE_DICTIONARY:
		print("✅ Loaded slot %d: %s" % [slot, data])
		return data
	else:
		print("⚠️ Error parsing save file.")
		return {}
