extends Area2D

@export var test:float = 0
@export var player_root:PlayerRoot

var can_pass = false


@export var puzzle1: Node2D
@export var puzzle2: Node2D
@export var puzzle3: Node2D
@export var puzzle4: Node2D
@export var puzzle5: Node2D

@onready var key1 = $Sprite2D/Puzzle1
@onready var key2 = $Sprite2D/Puzzle2
@onready var key3 = $Sprite2D/Puzzle3
@onready var key4 = $Sprite2D/Puzzle4
@onready var key5 = $Sprite2D/Puzzle5

var puzzles = 0

var completedPuzzles = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if (puzzle1 == null):
		key1.visible = false
		puzzles += 1
	if (puzzle2 == null):
		key2.visible = false
		puzzles +=1
	if (puzzle3 == null):
		key3.visible = false
		puzzles +=1 
	if (puzzle4 == null):
		key4.visible = false
		puzzles +=1
	if (puzzle5 == null):
		key5.visible = false 
		puzzles +=1
	
	
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
		

func open_door(): 
	if (puzzles <= completedPuzzles):
		return true
	return false

func _on_completed_puzzle():
	completedPuzzles+=1
	if (completedPuzzles == 1):
		key1.play("solved")
	elif (completedPuzzles == 2):
		key2.play("solved")
	elif (completedPuzzles == 3):
		key3.play("solved")
	elif (completedPuzzles == 4):
		key4.play("solved")
	elif (completedPuzzles == 5):
		key5.play("solved")
		
