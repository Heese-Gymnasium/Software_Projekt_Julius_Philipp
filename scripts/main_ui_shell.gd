extends MarginContainer

@onready var main_active: int = 0
@onready var unit_main := $ScrollContainer/VBoxContainer
@onready var cards_main := $ScrollContainer2/Card_Container
@onready var unit_objekt := $ScrollContainer3/Unit_object_Ui
@onready var unit_main_parent := $ScrollContainer
@onready var cards_main_parent := $ScrollContainer2
@onready var unit_sub_menue := $ScrollContainer3
@onready var active_player = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().show()
	show()
	_on_turn_start()
	print("Units:", _get_units(active_player))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_turn_start():
	var t = get_tree().root.get_node("Main/root_tile/TileMapLayer")
	var player = t.get_child(active_player)
	player.mana = 3
	player.draw_cards(2)           #aktionen, die der Spieler am Anfang des Zuges machen muss
	
	var cards = await _get_cards(active_player)
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
	return active_player

func _get_units(active_player):
	var t = get_tree().root.get_node("Main/root_tile/TileMapLayer")
	var x = t.get_child(active_player).units
	return x

func _get_cards(active_player):
	await get_tree().process_frame
	var t = get_tree().root.get_node("Main/root_tile/TileMapLayer")
	var cards = t.get_child(active_player).hand
	return cards

func _get_abilitys(unit):
	if(unit.has("idx")):
		var target := self.get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("root_tile").get_node("TileMapLayer").get_child(active_player)
		unit = unit.name
		return target.get_skills_base("Soldat")
	else:
		return["Objekt non existant"]

func _create_buttons(target, objekts):
	var id
	if(objekts is Dictionary):
		if(objekts.has("idx")):
			id = objekts.idx
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
		if(objekt is String):
			button.pressed.connect(_handel_sub_input.bind(objekt, id))
		else:
			button.pressed.connect(_handel_sub_input.bind(objekt))
		target.add_child(button)
	
func _handel_sub_input(objekt, id = 0):
	if(objekt is String):
		_activate_action(objekt, id)
	elif(objekt.has("hp")):
		_handle_button_impact_units(objekt)
	elif(objekt.has("cost")):
		_activate_card(objekt)

func _activate_action(action, id):
	var target := self.get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_parent().get_node("root_tile").get_node("TileMapLayer").get_child(active_player)
	target.action(id, action)
	print(id)

func _activate_card(Card):
	pass


func _on_end_turn_pressed() -> void:
	if(active_player == 0):
		active_player = 1
	else:
		active_player = 0
	_on_turn_start()

func change_units(units):
	_create_buttons(unit_main, units)
	
func change_cards(cards):
	_create_buttons(cards_main, cards)
	
