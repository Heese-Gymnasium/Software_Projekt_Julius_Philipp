extends MarginContainer
var unit = [
	{"name": "Soldat", "hp": 100},
	{"name": "Bogenschütze", "hp": 70},
	{"name": "Magier", "hp": 50}
]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_unit_buttons(unit) # Replace with function body.

@onready var vbox := $VBoxContainer
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func create_unit_buttons(units):
	# Alte Buttons löschen (falls Units sich ändern)
	for child in vbox.get_children():
		child.queue_free()

	for unit in units:
		var button := Button.new()
		
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
		# Optional: Theme / Style
		#button.add_theme_font_size_override("font_size", 18)

		# Signal verbinden
		#button.pressed.connect(_on_unit_button_pressed.bind(unit))

		vbox.add_child(button)
