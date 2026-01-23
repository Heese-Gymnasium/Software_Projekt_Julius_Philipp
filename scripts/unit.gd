extends Node

var _x
var _y

var x:
	get:
		_x
	set(value):
		_x = value
		
var y:
	get:
		_y
	set(value):
		_y = value


func spawn(spawn_x, spawn_y):
	x = spawn_x
	y = spawn_y
	pos_x = 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
