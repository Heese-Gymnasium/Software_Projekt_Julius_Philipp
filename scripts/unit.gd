extends Node

var _x
var _y


var _units_glossar = {
	"Soldat" : [100, 16, ["Hieb", "Schild"]],
	"Magier" : [70, 10, ["Feuerball", "Eisspeer"]]
}



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


func get_hp_base(unit_type):
	if _units_glossar.has(unit_type):
		return _units_glossar[unit_type][0]
	return null
	

func get_range_base(unit_type):
	if _units_glossar.has(unit_type):
		return _units_glossar.get(unit_type)[1]
	return null

	

func get_skills_base(unit_type):
	if _units_glossar.has(unit_type):
		return _units_glossar.get(unit_type)[2]
	return null




func _spawn(spawn_x, spawn_y):
	var pos_x = spawn_x
	var pos_y = spawn_y
	self.position = Vector2(pos_x, pos_y)
	
	
	
func _move_menu():
	$Camera2d.align()
	if InputEventMouseButton:
		_move($TileMapLayer.Map[y[x[0]]])
	
	
func _move(unit_type):
	var map_preview = $TileMapLayer.Map.get
	var range = self.get_range_base(unit_type)
	var tar_xy = Vector2($Highlight_Manager.tile_coords)
	if((tar_xy - Vector2(_x, _y)).abs().length() <= range):
		$TileMapLayer.Map.set([_x, _y, [0, -7]])
		_x = x
		_y = y
		$TileMapLayer.Map.set([_x, _y, [unit_type, -7]])


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
