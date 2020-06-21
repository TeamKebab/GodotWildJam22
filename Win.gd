extends Node

const titles = [
	{
		"deaths": 200,
		"title": "LA MOSCA fan",
		"sprite": "res://Sprites/Medals/rusty.png"
	},
	{
		"deaths": 100,
		"title": "Flying Snake hugger",
		"sprite": "res://Sprites/Medals/blue.png"
	},
	{
		"deaths": 50,
		"title": "Meatballorite gazer",
		"sprite": "res://Sprites/Medals/green.png"
	},
	{
		"deaths": 20,
		"title": "R8-e's pizza pal",
		"sprite": "res://Sprites/Medals/orange.png"
	},
	{
		"deaths": 10,
		"title": "L7-ee's apprentice",
		"sprite": "res://Sprites/Medals/bronze.png"
	},
	{
		"deaths": 5,
		"title": "Adept Spinner",
		"sprite": "res://Sprites/Medals/silver.png"
	},
	{
		"deaths": 1,
		"title": "Robulutionary Sage",
		"sprite": "res://Sprites/Medals/gold.png"
	},
]

var input_enabled = false

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
	
	input_enabled = false
		
func set_title(title):
	find_node("Title").text = title.title
	find_node("Medal").texture = load(title.sprite)
	
func _input(event):
	if input_enabled and event is InputEventKey and event.pressed:
		PlayerVariables.restart() 



func _on_Timer_timeout():
	input_enabled = true
