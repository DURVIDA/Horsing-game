extends Area3D

var is_open = false


func interact(_player):
	if is_open:
		close()
	else:
		open()

func open():
	is_open = true
	get_parent_node_3d().global_rotation.y += deg_to_rad(90)  # instant rotate fallback

func close():
	is_open = false
	get_parent_node_3d().global_rotation.y -= deg_to_rad(90)
	
