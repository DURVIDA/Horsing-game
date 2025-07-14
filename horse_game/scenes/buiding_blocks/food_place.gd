extends Area3D


@export var food_amount := 1

func interact(player):
	if player.has_method("add_food") and Gamestate.stored_food > 0:
		player.add_food(food_amount)
		Gamestate.stored_food -= food_amount
	elif Gamestate.stored_food <= 0:
		print("elfogyott az étel, vegyél a számítógépnél" )
