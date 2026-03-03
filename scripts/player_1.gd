extends Node2D

var _mana = 3

var _cards_glossar = {
	"Soldat beschwören" : 1, 
	"Magier beschwören" : 1
} # name : cost


var _deck = []

var _hand = []
var _hand_size = 5

var _units_glossar = {
	"Soldat" : [100, 16, ["Hieb", "Schild"]],  
	"Magier" : [70, 10, ["Feuerball", "Eisspeer"]]
}   #name(unit_type) : [hp, move range, [skills]]

var units = []:
	get:
		return units



func _add_unit(x, y, unit_type):
	if(x <= get_parent().Map_x && y <= get_parent().Map_y && x >= 0 && y >= 0):
		if(get_parent().Map[y][x][0] == 0): # x und y vertauscht, da die x in y gespeichert sind
			var id = get_parent()._assign_id()
			get_parent().Map = [x, y, [id, -7]]
			var trgt_unit = get_parent().base_unit.instantiate()
			trgt_unit.name = "unit_%d" % id
			self.add_child(trgt_unit)
			var pos_x = (x - y) * get_parent().tile_width / 2
			var pos_y = (x + y) * get_parent().tile_height / 2
			trgt_unit._spawn(pos_x, pos_y)
			units.append({"name" : unit_type, "hp" : get_hp_base(unit_type), "idx" : id})
		else:
			push_error("space occupied")
	else:
		push_error("unit placed in Void")



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

#
#func _add_card_to_deck(card):
	#for card in _cards_glossar:
		#if(card[""])


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
