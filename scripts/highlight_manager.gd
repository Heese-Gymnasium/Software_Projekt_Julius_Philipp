extends Node2D

@export var highlight_map_path: NodePath

var highlight_map: TileMap
var current_cell: Vector2i


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	#highlight_map = get_node(highlight_map_path)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#var mouse_world_pos: Vector2 = get_global_mouse_position()
	#var cell: Vector2i = highlight_map.local_to_map(
		#highlight_map.to_local(mouse_world_pos)
	#)
#
	#if cell != current_cell:
		#current_cell = cell
