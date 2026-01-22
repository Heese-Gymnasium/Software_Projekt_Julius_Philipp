extends Node

@onready var _Map: Array

@onready var _Map_x = 39
@onready var _Map_y = 39

var map_preview = []

var Map:
	get:
		return _Map
	set(value):
		if typeof(value) == TYPE_ARRAY and value.all(func(v): return typeof(v) == TYPE_ARRAY):
			_Map = value
		else:
			push_error("Map must be an array of arrays")
		
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
		line.append([0, 1]) #0 ist die Unit, die das Felde belegt, wobei 0 für keine unit auf dem Feld steht, 1 ist der terraintyp
	map_preview.resize(y)
	map_preview.fill(line)
	Map = map_preview


func _add_unit(x, y, unit):
	if(x <= Map_x && y <= Map_y && x >= 0 && y >= 0):
		map_preview[y][x][0] = unit
	else:
		push_error("unit placed in Void")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_initialize_Map(Map_x, Map_y)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
