extends Node2D


var units = []

var tile_map = get_parent()


func _add_unit(x, y, unit_type):
	if(x <= tile_map.Map_x && y <= tile_map.Map_y && x >= 0 && y >= 0):
		if(tile_map.Map[y][x][0] == 0): # x und y vertauscht, da die x in y gespeichert sind
			tile_map.Map = [x, y, [unit_type, -7]]
			var id = tile_map._assign_id()
			var trgt_unit = tile_map.base_unit.instantiate()
			trgt_unit.name = "unit_%d" % id
			self.add_child(trgt_unit)
			var pos_x = (x - y) * tile_map.tile_width / 2
			var pos_y = (x + y) * tile_map.tile_height / 2
			trgt_unit._spawn(pos_x, pos_y)
			units.append({"name" : unit_type, "hp" : trgt_unit.get_hp_base(unit_type), "idx" : id})
		else:
			push_error("space occupied")
	else:
		push_error("unit placed in Void")


func _action(idx, action):
	var type
	for unit in units:
		if(unit["idx"] == idx):
			type = unit["name"]
		else:
			push_error("unit doesnt exist")
	var child_name = "unit_%d" % idx
	var unit = self.find_child(child_name)
	unit._handle_action(action, type)


func _lose_hp(value, idx):
	for unit in units:
		if(unit["idx"] == idx):
			unit["hp"] -= value
			if(unit["hp"] <= 0):
					var child_name = "unit_%d" % idx
					var child = self.find_child(child_name)
					child._die()


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
