extends AudioStreamPlayer2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

@export var playerNode:RigidBody2D
@export var maxVolumeVelocity = 1000; 
@export var maxVolumeMultiple = 24
@export var minVolumeMultiple = -80
@export var maxVolumeChange = 1; 


# Called when the node enters the scene tree for the first time.
func _ready():
	#print(get_node(playerNode).linear_velocity)
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var playerSpeed:float = playerNode.linear_velocity.length()
	var lerpValue = clamp(playerSpeed/maxVolumeVelocity, 0, 1)
	print("playerSpeed:" + str(playerSpeed))
	var newVolume = lerp(minVolumeMultiple, maxVolumeMultiple, lerpValue)
	volume_db = move_toward(volume_db, newVolume, maxVolumeChange * delta)
