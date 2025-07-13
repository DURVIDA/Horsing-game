extends CSGBox3D


@export var clouds_to_spawn := 200
@export var _cloud : PackedScene
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawn_clouds()



var rng = RandomNumberGenerator.new()

func spawn_clouds() -> void:
	rng.randomize()
	while clouds_to_spawn >= 0:
		clouds_to_spawn -= 1
		
		var x = rng.randf_range(size.x/2, -size.x/2)
		var y = rng.randf_range(size.y/2, -size.y/2)
		var z = rng.randf_range(size.z/2, -size.z/2)
		
		var spawn_pos = Vector3(x,y,z)
		
		var cloud := _cloud.instantiate()
		add_child(cloud)
		cloud.global_position = self.global_position + spawn_pos
