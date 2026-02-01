extends Area2D

@export var test:float = 0
@export var player_root:PlayerRoot 


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print("Pos:" + player_root.get_controller_pos())
	
	#print(get_tree().current_scene.name)
	if(player_root != null):
		var distanceToPlayer:float = player_root.get_controller_pos().distance_to(self.position)
		print("distanceToPlayer:" + str(distanceToPlayer))
		if(distanceToPlayer < 80):
			go_to_next_level()

#TODO: Change scenes accordingly
func go_to_next_level() -> void:
	# Based on current scene, move to the next scene
	if get_tree().current_scene.name == "Level 1":
		get_tree().change_scene_to_file("res://Scenes/Level 2.tscn")
		
	if get_tree().current_scene.name == "Level 2":
		get_tree().change_scene_to_file("res://Scenes/Level 3.tscn")

	if get_tree().current_scene.name == "Level 3": 
		get_tree().change_scene_to_file("res://Scenes/You Win.tscn")
		
