extends CharacterBody3D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _process(_delta: float) -> void:
	animation_player.play("idle")
