extends Node2D

@export var limit_left: float = -500
@export var limit_right: float = 500
@export var limit_top: float = -500
@export var limit_bottom: float = 500
@export var scroll_speed: float = 400.0
@export var max_speed: float = 600.0
@export var edge_size: int = 100

var left_mouse_down = false
var alt_pos: Vector2
var middle_mouse_down := false
var down = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

@export var speed: float = 200.0

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_MIDDLE:
			if event.is_pressed():
				if middle_mouse_down:
					middle_mouse_down = false
				else:
					middle_mouse_down = true
				#Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			elif event.is_released():
				pass
				#middle_mouse_down = false
				#Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		elif event.button_index == MOUSE_BUTTON_RIGHT:
			if event.is_pressed():
				left_mouse_down = true
				if not down:
					alt_pos = get_viewport().get_mouse_position()
					down = true
			elif event.is_released():
				left_mouse_down = false
				down = false
			


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
	var speed_factor_x = 0.0
	var speed_factor_y = 0.0

	if middle_mouse_down and not left_mouse_down:
		if mouse_pos.x <= edge_size:    
			speed_factor_x = 1.0 - (mouse_pos.x / edge_size)
			movement.x -= speed_factor_x
		elif mouse_pos.x >= viewport_size.x - edge_size:    
			speed_factor_x = 1.0 - ((viewport_size.x - mouse_pos.x) / edge_size)
			movement.x += speed_factor_x
		if mouse_pos.y <= edge_size:    
			speed_factor_y = 1.0 - (mouse_pos.y / edge_size)
			movement.y -= speed_factor_y    
		elif mouse_pos.y >= viewport_size.y - edge_size:
			speed_factor_y = 1.0 - ((viewport_size.y - mouse_pos.y) / edge_size)
			movement.y += speed_factor_y
	elif left_mouse_down:
		if not alt_pos == mouse_pos:
			movement.y = (alt_pos.y - mouse_pos.y)
			movement.x = (alt_pos.x - mouse_pos.x)
			movement = movement.normalized()
			position += movement * delta * speed
		alt_pos = mouse_pos



	if movement != Vector2.ZERO:
		position += movement.normalized() * max_speed * delta * movement.length()
		
