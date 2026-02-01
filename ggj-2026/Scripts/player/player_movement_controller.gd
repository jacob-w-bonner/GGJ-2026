extends RigidBody2D


##got the RigidBody based movemnt code form here: https://www.youtube.com/watch?v=PKPcoR_yIvE
@export var gravity = 980

@export var groundMovementForce = 1000 # How fast the player will move (pixels/sec).
@export var groundDragForce = 1000; # How fast the player will stop (pixels/sec).

@export var sidewaysAirMovementForce = 1000
@export var downwardAirMovementForce = 1000
@export var jumpStrength = 500
@export var coyotetime:float = 0.1 ##the length of time that they player can still jump after leaving at serface

@onready var right_ray_cast: RayCast2D = $"Right-RayCast2D"
@onready var left_ray_cast: RayCast2D = $"Left-RayCast2D"
@onready var collision_shape: CollisionShape2D = $CollisionShape2D


# sprites and animators 
@onready var faceSprite = $Face
@onready var bodyAnimator = $Body 
@onready var colorBody = $ColorBody 

var inputVector:Vector2
var grounded = false
var timeSinceLastTouchedGround = 0;

func _ready() -> void:
	bodyAnimator.play("standing")
	faceSprite.play("neutral")
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	##this block gets the WASD player input and converts it into a Vector2 
	handleAnimation()
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
	
	var dropDown:bool = (inputVector.y != 1)
	self.set_collision_mask_value(2, dropDown)


func handleAnimation():
	if Input.is_action_pressed("move_left") || Input.is_action_pressed("move_right") || Input.is_action_pressed("move_up") || Input.is_action_pressed("move_down"):
		bodyAnimator.play("walking")
	else: 
		bodyAnimator.play("standing")
	if Input.is_action_pressed("move_left"):
		faceSprite.flip_h = 1
	if Input.is_action_pressed("move_right"):
		faceSprite.flip_h = 0
	
func _integrate_forces(state: PhysicsDirectBodyState2D):
	
	##GroundCheck############################
	grounded = ((right_ray_cast.is_colliding() == true) || (right_ray_cast.is_colliding() == true))
	
	##Gravity############################
	state.apply_central_force(Vector2(0, gravity))
	

	if(grounded == true):
		##GroundMovement############################
		var inputVelocityDelta:float = inputVector.x * groundMovementForce * state.step
		var frictionVelocityDelta:float = move_toward(0, -self.linear_velocity.x, groundDragForce * state.step)

		if(sign(inputVelocityDelta) == sign(frictionVelocityDelta)):
			#if the player is applying input, and the friction would be in the same direction, only apply the friction
			self.linear_velocity.x += frictionVelocityDelta
		elif(inputVector.x == 0):
			#if the player is not applying any input, only add frictionVelocityDelta
			self.linear_velocity.x += frictionVelocityDelta
		else:
			#if the player is applying input, and the friction would fight agisnt the players input, only apply the players input
			self.linear_velocity.x += inputVelocityDelta

	
	elif(grounded == false):
		##AirMovement############################
		#downward plunge movement
		if(inputVector.y > 0):
			state.apply_central_force(Vector2.DOWN * inputVector.y * downwardAirMovementForce);
			
		#in air left/right movement
		state.apply_central_force(Vector2(inputVector.x * sidewaysAirMovementForce, 0));

	##JumpCode#################################
	#if we are grounded we can jump
	if(grounded == true):
		timeSinceLastTouchedGround = coyotetime;
	
	#if we are still in coyotetime, count down until we are not 
	if(timeSinceLastTouchedGround != 0):
		timeSinceLastTouchedGround = move_toward(timeSinceLastTouchedGround, 0, state.step)

	#if we are in coyotetime, we can jump 
	if(timeSinceLastTouchedGround != 0):
		if Input.is_action_pressed("move_up"):
			timeSinceLastTouchedGround = 0;##we can no longer jump
			set_linear_velocity( Vector2(get_linear_velocity().x, -jumpStrength) );
