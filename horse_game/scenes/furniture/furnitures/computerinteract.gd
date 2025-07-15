extends Area3D



func interact(player):
	if player.has_method("open_store"):
		player.open_store()

func upgrade(player):
	if player.has_method("upgrade_store"):
		player.upgrade_store()
