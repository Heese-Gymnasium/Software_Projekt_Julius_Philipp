extends Node

const source_id  := 3

@onready var _Map: Array

@onready var _Map_x = 30
@onready var _Map_y = 30

@onready var tile_width = self.tile_set.tile_size.x
@onready var tile_height = self.tile_set.tile_size.y



var map_preview = []

var next_unit_id = 1

var base_unit = load("res://scenes/unit.tscn")


var Map:
	get:
		return _Map
	set(value):
		if typeof(value) == TYPE_ARRAY and value.all(func(v): return typeof(v) == TYPE_ARRAY):
			_Map = value
		elif typeof(value) == TYPE_ARRAY and validate_packs(value):
			for i in range(0, value.size(), 3):
				var x = value[i]
				var y = value[i+1]
				var arr = value[i+2]
				if(arr[1] == -7):
					_Map[y][x][0] = arr[0]
				elif arr[0] == -7:
					_Map[y][x][1] = arr[1]
				else:
					_Map[y][x] = arr
		else:
			push_error("value for _Map.set must be of type: [x, y, [int, int],...] or same type as _Map: [ y: [x: [int/String, int] ]]")
			# eine -7 ändert den Wert nicht

func validate_packs(pack: Array) -> bool:
	if pack.size() % 3 != 0:
		return false
	for i in range(0, pack.size(), 3):

		var a = pack[i]
		var b = pack[i+1]
		var arr = pack[i+2]

		# 3) a muss int sein
		if not (a is int):
			return false

		# 4) b muss int sein
		if not (b is int):
			return false

		# 5) arr muss Array sein
		if not (arr is Array):
			return false

		# 6) arr muss genau 2 ints enthalten
		if arr.size() != 2:
			return false

		if not (arr[1] is int):
			return false
			
		if not (arr[0] is int):
			return false
	return true

var Map_x:
	get:
		return _Map_x
	set(value):
		_Map_x = value
	
var Map_y:
	get:
		return _Map_y
	set(value):
		_Map_y = value


func print_map():
	for a in range(Map_y):
		print(a)
		print(Map[a])


func _initialize_Map(mapx, mapy):
	for n in range(mapy):
		var line = []
		for i in range(mapx):
			line.append([0, 1]) #0 ist die Unit, die das Feld belegt, wobei 0 für keine unit auf dem Feld steht, 1 ist der terraintyp
		map_preview.append(line)
	Map = map_preview
	for my in range(Map_y):
		for mx in range(Map_x):
			get_node("/root/Main/root_tile/TileMapLayer").set_cell(Vector2i(mx, my), source_id, Vector2i(2, 0))


func _assign_id():
	if not(next_unit_id <= 0):
		var id = next_unit_id
		next_unit_id += 1
		return id
	else:
		push_error("unit idx not valid")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_initialize_Map(Map_x, Map_y)
	$player1._add_unit(1, 1, "Soldat")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
