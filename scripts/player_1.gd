extends Node2D

var anti_Phlipflop_arbeitszeitbetrugs_index
var _mana = 3
var mana:
	set(value):
		_mana = max(0, value)
		get_tree().root.get_node("Main/CanvasLayer/IngameUi/MarginContainer/Control/Control_Menue/HBoxContainer/Stats/Stats_shell/Stats_label").update_stats({"mana" : mana})
	get:
		return _mana
var _cards_glossar = [
	{"name" :  "Soldat beschwören", "cost" : 1}, 
	{"name" :  "Magier beschwören", "cost" : 1}
] # name : cost


var _deck = []
var _discard = []
var hand = []
var _hand_size = 5


var _units_glossar = {
	"Soldat" : [100, 16, ["Move", "Hieb", "Schild"]],  
	"Magier" : [70, 10, ["Move", "Feuerball", "Eisspeer"]]
}   #name(unit_type) : [hp, move range, [skills]]

var units = []:
	get:
		return units


var _attacks_glossar = {"Hieb" : 50, "Feuerball" : 40, "Eisspeer" : 30}
var last_attack


func _add_unit(x, y, unit_type):
	if(x < get_parent().Map_x && y < get_parent().Map_y && x >= 0 && y >= 0):
		if(get_parent().Map[y][x][0] == 0): # x und y vertauscht, da die x in y gespeichert sind
			var id = get_parent()._assign_id()
			get_parent().Map = [x, y, [id, -7]]
			var trgt_unit = get_parent().base_unit.instantiate()
			trgt_unit.name = "unit_%d" % id
			trgt_unit.idx = id
			self.add_child(trgt_unit)
			var pos_x = (x - y) * get_parent().tile_width / 2
			var pos_y = (x + y) * get_parent().tile_height / 2
			trgt_unit._spawn(pos_x, pos_y)
			trgt_unit.x = x
			trgt_unit.y = y
			units.append({"name" : unit_type, "hp" : get_hp_base(unit_type), "idx" : id})
			await get_tree().process_frame
			get_tree().root.get_node("Main/CanvasLayer/IngameUi/MarginContainer/Control/Control_Menue/HBoxContainer/main_ui/main_ui_shell").change_units(units)
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



func action(idx, action):
	var c = false
	var type
	for unit in units:
		if(unit["idx"] == idx):
			c = true
			type = unit["name"]
			break
		else:
			push_error("unit doesnt exist")
	var m = false
	if not c:
		for cards in _cards_glossar:
			if(cards.name == action):
				m = true
	if m:
		var H = get_parent().get_parent().get_node("Highlight_Manager")
		H.finish_card(action) 
	elif c:
		var child_name = "unit_%d" % idx
		var unit = self.get_node(child_name)
		unit._handle_action(action, type)


func lose_hp(value, idx):
	var i = 0
	for unit in units:
		i += 1
		if(unit["idx"] == idx):
			unit["hp"] -= value
			if(unit["hp"] <= 0):
					units.remove_at(i)
					var child_name = "unit_%d" % idx
					var child = self.get_node(child_name)
					child._die()
					print(units)


func finish_attack(trgt_coords : Vector2i): #idx ist die agierende unit, nicht das ziel
	var idx = anti_Phlipflop_arbeitszeitbetrugs_index
	var trgt_x = trgt_coords.x
	var trgt_y = trgt_coords.y
	if(last_attack == "Move"):
		var child_name = "unit_%d" % idx
		var child = self.get_node(child_name)
		child._finish_move(idx, trgt_coords)
	var trgt_unit = get_parent().Map[trgt_y][trgt_x][0]
	if(trgt_unit != 0 && last_attack != "Move"):
		lose_hp(_attacks_glossar[last_attack], trgt_unit)
	else:
		push_error("no target")


func _add_card_to_deck(card):
	for cards in _cards_glossar:
		if(cards.name == card):
			_deck.append(card)


func draw_cards(amount):
	await get_tree().process_frame
	var rng = RandomNumberGenerator.new()
	for i in range(amount):
		print(_deck)
		if(_deck.size() > 0):
			var card = rng.randi_range(0, _deck.size() - 1)
			hand.append(_deck[card])
			_deck.remove_at(card)
		elif(_discard.size() > 0):
			self.shuffle_discard_to_deck()
		else:
			push_error("deck empty")
	get_tree().root.get_node("Main/CanvasLayer/IngameUi/MarginContainer/Control/Control_Menue/HBoxContainer/main_ui/main_ui_shell").change_cards(hand)


func shuffle_discard_to_deck():
	_deck.append_array(_discard)
	_discard.clear()

func shuffle_hand_to_discard():
	_discard.append_array(hand)
	hand.clear()


func handle_card(card, trgt_coords : Vector2i):
	var trgt_x = trgt_coords.x
	var trgt_y = trgt_coords.y
	for cards in _cards_glossar:
		if(cards.name ==  card):
			if(mana >= cards.cost):
				if(card == "Soldat beschwören"):
					_add_unit(trgt_x + 1, trgt_y, "Soldat")
					mana -= cards["cost"]
					break
				elif(card == "Magier beschwören"):
					_add_unit(trgt_x + 1 , trgt_y, "Magier")
					mana -= cards["cost"]
					break



func _ready() -> void:
	self._add_card_to_deck("Soldat beschwören")
	self._add_card_to_deck("Magier beschwören")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
