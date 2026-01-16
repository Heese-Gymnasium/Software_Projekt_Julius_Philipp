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

		# Optional: Theme / Style
		#button.add_theme_font_size_override("font_size", 18)

		# Signal verbinden
		#button.pressed.connect(_on_unit_button_pressed.bind(unit))

		vbox.add_child(button)
