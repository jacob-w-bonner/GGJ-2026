extends Area2D

@export var test:float = 0
@export var player_root:PlayerRoot

var can_pass = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	
	pass # Replace with function body.

func pass_level():
	can_pass = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("Pos:" + player_root.get_controller_pos())

	if get_tree().current_scene.name == "Level 1":
		if Globals.CHECKERS:
			can_pass = true
	
	if get_tree().current_scene.name == "Level 2":
		if Globals.GRADIENT and Globals.STICK_MAN_NECK and Globals.STICK_MAN_TORSO and Globals.ADDS_ONE and Globals.ADDS_TWO:
			can_pass = true

	if get_tree().current_scene.name == "Level 3":
		if Globals.MIX and Globals.TETRIS and Globals.SUN and Globals.EYE:
			can_pass = true

	#print(get_tree().current_scene.name)
	if(player_root != null):
		var distanceToPlayer:float = player_root.get_controller_pos().distance_to(self.position)
		if(distanceToPlayer < 80 and can_pass):
			go_to_next_level()

#TODO: Change scenes accordingly
func go_to_next_level() -> void:
	# Based on current scene, move to the next scene

	if get_tree().current_scene.name == "Level 1":
		get_tree().change_scene_to_file("res://Scenes/Level 2 Rough.tscn")
		
	elif get_tree().current_scene.name == "Level 2":
		get_tree().change_scene_to_file("res://Scenes/Level 3 Rough.tscn")

	elif get_tree().current_scene.name == "Level 3":
		get_tree().change_scene_to_file("res://Scenes/You Win.tscn")
		
