extends MarginContainer

@onready var main_active: int = 0
@onready var unit_main := $ScrollContainer/VBoxContainer
@onready var cards_main := $ScrollContainer2/Card_Container
@onready var unit_objekt := $ScrollContainer3/Unit_object_Ui
@onready var unit_main_parent := $ScrollContainer
@onready var cards_main_parent := $ScrollContainer2
@onready var unit_sub_menue := $ScrollContainer3
@onready var unit := await self.get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("root_tile").get_node("TileMapLayer").get_child(0)
var id
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().show()
	show()
	_on_turn_start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_turn_start():
	var active_player = get_active_player()
	var cards = _get_cards(active_player)
	_create_buttons(cards_main, cards)
	var units = _get_units(active_player)
	_create_buttons(unit_main, units)
	unit_main_parent.show() 
	cards_main_parent.hide()
	unit_sub_menue.hide()
	main_active = 0
	
func _handle_button_impact_units(unit):
	unit_main_parent.hide() 
	cards_main_parent.hide()
	unit_sub_menue.show()
	_create_buttons(unit_objekt, unit)
	main_active = 2

	
func _on_units_pressed() -> void:
	unit_main_parent.show() 
	unit_sub_menue.hide()
	cards_main_parent.hide()
	main_active = 0


func _on_cards_pressed() -> void:
	unit_main_parent.hide()
	cards_main_parent.show()
	unit_sub_menue.hide()
	main_active = 1

func get_active_player() -> int:
	return 0

func _get_units(active_player):
	var units = [
	{"name": "Soldat", "hp": 100},
	{"name": "Bogenschütze", "hp": 70},
	{"name": "Magier", "hp": 50},
	{"name": "Soldat", "hp": 100},
	{"name": "Bogenschütze", "hp": 70},
	{"name": "Magier", "hp": 50}]
	return units
	
func _get_cards(active_player):
	var cards = [
	{"name": "Card1", "cost": 100},
	{"name": "Card2", "cost": 70},
	{"name": "Card3", "cost": 50},
	{"name": "Card1", "cost": 100},
	{"name": "Card2", "cost": 70},
	{"name": "Card3", "cost": 50}]
	return cards

func _get_abilitys(unit):
	return unit.get_skills_base(unit)
	#return ["test1", "test2"]
	

func _create_buttons(target, objekts):
	if(objekts is Dictionary):
		id = objekts
		objekts = _get_abilitys(objekts)

	target.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	target.size_flags_vertical = Control.SIZE_EXPAND_FILL
	
	# Alte Buttons löschen (falls Units sich ändern)
	for child in target.get_children():
		child.queue_free()

	for objekt in objekts:
		var button := Button.new()
		button.add_theme_color_override("font_color", Color("#009f8e"))
		button.add_theme_color_override("font_focus_color", Color("#009f8e"))
		button.add_theme_color_override("font_hover_color", Color.WHITE)
		button.add_theme_color_override("font_pressed_color", Color.WHITE)
		button.add_theme_color_override("font_disabled_color", Color.GRAY)

		# Text
		if(objekt is String):
			button.text = objekt
		elif(objekt.has("hp")):
			button.text = objekt.name + " (Hp: %d)" % objekt.hp
		elif(objekt.has("cost")):
			button.text = objekt.name + " (Cost: %d)" % objekt.cost
		else:
			button.text = "objekt not found"
		
		
		# Mindestgröße
		button.custom_minimum_size = Vector2(350, 40)
		button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER
		button.size_flags_horizontal = Control.SIZE_SHRINK_CENTER

		
		var spritesheet: Texture2D = preload("res://assets/Sprout Lands - UI Pack - Basic pack/Sprite sheets/Sprite sheet for Basic Pack.png")
		
		
		var atlas := AtlasTexture.new()
		atlas.atlas = spritesheet
		atlas.region = Rect2(163, 178, 90, 27) # X, Y, Breite, Höhe
		
		var style := StyleBoxTexture.new()
		style.texture = atlas

		# Ränder (für Skalierung wichtig!)
		style.set_texture_margin(SIDE_LEFT, 4)
		style.set_texture_margin(SIDE_RIGHT, 4)
		style.set_texture_margin(SIDE_TOP, 4)
		style.set_texture_margin(SIDE_BOTTOM, 4)
		
		button.add_theme_stylebox_override("normal", style)

		# Signal verbinden
		#button.pressed.connect(_on_unit_button_pressed.bind(unit))
		button.pressed.connect(_handel_sub_input.bind(objekt))
		target.add_child(button)
	
func _handel_sub_input(objekt):
	if(objekt is String):
		_activate_action(objekt)
	elif(objekt.has("hp")):
		_handle_button_impact_units(objekt)
	elif(objekt.has("cost")):
		pass
func _activate_action(action):
	pass
