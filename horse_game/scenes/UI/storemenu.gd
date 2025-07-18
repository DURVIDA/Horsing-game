extends Control

@onready var player: Player = $"../../player"
@onready var interact_text: Label = %InteractText

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

func _on_horsefood_pressed() -> void:
	if Gamestate.money >= 100:
		Gamestate.stored_horsefood += 9 + Gamestate.food_level
		Gamestate.money -= 100
	pass


func _on_cowfood_pressed() -> void:
	pass # Replace with function body.


func _on_pigfood_pressed() -> void:
	pass # Replace with function body.


func _on_back_pressed() -> void:
	close()
