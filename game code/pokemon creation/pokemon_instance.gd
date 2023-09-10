extends Node

var display_name

var pokemon_stat_location
var pokemon_species

var hp
var atk
var def
var spatk
var spdef
var speed

var hp_iv
var atk_iv
var def_iv
var spatk_iv
var spdef_iv
var speed_iv

var nature_name

var gender

var level
var current_xp
var xp_to_level

var current_hp
var current_atk
var current_def
var current_spatk
var current_spdef
var current_speed

var shiny = false
var feinted

var front_sprite
var back_sprite

# List of natures and stat modifiers 
# Nature: [atk, def, spatk, spdef, speed]
const NATURE_DICT = {
	"Hardy": [1, 1, 1, 1, 1],
	"Docile": [1, 1, 1, 1, 1],
	"Bashful": [1, 1, 1, 1, 1],
	"Quirky": [1, 1, 1, 1, 1],
	"Serious": [1, 1, 1, 1, 1],
	
	"Bold": [0.9, 1.1, 1, 1, 1],
	"Modest": [0.9, 1, 1.1, 1, 1],
	"Calm": [0.9, 1, 1, 1.1, 1],
	"Timid": [0.9, 1, 1, 1, 1.1],
	
	"Lonely": [1.1, 0.9, 1, 1, 1],
	"Mild": [1, 0.9, 1.1, 1, 1],
	"Gentle": [1, 0.9, 1, 1.1, 1],
	"Hasty": [1, 0.9, 1, 1, 1.1],
	
	"Adamant": [1.1, 1, 0.9, 1, 1],
	"Impish": [1, 1.1, 0.9, 1, 1],
	"Careful": [1, 1, 0.9, 1.1, 1],
	"Jolly": [1, 1, 0.9, 1, 1.1],
	
	"Naughty": [1.1, 1, 1, 0.9, 1],
	"Lax": [1, 1.1, 1, 0.9, 1],
	"Rash": [1, 1, 1.1, 0.9, 1],
	"Naive": [1, 1, 1, 0.9, 1.1],
	
	"Brave": [1.1, 1, 1, 1, 0.9],
	"Relaxed": [1, 1.1, 1, 1, 0.9],
	"Quiet": [1, 1, 1.1, 1, 0.9],
	"Sassy": [1, 1, 1, 1.1, 0.9]
}

func create_poke(species, init_level, nature):
	pokemon_species = species
	
	level = init_level
	
	gender = randomize_gender(species.gender_ratio_female)
	
	nature_name = nature
	
	if randi_range(1, 8192) == 1:
		shiny = true
		
	if shiny:
		front_sprite = species.sprite_front_shiny
		back_sprite = species.sprite_back_shiny
	else:
		front_sprite = species.sprite_front
		back_sprite = species.sprite_back
	
	hp_iv = randi_range(0, 31)
	atk_iv = randi_range(0, 31)
	def_iv = randi_range(0, 31)
	spatk_iv = randi_range(0, 31)
	spdef_iv = randi_range(0, 31)
	speed_iv = randi_range(0, 31)
	
	set_stat_total()
	
	current_hp = hp
	current_atk = atk
	current_def = def
	current_spatk = spatk
	current_spdef = spdef
	current_speed = speed
	
	feinted = false

func set_stat_total():
	var atk_nature = NATURE_DICT[nature_name][0]
	var def_nature = NATURE_DICT[nature_name][1]
	var spatk_nature = NATURE_DICT[nature_name][2]
	var spdef_nature = NATURE_DICT[nature_name][3]
	var speed_nature = NATURE_DICT[nature_name][4]
	
	hp = floor((2 * pokemon_species.hp + hp_iv) * level / 100) + level + 10
	atk = floor((floor((2 * pokemon_species.attack + atk_iv) * level / 100) + 5) * atk_nature)
	def = floor((floor((2 * pokemon_species.defense + def_iv) * level / 100) + 5) * def_nature)
	spatk = floor((floor((2 * pokemon_species.sp_attack + spatk_iv) * level / 100) + 5) * spatk_nature)
	spdef = floor((floor((2 * pokemon_species.sp_defense + spdef_iv) * level / 100) + 5) * spdef_nature)
	speed = floor((floor((2 * pokemon_species.speed + speed_iv) * level / 100) + 5) * speed_nature)

func set_level(new_level):
	level = new_level
	set_stat_total()

func get_display_name():
	return display_name
	
func get_species():
	return pokemon_species

func randomize_gender(female_ratio):
	#code for randomizing gender based on provided gender ratios
	#it then sets the gender to one of three numbers:
	# 0 = male
	# 1 = female
	# 2 = genderless
	var result
	if female_ratio == -1:
		# genderless
		result = 2
	elif female_ratio == 0:
		# male
		result = 0
	elif female_ratio == 100:
		# female
		result = 1
	else :
		var gender_scale = randf_range(0,100)
		if gender_scale <= female_ratio:
			# female
			result = 1
		else :
			# male
			result = 0
	return result
