extends TextureButton

signal fade_out
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _pressed():
	fade_out.emit()

func _on_fade_done() -> void:
	get_tree().reload_current_scene()
