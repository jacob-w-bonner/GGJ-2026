extends CanvasModulate

@onready var game_over_ui = $"../Game_over_restart"
@onready var restart_level_button = $"../RestartButton"

signal fade_done 

var speed = 1;
var fading_out = false
var game_overing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_ui.visible = false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if fading_out: 
		fade(delta, 0)
		if (color.r <= 0.01):
			print("reloading!") 
			get_tree().reload_current_scene()
	elif game_overing: 
		fade(delta, .5)
		if (color.r <= .75):
			game_over_ui.visible = true
			

func _on_game_over():
	fading_out = false
	game_overing = true	
	restart_level_button.visible = false 
	
func _on_fade_out():
	fading_out = true
	game_overing = false


func fade(delta, stop_point): 
	var rgbVal = color.r - delta*speed
	if (rgbVal > stop_point):
		color = Color(rgbVal, rgbVal, rgbVal, 255)
	
	
	
	
