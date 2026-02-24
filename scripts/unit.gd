extends Node

var _x
var _y


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


func spawn(spawn_x, spawn_y):
	var pos_x = spawn_x
	var pos_y = spawn_y
	#var pos_x = (x / $TileMapLayer.tile_set.tile_size.x + y / $TileMapLayer.tile_set.tile_size.y) * $TileMapLayer.tile_set.tile_size.x
	#var pos_y = (y / $TileMapLayer.tile_set.tile_size.y - x / $TileMapLayer.tile_set.tile_size.x) * $TileMapLayer.tile_set.tile_size.y
	print(pos_x)
	print(pos_y)
	$UnitPh.position = Vector2(pos_x, pos_y)
	
	#var iso_delta = Vector2(
					#(dx / tile_width + dy / tile_height) * tile_width,
					#(dy / tile_height - dx / tile_width) * tile_height
				#)
				
#var world_x = (tile_x - tile_y) * (tile_size.x / 2.0)
#var world_y = (tile_x + tile_y) * (tile_size.y / 2.0)
#
#var world_pos = Vector2(world_x, world_y)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
