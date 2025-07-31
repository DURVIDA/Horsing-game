extends Node3D

@onready var cam_player: Camera3D = $player/CameraOrigin/Camera3D
@onready var cam_birdseye: Camera3D = $worldstuff/Birdseye
@onready var timer: Timer = %DayTimer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_view"):
		if cam_player.is_current():
			cam_birdseye.make_current()
		else:
			cam_player.make_current()


func _on_day_timer_timeout() -> void:
	Gamestate.day += 1
	print("New day: ", Gamestate.day)
