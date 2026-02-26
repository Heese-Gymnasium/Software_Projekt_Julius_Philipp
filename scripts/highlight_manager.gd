extends Node2D

var highlight_map: TileMapLayer
var mouse_old_pos: Vector2
var tile_coords_old : Vector2i
var tileMapLayer : TileMapLayer
@onready var ts
@onready var source_id := 1
@onready var render_offset : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	highlight_map = self.get_parent().get_node("Highligth_Map")
	tileMapLayer = self.get_parent().get_node("TileMapLayer")
	ts = highlight_map.tile_set
	render_offset = ts.get_source(source_id).get_tile_origin()
	mouse_old_pos = get_global_mouse_position() - render_offset
	var local_pos_old : Vector2 = tileMapLayer.to_local(mouse_old_pos)
	tile_coords_old = tileMapLayer.local_to_map(local_pos_old)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos := get_global_mouse_position()
	var local_pos : Vector2 = tileMapLayer.to_local(mouse_pos)
	var tile_coords = tileMapLayer.local_to_map(local_pos)
	var atlas_coords := Vector2i(3, 0)

	highlight_map.set_cell(tile_coords, source_id, atlas_coords)
	if tile_coords != tile_coords_old:
		atlas_coords = Vector2i(3, 1)
		highlight_map.set_cell(tile_coords_old, source_id, atlas_coords)
		tile_coords_old = tile_coords
	mouse_old_pos = mouse_pos
	
	
