extends Node2D

# Getting the controller node
@onready var controller = $player_controller

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

# Getter for the controller
func get_controller():
	return controller

# Getter for the controller position
func get_controller_pos():
	return controller.get_global_position()
