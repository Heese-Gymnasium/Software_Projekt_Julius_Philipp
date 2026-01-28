extends MarginContainer

@onready var main_active: int = 0
@onready var unit_main := $VBoxContainer
@onready var cards_main := $Card_Container

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_parent().show()
	show()
	on_turn_start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func on_turn_start():
	var active_player = get_active_player()
	var cards = get_cards(active_player)
	create_card_buttons(cards)
	var units = get_units(active_player)
	create_unit_buttons(units)


func _on_units_pressed() -> void:
	unit_main.show() 
	cards_main.hide()
	main_active = 0


func _on_cards_pressed() -> void:
	unit_main.hide()
	cards_main.show()
	main_active = 1
	

func create_unit_buttons(units):
	# Alte Buttons löschen (falls Units sich ändern)
	for child in unit_main.get_children():
		child.queue_free()

	for unit in units:
		var button := Button.new()
		button.add_theme_color_override("font_color", "009f8e")
		button.add_theme_color_override("font_hover_color", Color.ORANGE)
		button.add_theme_color_override("font_pressed_color", Color.WHITE)
		button.add_theme_color_override("font_disabled_color", Color.GRAY)

		# Text
		button.text = unit.name + " (HP: %d)" % unit.hp
		
		# Mindestgröße
		button.custom_minimum_size = Vector2(200, 40)
		
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

		unit_main.add_child(button)



func create_card_buttons(cards):
	# Alte Buttons löschen (falls Units sich ändern)
	for child in unit_main.get_children():
		child.queue_free()

	for card in cards:
		var button := Button.new()
		button.add_theme_color_override("font_color", "009f8e")
		button.add_theme_color_override("font_hover_color", Color.WHITE)
		button.add_theme_color_override("font_pressed_color", Color.WHITE)
		button.add_theme_color_override("font_disabled_color", Color.GRAY)

		# Text
		button.text = card.name + " (Cost: %d)" % card.cost
		
		# Mindestgröße
		button.custom_minimum_size = Vector2(200, 40)
		
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

		cards_main.add_child(button)
func get_active_player() -> int:
	return 0

func get_units(active_player):
	var units = [
	{"name": "Soldat", "hp": 100},
	{"name": "Bogenschütze", "hp": 70},
	{"name": "Magier", "hp": 50}]
	return units
	
func get_cards(active_player):
	var cards = [
	{"name": "Card1", "cost": 100},
	{"name": "Card2", "cost": 70},
	{"name": "Card3", "cost": 50}]
	return cards
