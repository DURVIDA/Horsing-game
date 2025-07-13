extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var slot = Gamestate.slot
var money = Gamestate.money
var food = Gamestate.food

func _ready() -> void:
	animation_player.play("RESET")
	hide()
func resume() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().paused = false
	animation_player.play_backwards("blur")
	hide()
	
func pause() -> void:
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
	SaveManager.save_game({
	"slot" : slot,
	"food": food,
	"money": money,
	})
	resume()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://scenes/UI/startmenu.tscn")


func _process(_delta: float) -> void:
	testPause()
