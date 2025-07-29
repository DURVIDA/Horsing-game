extends Control

@onready var slot_1: Button = $"VBoxContainer/Slot1Stuff/Slot 1"
@onready var slot_2: Button = $"VBoxContainer/Slot2Stuff/Slot 2"
@onready var slot_3: Button = $"VBoxContainer/Slot3Stuff/Slot 3"
@onready var stats: RichTextLabel = %Stats

var slot1toggled := false
var slot2toggled := false
var slot3toggled := false

func _ready() -> void:
	pass
	
func update_slot_label(slot: int, label: RichTextLabel) -> void:
	var data = SaveManager.load_game(slot)
	if data:
		label.text = "		Slot %d
		💰%d
		🍎%d
		📦%d
		Lv.%d" % [
			slot,
			data.get("money", 0),
			data.get("horsefood", 0),
			data.get("stored_horsefood", 0),
			data.get("food_level", 1)
			
		]
	else:
		label.text = "Slot %d\n(Empty)" % slot

func apply_loaded_data(data: Dictionary) -> void:
	if data:
		Gamestate.horsefood = data.get("horsefood", 0)
		Gamestate.money = data.get("money", 100)
		Gamestate.stored_horsefood = data.get("stored_horsefood", 0)
		Gamestate.food_level = data.get("food_level" , 1)
		var pos = data.get("player_position", null)
		if pos:
			Gamestate.player_position = pos
		print("✅ Loaded: %s" % data)
	else:
		print("❌ Failed to load or no data found.")

func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/startmenu.tscn")

func clear_save_slot(slot: int) -> void:
	var file_path = "user://save_slot_%d.json" % slot
	if FileAccess.file_exists(file_path):
		var dir := DirAccess.open("user://")
		if dir:
			dir.remove("save_slot_%d.json" % slot)
			print("🗑️ Save slot %d cleared!" % slot)
		else:
			print("❌ Could not open user directory.")
	else:
		print("⚠️ No save file found in slot %d." % slot)
	
	update_slot_label(slot,stats)  # Refresh UI after clearing

func _on_clear_1_pressed() -> void:
	clear_save_slot(1)


func _on_clear_2_pressed() -> void:
	clear_save_slot(2)


func _on_clear_3_pressed() -> void:
	clear_save_slot(3)


func _on_load_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/world.tscn")

func _on_slot_1_button_down() -> void:
	if %Stats.visible != true:
		%Stats.show()
	update_slot_label(1,stats)
	Gamestate.slot = 1
	var data = SaveManager.load_game(1)
	apply_loaded_data(data)
	Gamestate.slot = 1
	if %Load.visible != true:
		%Load.show()


func _on_slot_2_button_down() -> void:
	if %Stats.visible != true:
		%Stats.show()
	update_slot_label(2,stats)
	Gamestate.slot = 2
	var data = SaveManager.load_game(2)
	apply_loaded_data(data)
	Gamestate.slot = 2
	if %Load.visible != true:
		%Load.show()


func _on_slot_3_button_down() -> void:
	if %Stats.visible != true:
		%Stats.show()
	update_slot_label(3,stats)
	Gamestate.slot = 3
	var data = SaveManager.load_game(3)
	apply_loaded_data(data)
	Gamestate.slot = 3
	if %Load.visible != true:
		%Load.show()
