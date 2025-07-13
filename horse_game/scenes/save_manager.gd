extends Node

# Number of save slots
const SAVE_SLOT_COUNT = 3

var slot = Gamestate.slot
var money = Gamestate.money
var food = Gamestate.food
# Save file prefix
const SAVE_PATH := "user://save_slot_"

func save_game(data: Dictionary) -> void:
	if slot < 1 or slot > SAVE_SLOT_COUNT:
		push_error("Invalid save slot: %d" % slot)
		return
	
	var file_path = "%s%d.json" % [SAVE_PATH, slot]
	var file = FileAccess.open(file_path, FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	print("✅ Game saved to slot %d" % slot, money, food)


func load_game(_slott: int) -> Dictionary:
	_slott = slot
	if _slott < 1 or _slott > SAVE_SLOT_COUNT:
		push_error("Invalid load slot: %d" % _slott)
		return {}
	
	var file_path = "%s%d.json" % [SAVE_PATH, _slott]
	
	if not FileAccess.file_exists(file_path):
		print("❌ No save file in slot %d" % _slott)
		return {}

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
