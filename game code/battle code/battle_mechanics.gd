extends Node2D

var weather
var terrain

const PLAYER_DEFAULT = Vector2(0,0)
const ENEMY_DEFAULT = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func battle_start(player_poke, enemy_poke, battle_type, weather_effect):
	weather = weather_effect
	terrain = "none"
	
	self.visible = true
	
	$Player_Sprite.texture = player_poke.pokemon_species.sprite_back
	$Enemy_Sprite.texture = enemy_poke.pokemon_species.sprite_front

