extends CanvasModulate

@onready var game_over_ui = $Game_over_restart

signal fade_done 

var speed = 1;
var fading_out = false
var game_overing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_ui.visible = false
	game_overing = true
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fading_out: 
		fade(delta, 0)
		if (color.r <= 0): 
			fade_done.emit()
	if game_overing: 
		fade(delta, 75)
		if (color.r <= 75):
			game_over_ui.visible = true
			

func _on_game_over():
	game_overing = true	

func _on_fade_out():
	fading_out = true


func fade(delta, stop_point): 
	
	var rgbVal = color.r - delta*speed
	if (rgbVal > stop_point):
		color = Color(rgbVal, rgbVal, rgbVal, 255)
	
	
	
	
