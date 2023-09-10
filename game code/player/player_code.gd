extends CharacterBody2D

const SPEED = 300.0

var tile_size = 80
var moving = false

var is_facing = "south"

var elapsed = 0
var steps = 0

var party = []

var input_call_stack

signal player_moved

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2
	
	input_call_stack = []

func _physics_process(delta):
	if Input.is_action_pressed("move_north") and not input_call_stack.has("move_north"):
		input_call_stack.push_front("move_north")
	if Input.is_action_pressed("move_south") and not input_call_stack.has("move_south"):
		input_call_stack.push_front("move_south")
	if Input.is_action_pressed("move_west") and not input_call_stack.has("move_west"):
		input_call_stack.push_front("move_west")
	if Input.is_action_pressed("move_east") and not input_call_stack.has("move_east"):
		input_call_stack.push_front("move_east")
	
	if Input.is_action_just_released("move_north"):
		elapsed = 0
		if input_call_stack.has("move_north"):
			input_call_stack.remove_at(input_call_stack.find("move_north"))
	if Input.is_action_just_released("move_south"):
		elapsed = 0
		if input_call_stack.has("move_south"):
			input_call_stack.remove_at(input_call_stack.find("move_south"))
	if Input.is_action_just_released("move_west"):
		elapsed = 0
		if input_call_stack.has("move_west"):
			input_call_stack.remove_at(input_call_stack.find("move_west"))
	if Input.is_action_just_released("move_east"):
		elapsed = 0
		if input_call_stack.has("move_east"):
			input_call_stack.remove_at(input_call_stack.find("move_east"))
	
	if !input_call_stack.is_empty() and !moving:
		if input_call_stack[0] == "move_north":
			if is_facing == "north" && elapsed > 0.1:
				make_move(Vector2(0, -1))
			elif is_facing != "north":
				is_facing = "north"
				elapsed += delta
				player_moved.emit()
			else :
				elapsed += delta
		elif input_call_stack[0] == "move_south":
			if is_facing == "south" && elapsed > 0.1:
				make_move(Vector2(0, 1))
			elif is_facing != "south" :
				is_facing = "south"
				elapsed += delta
				player_moved.emit()
			else:
				elapsed += delta
		elif input_call_stack[0] == "move_west":
			if is_facing == "west" && elapsed > 0.1:
				make_move(Vector2(-1, 0))
			elif is_facing != "west":
				is_facing = "west"
				elapsed += delta
				player_moved.emit()
			else:
				elapsed += delta
		elif input_call_stack[0] == "move_east":
			if is_facing == "east" && elapsed > 0.1:
				make_move(Vector2(1, 0))
			elif is_facing != "east":
				is_facing = "east"
				elapsed += delta
				player_moved.emit()
			else:
				elapsed += delta
	
	move_and_slide()

func make_move(motion_vector):
	var new_position = position + motion_vector * tile_size
	var tween = create_tween()
	tween.set_speed_scale(5)
	tween.tween_property(self, "position", new_position, 1).set_trans(Tween.TRANS_SINE)
	moving = true
	await tween.finished
	moving = false
	player_moved.emit()

func add_to_party(pokemon):
	if party.size() < 6:
		party.append(pokemon)
