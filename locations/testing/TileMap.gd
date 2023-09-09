extends TileMap

var player
var tile_size = 80
var encounter_rate = 320
var steps_since_previous_encounter = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"../player".get_node("CharacterBody2D")
	player.connect("player_moved", attempt_encounter)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func tile_spot(character):
	return character.position/tile_size - Vector2(0.5, 0.5)

func attempt_encounter():
	steps_since_previous_encounter += 1
	var location = get_cell_atlas_coords(0, tile_spot(player))
	if location == Vector2i(0, 1) && steps_since_previous_encounter > 3:
		if randi_range(0, 2879) < encounter_rate:
			steps_since_previous_encounter = 0
			print("POKEMON")
