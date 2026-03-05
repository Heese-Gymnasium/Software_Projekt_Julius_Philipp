extends Node

var _x : int
var _y : int
var idx : int

var protected = 0


var x:
	get:
		return _x
	set(value):
		_x = value

var y:
	get:
		return _y
	set(value):
		_y = value





func _spawn(spawn_x, spawn_y):
	var pos_x = spawn_x
	var pos_y = spawn_y
	self.position = Vector2(pos_x, pos_y)



#func _move_menu():
	#$Camera2d.align()
	#if InputEventMouseButton:
		#_move($TileMapLayer.Map[y[x[0]]])


func _handle_action(action, unit_type):
	var actions = get_parent().get_skills_base(unit_type)
	if actions.has(action):
		if(action == "Move"):
			_move(unit_type)
		if(action == "Hieb"):
			_hieb()
		if(action == "Schild"):
			_schild()
		if(action == "Eisspeer"):
			_eisspeer()
		if(action == "Feuerball"):
			_feuerball()



func _move(unit_type):
	var tile_coords = Vector2i(_x - 1, _y - 1)
	get_parent().last_attack = "Move"
	get_parent().anti_Phlipflop_arbeitszeitbetrugs_index = idx
	get_node("/root/Main/root_tile/Highlight_Manager").attack_highlight(get_parent().get_range_base(unit_type), tile_coords)

func _hieb():
	var tile_coords = Vector2i(_x - 1, _y - 1)
	get_parent().last_attack = "Hieb"
	get_parent().anti_Phlipflop_arbeitszeitbetrugs_index = idx
	get_node("/root/Main/root_tile/Highlight_Manager").attack_highlight(2, tile_coords)

func _schild():
	protected += 1

func _eisspeer():
	var tile_coords = Vector2i(_x - 1, _y - 1)
	get_parent().last_attack = "Eisspeer"
	get_parent().anti_Phlipflop_arbeitszeitbetrugs_index = idx
	get_node("/root/Main/root_tile/Highlight_Manager").attack_highlight(12, tile_coords)

func _feuerball():
	var tile_coords = Vector2i(_x - 1, _y - 1)
	get_parent().last_attack = "Feuerball"
	get_parent().anti_Phlipflop_arbeitszeitbetrugs_index = idx
	get_node("/root/Main/root_tile/Highlight_Manager").attack_highlight(15, tile_coords)


func _die():
	self.queue_free()



func _finish_move(idx, trgt_coords):
	print("move beenden...")
	var trgt_x = trgt_coords.x + 1
	var trgt_y = trgt_coords.y
	if(trgt_x <= get_parent().get_parent().Map_x && trgt_y <= get_parent().get_parent().Map_y && trgt_x >= 0 && trgt_y >= 0):
		print("in map")
		if(get_parent().get_parent().Map[y][x][0] == 0):
			print("feld leer")
			get_parent().get_parent().Map[trgt_coords.y][trgt_coords.x][0] = idx
			get_parent().get_parent().Map[y][x][0] = 0
			var pos_x = (trgt_x - trgt_y) * get_parent().get_parent().tile_width / 2
			var pos_y = (trgt_x + trgt_y) * get_parent().get_parent().tile_height / 2
			self.position = Vector2(pos_x, pos_y)
			print(self.position)
			x = trgt_x
			y = trgt_y
		else:
			print("space occupied")
	else:
		print("cant move in void")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
