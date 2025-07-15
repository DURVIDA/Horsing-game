extends Node3D

@onready var cam_player: Camera3D = $player/CameraOrigin/Camera3D
@onready var cam_birdseye: Camera3D = $Birdseye


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("toggle_view"):
		if cam_player.is_current():
			cam_birdseye.make_current()
		else:
			cam_player.make_current()
