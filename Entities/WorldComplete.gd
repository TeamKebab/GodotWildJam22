extends Area2D

func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	
	for body in bodies:
		if body.name == "Player":
			SceneLoader.next_level()
			AudioPlayer.play_sound("loading_player")
	pass
