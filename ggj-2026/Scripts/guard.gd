extends Node2D

@onready var state = GuardMovement.State.PATROLLING
@onready var path: PathFollow2D = get_parent()
@onready var freedom: Node2D = get_parent().get_parent().get_parent()

@export var wait_time: float = 0
@export var speed = 200


var player_pos = Vector2(444,203)

func _ready() -> void:
	print("State: patrolling")
	
	
		
func print_state():
	match state: 
		GuardMovement.State.PATROLLING:  
			print("State: patrolling")
		GuardMovement.State.WRINGING_OUT: 
			print("State: wringing out (player spotted)")
		GuardMovement.State.RETURNING_TO_PATH:
			print("State: returning to path (player hid) ")	
			

func _process(delta: float) -> void:
	match state:
		GuardMovement.State.PATROLLING:
			pass
		GuardMovement.State.WRINGING_OUT: 
			pass
			global_position  =  global_position.move_toward(player_pos, delta*speed)
		GuardMovement.State.RETURNING_TO_PATH: 
			global_position = global_position.move_toward(path.global_position, delta * speed)
			if (global_position == path.global_position): 
				reattach_to_path(path)
				print_state()
	

func _unhandled_input(event):
	if event is InputEventKey and event.pressed:
		if event.keycode == KEY_SPACE:
			if (state == GuardMovement.State.PATROLLING):  
				state = GuardMovement.State.WRINGING_OUT
				detach_from_path()
			elif (state == GuardMovement.State.WRINGING_OUT):
				state = GuardMovement.State.RETURNING_TO_PATH
				
			# guard was returning to path, but spotted player again
			elif (state == GuardMovement.State.RETURNING_TO_PATH):
				state = GuardMovement.State.WRINGING_OUT
	print_state()
	
func reattach_to_path(path_follow: PathFollow2D):
	var curve: Curve2D = path_follow.get_parent().curve
	var offset : float = curve.get_closest_offset(global_position)

	path_follow.progress = offset
	freedom.remove_child(self)
	path_follow.add_child(self)
	global_position = path_follow.global_position
	state = GuardMovement.State.PATROLLING
	
func detach_from_path(): 
	var world_pos = global_position
	var scene = get_tree().current_scene 
	path.remove_child(self)
	scene.add_child(self)
	global_position = world_pos
