extends Node2D

@export var limit_left: float = -500
@export var limit_right: float = 500
@export var limit_top: float = -500
@export var limit_bottom: float = 500
@export var scroll_speed: float = 400.0
@export var edge_size: int = 20
var middle_mouse_down := false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@export var speed: float = 200.0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if event.pressed():
				middle_mouse_down = true
			elif event.is_released():
				middle_mouse_down = false


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
	
	var mouse_pos = get_viewport().get_mouse_position()
	
	var viewport_size = get_viewport().get_visible_rect().size
	
	var movement = Vector2.ZERO
	if mouse_pos.x <= edge_size:    
		movement.x -= 1   
	if mouse_pos.x >= viewport_size.x - edge_size:    
		movement.x += 1   
	if mouse_pos.y <= edge_size:    
		movement.y -= 1    
	if mouse_pos.y >= viewport_size.y - edge_size:
		movement.y += 1


	if movement != Vector2.ZERO:
		movement = movement.normalized()
		position += movement * scroll_speed * delta
		
