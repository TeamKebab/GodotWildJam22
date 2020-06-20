extends MarginContainer

onready var hearts = [
	$HBoxContainer/Hearts/Heart,
	$HBoxContainer/Hearts/Heart2,
	$HBoxContainer/Hearts/Heart3,
	$HBoxContainer/Hearts/Heart4,
	$HBoxContainer/Hearts/Heart5
]

# Called when the node enters the scene tree for the first time.
func _ready():
	PlayerVariables.connect("health_changed", self, "_on_PlayerVariables_health_changed")
	change_hearts(PlayerVariables.player_health)
	pass # Replace with function body.

func _on_PlayerVariables_health_changed(player_health):
	change_hearts(player_health)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func change_hearts(num_hearts):
	for i in range(0, hearts.size()):
		if i < num_hearts:
			hearts[i].show()
		else:
			hearts[i].hide()
	
func _on_Music_toggled(button_pressed):
	PlayerVariables.set_play_music(button_pressed)


func _on_Effects_toggled(button_pressed):
	PlayerVariables.set_play_sounds(button_pressed)
