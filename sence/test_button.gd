extends Button


func _ready() -> void:
	pass # Replace with function body.

func _pressed() -> void:
	get_tree().change_scene_to_file("res://sence/test1.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
