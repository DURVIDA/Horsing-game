extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var player: Player = $"../../player"
@onready var interact_text: Label = %InteractText



var slot = Gamestate.slot


func _ready() -> void:
	animation_player.play("RESET")
	hide()
func resume() -> void:
	if interact_text.visible == false and player.current_interactable != null:
		interact_text.show()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	animation_player.play_backwards("blur")
	hide()
	
func pause() -> void:
	if interact_text.visible == true:
		interact_text.hide()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().paused = true
	show()
	animation_player.play("blur")
	
	
func testPause() -> void:
	if Input.is_action_just_pressed("pause") and !get_tree().paused:
		pause()
	elif Input.is_action_just_pressed("pause") and get_tree().paused:
		resume()
func _on_resume_pressed() -> void:
	resume()
	
func _on_restart_pressed() -> void:
	resume()
	get_tree().reload_current_scene()

func _on_quit_pressed() -> void:
	var current_data = {
	"money": Gamestate.money,
	"food": Gamestate.horsefood,
	"stored_food" : Gamestate.stored_horsefood,
	"food_level" : Gamestate.food_level,
	"player_position": {
		"x": player.global_position.x,
		"y": player.global_position.y,
		"z": player.global_position.z
	}
}
	SaveManager.save_game(current_data)
	resume()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://scenes/UI/startmenu.tscn")


func _process(_delta: float) -> void:
	testPause()
