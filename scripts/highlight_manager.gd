extends Node2D

var tile_coords:
	get:
		return tile_coords
var highlight_map: TileMapLayer
var mouse_old_pos: Vector2
var tile_coords_old : Vector2i
var tileMapLayer : TileMapLayer
const source_id := 1
const render_offset := Vector2i(-1, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
	highlight_map = self.get_parent().get_node("Highligth_Map")
	tileMapLayer = self.get_parent().get_node("TileMapLayer")
	mouse_old_pos = get_global_mouse_position() 
	var local_pos_old : Vector2 = tileMapLayer.to_local(mouse_old_pos)
	tile_coords_old = tileMapLayer.local_to_map(local_pos_old) + render_offset


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos := get_global_mouse_position()
	var local_pos : Vector2 = tileMapLayer.to_local(mouse_pos)
	tile_coords = tileMapLayer.local_to_map(local_pos) + render_offset
	var atlas_coords := Vector2i(3, 0)

	highlight_map.set_cell(tile_coords, source_id, atlas_coords)
	if tile_coords != tile_coords_old:
		atlas_coords = Vector2i(3, 1)
		highlight_map.set_cell(tile_coords_old, source_id, atlas_coords)
		tile_coords_old = tile_coords
	mouse_old_pos = mouse_pos

	
