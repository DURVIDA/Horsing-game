class_name Player extends CharacterBody3D

const SPEED = 10.0
const JUMP_VELOCITY = 4.5

@onready var pivot: Node3D = $CameraOrigin
@onready var camera: Camera3D = $CameraOrigin/SpringArm3D/Camera3D

@export var sens := 0.5

var current_interactable: Node = null
var food = Gamestate.food
var money = Gamestate.money

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	 
func _unhandled_input(event: InputEvent) -> void:
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotate_y(deg_to_rad(-event.relative.x * sens))
			pivot.rotate_x(deg_to_rad(-event.relative.y * sens))
			pivot.rotation.x = clamp(pivot.rotation.x , deg_to_rad(-90), deg_to_rad(45) )
	pass

func _physics_process(delta: float) -> void:
	
	%Money2.text = str(money)
	%Food2.text = str(food)
	
	#interacting
	if Input.is_action_just_pressed("interact") and current_interactable:
		if current_interactable.has_method("interact"):
			current_interactable.interact(self)
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if is_on_floor():
		if direction:
			velocity.x = direction.x * SPEED
			velocity.z = direction.z * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			velocity.z = move_toward(velocity.z, 0, SPEED)

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
	food += amount
	print("🍎 Food collected: ", food)
	
func sell_food() -> void:
	if food > 0:
		var earnings = 10
		money += earnings
		food -=1
		print("💰 Food sold! Money: ", money)
	else:
		print("❌ No food to sell.")
		
