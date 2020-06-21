extends Node

func _ready():
	find_node("DeathCounter").text = str(PlayerVariables.player_deaths)
	
func _input(event):
	if event is InputEventKey and event.pressed:
		PlayerVariables.restart() 

