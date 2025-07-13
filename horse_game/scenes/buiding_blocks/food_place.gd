extends Area3D

@export var food_amount := 1

func interact(player):
	if player.has_method("add_food"):
		player.add_food(food_amount)
