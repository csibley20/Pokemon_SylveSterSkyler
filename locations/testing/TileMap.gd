extends TileMap

var player
var tile_size = 80
var encounter_rate = 320
var steps_since_previous_encounter = 0

#level, pokemon
var day_encounters = [
	[21, load("res://pokemon/trumbeak/trumbeak.tres")],
	[21, load("res://pokemon/trumbeak/trumbeak.tres")],
	[22, load("res://pokemon/trumbeak/trumbeak.tres")],
	[22, load("res://pokemon/trumbeak/trumbeak.tres")],
	[23, load("res://pokemon/trumbeak/trumbeak.tres")],
	[23, load("res://pokemon/trumbeak/trumbeak.tres")],
	[22, load("res://pokemon/brionne/brionne.tres")],
	[23, load("res://pokemon/brionne/brionne.tres")]
]

var night_encounters = [
	[23, load("res://pokemon/primarina/primarina.tres")],
	[22, load("res://pokemon/primarina/primarina.tres")],
	[21, load("res://pokemon/pikipek/pikipek.tres")],
	[21, load("res://pokemon/pikipek/pikipek.tres")]
]

# Called when the node enters the scene tree for the first time.
func _ready():
	player = $"../player".get_node("CharacterBody2D")
	player.connect("player_moved", attempt_encounter)

	var pokemon_creator = $"../pokemon_instance"
	var nature_list = pokemon_creator.NATURE_DICT.keys()
	var nature = nature_list[randi_range(0, nature_list.size()-1)]
	var starter = pokemon_creator
	add_child(starter)
	starter.create_poke(load("res://pokemon/brionne/brionne.tres"), 20, nature)
	print(starter.pokemon_species.species_name)
	player.add_to_party(starter)
	print(player.party[0])

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
			var encounter_index = randi_range(0, day_encounters.size()-1)
			var rand_encounter = day_encounters[encounter_index][1]
			var encounter_lvl = day_encounters[encounter_index][0]
			var pokemon_creator = $"../pokemon_instance"
			var nature_list = pokemon_creator.NATURE_DICT.keys()
			var nature = nature_list[randi_range(0, nature_list.size()-1)]
			
			var wild_encounter = pokemon_creator
			wild_encounter.create_poke(rand_encounter, encounter_lvl, nature)
			
			if player.party.size() > 0 :
				$"../battle_scene".battle_start(player.party[0], wild_encounter, "wild", "none")
			else:
				print("welp")
