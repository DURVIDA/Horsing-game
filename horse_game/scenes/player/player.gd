class_name Player extends CharacterBody3D

const WALK_SPEED = 5.0
const SPRINT_SPEED = 8.0
const JUMP_VELOCITY = 4.5

@onready var pivot: Node3D = $CameraOrigin
@onready var camera: Camera3D = $CameraOrigin/Camera3D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var armature: Node3D = $Armature
@export var sens := 0.5

var current_interactable: Node = null
var speed = WALK_SPEED

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	
	%Money2.text = str(Gamestate.money)
	%Food2.text = str(Gamestate.food)
	
	var horizontal_velocity = velocity
	horizontal_velocity.y = 0

	if horizontal_velocity.length() > 0.1:
		var direction2 = horizontal_velocity.normalized()
		var target_rotation = atan2(-direction2.x, -direction2.z)
		armature.rotation.y = lerp_angle(armature.rotation.y, target_rotation, delta * 10.0)
	
	#interacting
	if Input.is_action_just_pressed("interact") and current_interactable:
		if current_interactable.has_method("interact"):
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
		current_interactable = body
		print(body)

func _on_interaction_area_area_exited(body: Node3D) -> void:
	if body == current_interactable:
		%InteractText.hide()
		current_interactable = null
		
func add_food(amount: int) -> void:
	Gamestate.food += amount
	print("🍎 Food collected: ", Gamestate.food)
	
func sell_food() -> void:
	if Gamestate.food > 0:
		var earnings = 10
		Gamestate.money += earnings
		Gamestate.food -=1
		print("💰 Food sold! Money: ", Gamestate.money)
	else:
		print("❌ No food to sell.")
		
func open_store() -> void:
	if Gamestate.money >= 100:
		Gamestate.stored_food += 10
		Gamestate.money -= 100
		pass
