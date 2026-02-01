extends Node2D
class_name PlayerRoot

# Getting the controller node
@export var controller:RigidBody2D

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
func get_controller_pos() -> Vector2:
	return controller.global_position
