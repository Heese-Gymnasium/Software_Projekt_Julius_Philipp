extends Node

var _x
var _y


var _units_glossar = {
	"Soldat" : [100, 16, ["Hieb", "Schild"]],
	"Magier" : [70, 10, ["Feuerball", "Eisspeer"]]
}

var glossar = _units_glossar.get

var _unit_glosssar:
	get:
		return _units_glossar

var x:
	get:
		_x
	set(value):
		_x = value
		
var y:
	get:
		_y
	set(value):
		_y = value
		

func _get_hp_base(unit_type):
	return glossar[unit_type[0]]
	
	
func _get_range_base(unit_type):
	return glossar[unit_type[1]]
	
	
func _get_skills_base(unit_type):
	return glossar[unit_type[3]]



func _spawn(spawn_x, spawn_y):
	var pos_x = spawn_x
	var pos_y = spawn_y
	self.position = Vector2(pos_x, pos_y)
	
	
	
func _move_menu():
	$Camera2d.align()
	if InputEventMouseButton:
		_move(4)
	
	
func _move(range):
	var tar_xy = Vector2($Highlight_Manager.tile_coords)
	if((tar_xy - Vector2(_x, _y)).abs().length() <= range):
		_x = x
		_y = y


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
