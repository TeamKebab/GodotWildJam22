extends Node

const titles = [
	{
		"deaths": 5,
		"title": "LA  MOSCA  fan",
		"sprite": "res://Sprites/Medals/green.png"
	},
	{
		"deaths": 1,
		"title": "Flying  Snake  hugger",
		"sprite": "res://Sprites/Medals/blue.png"
	},
]

func _ready():
	find_node("DeathCounter").text = str(PlayerVariables.player_deaths)
	
	for title in titles:
		if PlayerVariables.player_deaths >= title["deaths"]:
			set_title(title)
	
	if PlayerVariables.player_deaths < 1:
		find_node("Title").text = "GOD  of  the  ROBOLUTION"
		var texture = AnimatedTexture.new()
		texture.frames = 3
		texture.set_frame_texture(0, load("res://Sprites/Medals/gold.png"))
		texture.set_frame_texture(1, load("res://Sprites/Medals/silver.png"))
		texture.set_frame_texture(2, load("res://Sprites/Medals/bronze.png"))
		find_node("Medal").texture = texture
		
		
func set_title(title):
	find_node("Title").text = title.title
	find_node("Medal").texture = load(title.sprite)
	
func _input(event):
	if event is InputEventKey and event.pressed:
		PlayerVariables.restart() 

