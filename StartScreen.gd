extends Control

var character = "God"

func _ready():
	$AudioStreamPlayer2D.connect("finished", self, "_on_character_choosen")
	
func _input(event):
	if event.is_action_pressed("ui_left"):
		choose_character("Lefty")
	elif event.is_action_pressed("ui_right"):
		choose_character("Righty")
	elif event.is_action_pressed("ui_up"):
		choose_character("God")

func _on_character_choosen():
	PlayerVariables.choose_character(character)
	
func choose_character(new_character):	
	character = new_character
	$AudioStreamPlayer2D.play()		
