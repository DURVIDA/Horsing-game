class_name Player extends CharacterBody3D

const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 4.5

@onready var foodbox: Control = $"../CanvasLayer/Foodbox"
@onready var storemenu: Control = $"../CanvasLayer/Storemenu"
@onready var pivot: Node3D = $CameraOrigin
@onready var camera: Camera3D = $CameraOrigin/Camera3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var armature: Node3D = $Armature
@export var sens := 0.5

var current_interactable: Node = null
var speed = WALK_SPEED

func _ready() -> void:
	if Gamestate.player_position:
		global_position = Vector3(
			Gamestate.player_position["x"],
			Gamestate.player_position["y"],
			Gamestate.player_position["z"]
		)

func _physics_process(delta: float) -> void:
	
	var horizontal_velocity = velocity
	horizontal_velocity.y = 0

	if horizontal_velocity.length() > 0.1:
		var direction2 = horizontal_velocity.normalized()
		var target_rotation = atan2(-direction2.x, -direction2.z)
		armature.rotation.y = lerp_angle(armature.rotation.y, target_rotation, delta * 10.0)
	
	#interacting
	if Input.is_action_just_pressed("interact") and current_interactable:
		if current_interactable.name == "ShopTrigger":
			storemenu.open()
		elif current_interactable.name == "FoodStorage":
			foodbox.open()
		else:
			current_interactable.interact(self)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction = Vector3(input_dir.x, 0, input_dir.y).normalized()
	direction = direction.rotated(Vector3.UP, camera.global_rotation.y)
	if is_on_floor():
		if direction:
			velocity.x = direction.x * speed
			velocity.z = direction.z * speed
		else:
			velocity.x = move_toward(velocity.x, 0, speed)
			velocity.z = move_toward(velocity.z, 0, speed)

	#sprint
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	if Input.is_action_just_released("sprint"):
		speed = WALK_SPEED
	
	#animation
	if velocity == Vector3.ZERO:
		animation_player.play("idle")
	if Input.is_action_pressed("sprint"):
		animation_player.play("run")
	if velocity != Vector3.ZERO and !Input.is_action_pressed("sprint"):
		animation_player.play("walk")
		
	move_and_slide()


func _on_interaction_area_area_entered(body: Node3D) -> void:
	if body.has_method("interact"):
		%InteractText.show()
		if body.name == "ShopTrigger":
			current_interactable = body
		current_interactable = body
		print(body)
		
func _on_interaction_area_area_exited(body: Node3D) -> void:
	if body == current_interactable:
		%InteractText.hide()
		current_interactable = null
func add_food(amount: int) -> void:
	Gamestate.horsefood += amount
	print("🍎 Food collected: ", Gamestate.horsefood)
	
func sell_food() -> void:
	if Gamestate.horsefood > 0:
		var earnings = 10
		Gamestate.money += earnings
		Gamestate.horsefood -=1
		print("💰 Food sold! Money: ", Gamestate.money)
	else:
		print("❌ No food to sell.")
