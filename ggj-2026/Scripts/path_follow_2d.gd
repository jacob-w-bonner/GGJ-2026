extends PathFollow2D


@export var speed = 0.2
@export var wait_time = 1.0

@onready var target : float = 0.99 
@onready var guard = $Guard
@onready var waiting = false



func _ready() -> void:
	pass

func _process(delta: float) -> void:
	match guard.state: 
		GuardMovement.State.PATROLLING:
			if (!waiting):
				loop_movement(delta)
		# cancel waiting state if another state is active 
		_:
			waiting = false
		
func loop_movement(delta):
	var prev_target = target

	if (progress_ratio <= target):
		target = 0.99
		progress_ratio += delta * speed;
	if (progress_ratio >= target): 
		target = 0.01 
		progress_ratio += delta * (-speed)
		
	if (prev_target != target):
		waiting = true
		await get_tree().create_timer(wait_time).timeout
		waiting = false
		

	
