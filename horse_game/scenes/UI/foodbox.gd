extends Control

@onready var interact_text: Label = %InteractText
@onready var player: Player = $"../../player"

@export var opened := false
func _ready():
	hide()  # Hide when game starts

func open():
	show()
	if interact_text.visible == true:
		interact_text.hide()
	opened = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	set_process_input(true)

func close():
	hide()
	if interact_text.visible == false and player.current_interactable != null:
		interact_text.show()
	opened = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	set_process_input(false)


func _on_playerhorse_pressed() -> void:
	if Gamestate.stored_horsefood > 0:
		Gamestate.horsefood += 1
		Gamestate.stored_horsefood -=1


func _on_storagehorse_pressed() -> void:
	if Gamestate.horsefood > 0:
		Gamestate.horsefood -= 1
		Gamestate.stored_horsefood += 1


func _on_playercow_pressed() -> void:
	pass # Replace with function body.


func _on_storagecow_pressed() -> void:
	pass # Replace with function body.


func _on_playerpig_pressed() -> void:
	pass # Replace with function body.


func _on_storagepig_pressed() -> void:
	pass # Replace with function body.


func _on_back_pressed() -> void:
	close()
