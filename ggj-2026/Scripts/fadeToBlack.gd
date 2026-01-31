extends CanvasModulate

signal fade_done 

var speed = 1;
var fading_out = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fading_out: 
		fade(delta)
	if (color.r <= 0): 
		fade_done.emit()



func _on_fade_out():
	fading_out = true
	print("gonna fade out!")


func fade(delta): 
	var rgbVal = color.r - delta*speed
	color = Color(rgbVal, rgbVal, rgbVal, 255)
	
	
	
	
