extends Area2D

@onready var sprite_2d: Sprite2D = $Sprite2D


func GetColor() -> Color:
	return sprite_2d.self_modulate
