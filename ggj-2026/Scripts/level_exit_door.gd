extends Area2D

@export var test:float = 0
@export var player:Node2D 

#TODO: Delete 
var counter:int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(get_tree().current_scene.name)
	if(player != null):
		var distanceToPlayer:float = self.position.distance_to(player.position)
		if(distanceToPlayer < 80):
			go_to_next_level()

func go_to_next_level() -> void:
	print("---debug" + str(counter))
	counter += 1
	# Based on current scene, move to the next scene
	if get_tree().current_scene.name == "Level 1":
		print("Go to Level 2! " + str(counter))
		
	if get_tree().current_scene.name == "Level 2":
		print("Go to Level 3! " + str(counter))
		
	if get_tree().current_scene.name == "Level 3": 
		print("You  beat the game!" + str(counter))
		
