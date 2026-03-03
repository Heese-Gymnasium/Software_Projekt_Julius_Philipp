extends Node

var _x
var _y

var tile_coords = Vector2i(_x, _y) 

var protected = 0


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
		if(action == "Hieb"):
			self._hieb
		if(action == "Schild"):
			self._schild
		if(action == "Eisspeer"):
			self._eisspeer
		if(action == "Feuerball"):
			self._feuerball


var highlight_manager = get_tree().root.get_node("Main/root_tile/Highlight_Manager")

func _hieb():
	highlight_manager.attack_highlight(2, tile_coords)

func _schild():
	protected += 1

func _eisspeer():
	highlight_manager.attack_highlight(12, tile_coords)

func _feuerball():
	highlight_manager.attack_highlight(15, tile_coords)


func _die():
	self.queue_free()



func _move(unit_type):
	var map_preview = get_node("/root/Main/root_tile/TileMapLayer").Map.get
	var range = get_parent().get_range_base(unit_type)
	var tar_xy = Vector2(get_node("/root/Main/root_tile/TileMapLayer").tile_coords)
	if((tar_xy - Vector2(_x, _y)).abs().length() <= range):
		get_node("/root/Main/root_tile/TileMapLayer").Map.set([_x, _y, [0, -7]])
		_x = x
		_y = y
		get_node("/root/Main/root_tile/TileMapLayer").Map.set([_x, _y, [unit_type, -7]])


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
