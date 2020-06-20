extends MarginContainer

var deaths = 0
onready var death_counter = find_node("DeathCounter")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerVariables.connect("deaths_changed", self, "_on_PlayerVariables_deaths_changed")
	
	change_deaths(PlayerVariables.player_deaths)
	pass # Replace with function body.

func _on_PlayerVariables_deaths_changed(player_deaths):
	change_deaths(player_deaths)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func change_deaths(player_deaths):
	deaths = player_deaths
	death_counter.text = str(player_deaths)
	
func _on_Music_toggled(button_pressed):
	PlayerVariables.set_play_music(button_pressed)


func _on_Effects_toggled(button_pressed):
	PlayerVariables.set_play_sounds(button_pressed)
