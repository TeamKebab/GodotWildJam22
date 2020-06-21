extends Node

signal deaths_changed(player_deaths)
signal gravity_changed(new_gravity)
signal character_chosen(character)
signal player_hit()

var player_deaths = 0
var gravity = Vector2(0,0)
var character = "Righty"

func hit_player():
	emit_signal("player_hit")
		
func change_player_deaths(health_change):
	player_deaths -= health_change
	emit_signal("deaths_changed", player_deaths)

func change_gravity(new_gravity):
	gravity = new_gravity
	emit_signal("gravity_changed", new_gravity)

func choose_character(new_character):
	character = new_character
	AudioPlayer.play_sound("choose_character")
	SceneLoader.first_level()
	emit_signal("character_chosen", new_character)
	
func can_turn_left():
	return character == "Lefty" or character == "God"
	
func can_turn_right():
	return character == "Righty" or character == "God"
	
func restart():
	player_deaths = 0
	SceneLoader.start_screen()
