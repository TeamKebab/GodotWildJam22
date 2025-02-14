extends MarginContainer

var deaths = 0
onready var death_counter = find_node("DeathCounter")

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerVariables.connect("deaths_changed", self, "_on_PlayerVariables_deaths_changed")
	PlayerVariables.connect("character_chosen", self, "_on_PlayerVariables_character_chosen")
	
	if PlayerVariables.character == "Lefty":
		find_node("PlayerHead").texture.region = Rect2(0,4,40,32)
	else:
		find_node("PlayerHead").texture.region = Rect2(48,4,36,32)
		
	change_deaths(PlayerVariables.player_deaths)
	
	find_node("Music").pressed = AudioPlayer.music_enabled
	find_node("Effects").pressed = AudioPlayer.sounds_enabled

func _on_PlayerVariables_deaths_changed(player_deaths):
	change_deaths(player_deaths)
	pass

func _on_PlayerVariables_character_chosen(character):
	if character == "Lefty":
		find_node("PlayerHead").texture.region = Rect2(0,4,40,32)
	else:
		find_node("PlayerHead").texture.region = Rect2(48,4,36,32)

func change_deaths(player_deaths):
	deaths = player_deaths
	death_counter.text = str(player_deaths)
	
func _on_Music_toggled(button_pressed):
	AudioPlayer.music_enabled = button_pressed

func _on_Effects_toggled(button_pressed):
	AudioPlayer.sounds_enabled = button_pressed
