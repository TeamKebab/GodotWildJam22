extends Node

const START_HEALTH = 5

signal health_changed(player_health)

var player_health = START_HEALTH

func change_player_health(health_change):
	player_health += health_change
	emit_signal("health_changed", player_health)
	
	if player_health <= 0:
		get_tree().change_scene("res://GameOver.tscn")
	
func restart():
	player_health = START_HEALTH
	get_tree().change_scene("res://Levels/World.tscn")
