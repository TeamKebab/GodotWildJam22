extends MarginContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var hearts = [
	$HBoxContainer/Heart,
	$HBoxContainer/Heart2,
	$HBoxContainer/Heart3,
	$HBoxContainer/Heart4,
	$HBoxContainer/Heart5
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
	
