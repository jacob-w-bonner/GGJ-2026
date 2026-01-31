extends RigidBody2D


##got the RigidBody based movemnt code form here: https://www.youtube.com/watch?v=PKPcoR_yIvE
@export var gravity = 980
@export var groundMovementForce = 1000 # How fast the player will move (pixels/sec).
@export var groundDragForce = 1000; 
@export var sidewaysAirMovementForce = 1000
@export var downwardAirMovementForce = 1000
@export var jumpStrength = 500
@export var coyotetime:float = 0.1 ##the length of time that they player can still jump after leaving at serface

@onready var right_ray_cast: RayCast2D = $"Right-RayCast2D"
@onready var left_ray_cast: RayCast2D = $"Left-RayCast2D"

var inputVector:Vector2
var grounded = false
var direction = Vector2.ZERO # The player's movement direction vector.
var timeSinceLastTouchedGround = 0;
var canJump = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	##this block gets the WASD player input and converts it into a Vector2 
	inputVector = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		inputVector.x += 1
	if Input.is_action_pressed("move_left"):
		inputVector.x -= 1
	if Input.is_action_pressed("move_down"):
		inputVector.y += 1
	if Input.is_action_pressed("move_up"):
		inputVector.y -= 1
	inputVector = inputVector.normalized()
	
	print("inputVector:" + str(inputVector));
	






#update loop
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _integrate_forces(state: PhysicsDirectBodyState2D):
	
	#check if the player is touching the gound
	grounded = ((right_ray_cast.is_colliding() == true) || (right_ray_cast.is_colliding() == true))
	
	##GravityCode############################

	##customizable gravity 
	state.apply_central_force(Vector2(0, gravity))
	
	##MovemntCode############################
	
	

	if(grounded == true):
		state.apply_central_force(Vector2(inputVector.x * groundMovementForce, 0));
	elif(grounded == false):
		state.apply_central_force(inputVector * sidewaysAirMovementForce);
	
	##ground-friction Logic
	## if the player is not trying to move left of right and is on the ground, apply a force to brin them to a stop
	if((grounded == true) && (inputVector == Vector2.ZERO)):
		var playerVelocity = self.linear_velocity;
		playerVelocity.x = move_toward(playerVelocity.x, 0, groundDragForce * state.step)
		self.linear_velocity = playerVelocity;

	##jumpCode#################################

	##if we are grounded we can jump
	if(grounded == true):
		timeSinceLastTouchedGround = coyotetime;
	
	##if we are still in coyotetime, count down untill we are not 
	if(timeSinceLastTouchedGround != 0):
		timeSinceLastTouchedGround = move_toward(timeSinceLastTouchedGround, 0, state.step)

	##if we are in coyotetime, we can jump 
	if(timeSinceLastTouchedGround != 0):
		if Input.is_action_pressed("move_up"):
			timeSinceLastTouchedGround = 0;##we can no longer jump
			set_linear_velocity( Vector2(get_linear_velocity().x, -jumpStrength) );
	
	###########################################

	#animation logic 
	#if direction.length() > 0:
		###$AnimatedSprite.play()
		#get_node("AnimatedSprite").play()
	#else:
		###$AnimatedSprite.stop()
		#get_node("AnimatedSprite").stop()
		
	#if(grounded == true):	
		#if direction.x != 0:
			#$AnimatedSprite.animation = "run"
			###$AnimatedSprite.flip_v = false
			#$AnimatedSprite.flip_h = direction.x < 0
		#else:
			#$AnimatedSprite.animation = "idle"
	#else: 
		#if self.linear_velocity.y < 0:
			#$AnimatedSprite.animation = "jump"
		#else:
			#$AnimatedSprite.animation = "fall"
#
		#$AnimatedSprite.flip_h = self.linear_velocity.x < 0


	##elif direction.y != 0:
	##	$AnimatedSprite.animation = "up"
	##	$AnimatedSprite.flip_v = direction.y > 0
	##else:
	##	$AnimatedSprite.animation = "idle"
		

func _on_CanJump_Tigger_Zone_Area2D_body_entered(body):
	if(body.name != "Player"):
		grounded = true

func _on_CanJump_Tigger_Zone_Area2D_body_exited(body):
	if(body.name != "Player"):
		grounded = false
