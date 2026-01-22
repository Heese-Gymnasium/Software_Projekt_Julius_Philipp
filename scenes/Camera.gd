extends Node2D

@export var limit_left: float = -500
@export var limit_right: float = 500
@export var limit_top: float = -500
@export var limit_bottom: float = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@export var speed: float = 200.0

func _process(delta):
	var input_vector = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		input_vector.x += 1
	if Input.is_action_pressed("ui_left"):
		input_vector.x -= 1
	if Input.is_action_pressed("ui_down"):
		input_vector.y += 1
	if Input.is_action_pressed("ui_up"):
		input_vector.y -= 1

	# Normalisieren, damit diagonale Bewegung nicht schneller ist
	if input_vector != Vector2.ZERO:
		input_vector = input_vector.normalized() * 2
	position += input_vector * speed * delta
	var pos = self.position
	pos.x = clamp(pos.x, limit_left, limit_right)
	pos.y = clamp(pos.y, limit_top, limit_bottom)

	position = pos
