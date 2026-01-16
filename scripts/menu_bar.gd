extends MenuBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	show() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_menue_pressed() -> void:
	show() # Replace with function body.


func _on_popup_menu_id_pressed(id: int) -> void:
	hide() # Replace with function body.
