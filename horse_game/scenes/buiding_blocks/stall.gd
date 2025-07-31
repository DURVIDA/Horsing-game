extends Area3D

@export var hunger := 100.0
var feed_day : int

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if feed_day+1 ==  Gamestate.day:
		hunger = 50
	elif feed_day+2 ==  Gamestate.day:
		hunger = 1
	elif feed_day+3 == Gamestate.day:
		get_tree().change_scene_to_file("res://scenes/UI/gameovermenu.tscn")

func interact(player):
	if player.has_method("sell_food"):
		player.sell_food()
		feed_day = Gamestate.day
		hunger += 50
		if hunger > 100:
			hunger = 100
