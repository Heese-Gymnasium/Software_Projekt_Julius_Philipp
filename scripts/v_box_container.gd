extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	update_stats({
		"health": 0,
		"mana": 0
	}) # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	

@onready var health_label: Label = $health_label
@onready var mana_label: Label = $mana_label

func update_stats(stats: Dictionary):
	if stats.has("health"):
		health_label.text = "Health: %d" % stats.health

	if stats.has("mana"):
		mana_label.text = "Mana: %d" % stats.mana
