extends Node

const START_HEALTH = 5

signal health_changed(player_health)
signal gravity_changed(new_gravity)

var player_health = START_HEALTH
var gravity = Vector2(0,0)
var character = "Righty"

func change_player_health(health_change):
	player_health += health_change
	emit_signal("health_changed", player_health)
	
	if player_health <= 0:
		get_tree().change_scene("res://GameOver.tscn")

func change_gravity(new_gravity):
	gravity = new_gravity
	emit_signal("gravity_changed", new_gravity)

func choose_character(new_character):
	character = new_character
	get_tree().change_scene("res://Levels/World.tscn")
	
func can_turn_left():
	return character == "Lefty" or character == "God"
	
func can_turn_right():
	return character == "Righty" or character == "God"
	
func restart():
	player_health = START_HEALTH
	get_tree().change_scene("res://StartScreen.tscn")
	
