extends Node2D

@onready var state = GuardMovement.State.PATROLLING
@onready var path: PathFollow2D = get_parent()
@onready var freedom: Node2D = get_parent().get_parent().get_parent()
@onready var animate = $AnimatedSprite2D

@export var speed = 200
@export var player: Node2D
@export var detection_zone: int = 20


signal game_over 


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	match state:
		GuardMovement.State.WRINGING_OUT: 
			game_over.emit()
			global_position  =  global_position.move_toward(player.global_position, delta*speed)
			if abs(player.global_position.x - self.global_position.x) > 20:# || abs(player.global_position.y - self.global_position.y) > 20:
				state = GuardMovement.State.RETURNING_TO_PATH
		GuardMovement.State.RETURNING_TO_PATH: 
			global_position = global_position.move_toward(path.global_position, delta * speed)
			if (global_position == path.global_position): 
				reattach_to_path(path)
		GuardMovement.State.PATROLLING:
			# y comparison to make sure we're on the same vertical level
			if !player.hidden && abs(player.global_position.x - self.global_position.x) <= 20:# && abs(player.global_position.y - self.global_position.y) <= 20:
				state = GuardMovement.State.WRINGING_OUT
	

#temporary state control until player is detectable 
func _unhandled_input(event):
	if event is InputEventKey and event.pressed and event.keycode == KEY_SPACE:
		match state:
			GuardMovement.State.PATROLLING:  
				state = GuardMovement.State.WRINGING_OUT
				detach_from_path()
			GuardMovement.State.WRINGING_OUT:
				state = GuardMovement.State.RETURNING_TO_PATH
			# guard was returning to path, but spotted player again
			GuardMovement.State.RETURNING_TO_PATH: 
				state = GuardMovement.State.WRINGING_OUT
	
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
	path.remove_child(self)
	freedom.add_child(self)
	global_position = world_pos
