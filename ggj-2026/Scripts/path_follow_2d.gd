extends PathFollow2D


enum STATE { PATROLLING, WRINGING_OUT }

var speed = 0.2

var state

func _ready() -> void:
	state = STATE.PATROLLING

func _process(delta: float) -> void:
	match state: 
		STATE.PATROLLING:
			loop_movement(delta)
		STATE.WRINGING_OUT:
			# change this to actual player position later
			var player_pos = Vector2(0,0)		
			pass
		
	
func loop_movement(delta):
	progress_ratio += delta * speed
