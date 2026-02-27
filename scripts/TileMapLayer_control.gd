extends Node

@onready var _Map: Array

@onready var _Map_x = 39
@onready var _Map_y = 39

@onready var tile_width = self.tile_set.tile_size.x
@onready var tile_height = self.tile_set.tile_size.y


var map_preview = []

var units = []

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
					_Map[y[x[0]]] = arr[0]
				elif arr[0] == -7:
					_Map[y[x[1]]] = arr[1]
				else:
					_Map[y[x]] = arr
		else:
			push_error("value for _Map.set must be of type: [x, y, [int/String, int],...] or same type as _Map: [ y: [x: [int/String, int] ]]")
			# eine -7 im terraintyp (der 2te Wert des innersten Arrays) ändert den Wert nicht
				
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
			
		if not (arr[0] is int or arr[0] is String):
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


func _initialize_Map(x, y):
	var line = []
	for i in range(x):
		line.append([0, 1]) #0 ist die Unit, die das Feld belegt, wobei 0 für keine unit auf dem Feld steht, 1 ist der terraintyp
	map_preview.resize(y)
	map_preview.fill(line)
	Map = map_preview


func _add_unit(x, y, unit_type):
	if(x <= Map_x && y <= Map_y && x >= 0 && y >= 0):
		Map.set([x, y, [unit_type, -7]])
		var trgt_unit = base_unit.instantiate()
		self.add_child(trgt_unit)
		var pos_x = (x - y) * tile_width / 2
		var pos_y = (x + y) * tile_height / 2
		trgt_unit._spawn(pos_x, pos_y)
		units.append({"name" : unit_type, "hp" : trgt_unit.get_hp_base(unit_type)})
	else:
		push_error("unit placed in Void")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_initialize_Map(Map_x, Map_y)
	_add_unit(1, 1, "base")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
