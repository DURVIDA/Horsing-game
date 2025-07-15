extends Control

@onready var slot_1: Button = $"VBoxContainer/Slot 1"
@onready var slot_2: Button = $"VBoxContainer/Slot 2"
@onready var slot_3: Button = $"VBoxContainer/Slot 3"
@onready var stats: Label = %Stats
@onready var stats_2: Label = %Stats2
@onready var stats_3: Label = %Stats3

func _ready() -> void:
	update_slot_labels()

func update_slot_labels() -> void:
	update_slot_label(1, stats)
	update_slot_label(2, stats_2)
	update_slot_label(3, stats_3)

func update_slot_label(slot: int, label: Label) -> void:
	var data = SaveManager.load_game(slot)
	if data:
		label.text = "Slot %d\n💰%d | 🍎%d | 📦%d | Lv.%d" % [
			slot,
			data.get("money", 0),
			data.get("food", 0),
			data.get("stored_food", 0),
			data.get("food_level", 1)
		]
	else:
		label.text = "Slot %d\n(Empty)" % slot
	

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


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/startmenu.tscn")
