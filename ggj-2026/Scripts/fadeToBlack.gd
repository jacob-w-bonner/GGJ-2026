extends CanvasModulate

@onready var game_over_ui = $"../Game_over_restart"
@onready var restart_level_button = $"../RestartButton"

signal fade_done 

var speed = 1;
var game_overing = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	game_over_ui.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_overing: 
		game_over_ui.visible = true
			

func _on_game_over():
	game_overing = true	
	restart_level_button.visible = false 
	

	
	
