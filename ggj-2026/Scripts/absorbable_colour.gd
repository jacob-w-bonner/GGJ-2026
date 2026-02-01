extends Area2D
class_name AbsorbableColor

@onready var sprite_2d: Sprite2D = $Sprite2D

#testing the TrueIfArgumentColourIsWithinTolerance() function
#func _ready() -> void:
	#var c1:Color = Color.from_hsv(0.66,1,1,1)
	#var a:bool = TrueIfArgumentColourIsWithinTolerance(c1)
	#print("a:" + str(a))

func GetColor() -> Color:
	return sprite_2d.self_modulate


#returns true if the argumentColour is close to this AbsorbableColor's colouro
func TrueIfArgumentColourIsWithinTolerance(argumentColour:Color) -> bool:
	var ourHue:float = sprite_2d.self_modulate.h
	var argumentHue:float = argumentColour.h
	
	#We need to do all this shit because the hues are circular, but like numbers arent.... you know what I mean?
	var hueDifference_upShifted = (argumentHue + 1) - ourHue
	var hueDifference_normal = ourHue - argumentHue
	var hueDifference_downShifted = (argumentHue - 1) - ourHue
	var realHueDifference:float = min(min(abs(hueDifference_upShifted), abs(hueDifference_normal)), abs(hueDifference_downShifted))
	
	return (realHueDifference <= Globals.HUEDIFFERENCETOLERANCE)
