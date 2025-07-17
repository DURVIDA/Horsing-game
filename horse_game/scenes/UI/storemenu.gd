extends Control

@onready var player: Player = $"../../player"

@export var opened := false
func _ready():
	hide()  # Hide when game starts

func open():
	show()
	opened = true
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	set_process_input(true)

func close():
	hide()
	opened = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	set_process_input(false)


func _on_horsefood_pressed() -> void:
	player.add_horsefood()


func _on_cowfood_pressed() -> void:
	pass # Replace with function body.


func _on_pigfood_pressed() -> void:
	pass # Replace with function body.


func _on_back_pressed() -> void:
	close()
