extends Node3D

@onready var spring_arm: SpringArm3D = $SpringArm3D

@export var mouse_sensitivity := 0.005
@export_range(-90.0,0.0,0.1, "radians as degrees") var min_vertical_angle : float = -PI/2
@export_range(0.0,90.0,0.1, "radians as degrees") var max_vertical_angle : float = PI/4
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotation.y -= event.relative.x * mouse_sensitivity
		rotation.y = wrapf(rotation.y, 0.0, TAU)
		
		rotation.x -= event.relative.y * mouse_sensitivity
		rotation.x = clamp(rotation.x, min_vertical_angle, max_vertical_angle)
		
	if event.is_action_pressed("zoom_in") and spring_arm.spring_length >= 3:
		spring_arm.spring_length -=1
	if event.is_action_pressed("zoom_out") and spring_arm.spring_length <= 10:
		spring_arm.spring_length +=1
