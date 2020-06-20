extends Area2D

export(String, FILE, "*.tscn") var world_scene

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			PlayerVariables.load_level(world_scene)
	pass
