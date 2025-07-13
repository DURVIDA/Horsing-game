extends Area3D

@export var hunger := 100.0


func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func interact(player):
	if player.has_method("sell_food"):
		player.sell_food()
