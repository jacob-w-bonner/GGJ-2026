extends Area2D
class_name ColorCell

# The ColorRect for the colour of the cell
var _colour: ColorRect
var _collision: CollisionShape2D
var _absorb: Color
var _last_absorbable_colour_entered:AbsorbableColor = null

const CHANGE_SPEED 		= 3.0
const DURATION = 20.0
var elapsed_time		= 0.0

@onready var splat_scene = preload("res://Scenes/absorbable_colour.tscn")

# Setting up the cell
func _ready() -> void:

	# Default colour for absorb
	_absorb			 = Globals.DEFAULT_COL

	# Adding the colour rects to the scene tree
	_colour 		 = ColorRect.new()
	self.add_child(_colour)

	# Setting the default cell colour
	_colour.set_color(Globals.DEFAULT_COL)
	_colour.size	 = Vector2(1, 1)

	# Setting the collision object
	_collision 		 = CollisionShape2D.new()
	self.add_child(_collision)

	# Making a collision shape for the area
	var rect		 = CircleShape2D.new()
	rect.radius		 = 0.45

	# Adding it as a child of the Area2D
	_collision.shape = rect

	# Connecting necessary signals
	self.connect("area_entered", _on_area_entered)

func _process(delta: float) -> void:

	# Absorbing the colour
	if Input.is_action_pressed("absorb"):

		# Absorbing the colour
		absorb_colour(delta)
		## Getting the distance between the colours
		#var dist  	  = sqrt(pow(_colour.color.r - _absorb.r, 2) + pow(_colour.color.g - _absorb.g, 2) + pow(_colour.color.b - _absorb.b, 2))
#
		## Speed calculation
		#var speed 	  = CHANGE_SPEED * clamp(dist, 0.0, 1.0)
#
		## Interpolate towards the colour
		#_colour.color = _colour.color.lerp(_absorb, speed * delta)
		#elapsed_time  = 0.0
#
		## 
		#if dist < 0.01:
			#dist = 0.0

# Absorbing a colour
func absorb_colour(delta: float) -> void:

	if not has_overlapping_areas():
		return
	
	# Getting the distance between the colours
	var dist  	  = sqrt(pow(_colour.color.r - _absorb.r, 2) + pow(_colour.color.g - _absorb.g, 2) + pow(_colour.color.b - _absorb.b, 2))

	# If the distance is very close then just set the colour
	if dist < 0.1:
		_colour.color = _absorb
		return

	# Speed calculation
	var speed 	  = CHANGE_SPEED * clamp(dist, 0.0, 1.0)

	# Interpolate towards the colour
	_colour.color = _colour.color.lerp(_absorb, speed * delta)
	elapsed_time  = 0.0

# Move towards colour
func towards_colour(target: Color, delta: float) -> void:

	# Incrementing time
	elapsed_time += delta

	# The ratio of completeness
	var time	  = clamp(elapsed_time / DURATION, 0.0, 1.0)

	# Setting the colour
	_colour.color = _colour.color.lerp(target, time)

# Getter for the colour
func get_colour() -> Color:
	return _colour.get_color()

# Setter for the colour
func set_colour(new_col: Color) -> void:
	_colour.color = new_col

# Called to eject paint colour as a new absorbable and reset the cell
func splat() -> void:
	
	if(_colour.color != Globals.DEFAULT_COL):
		if(_last_absorbable_colour_entered != null):
			_last_absorbable_colour_entered.SplatOn(_colour.get_color())
	
	# Creating a new absorbable
	var new_splat 	  = splat_scene.instantiate()
	get_tree().root.get_child(0).add_child(new_splat)

	# Setting the properties of the new splat
	var col			  = _colour.get_color()
	new_splat.SetColor(col)
	new_splat.set_scale(Vector2(1.0 / Globals.PLAYER_X, 1.0 / Globals.PLAYER_Y))
	new_splat.set_global_position(self.global_position)
	new_splat.z_index = 50

	# Resetting the cell colour
	_colour.color 	  = Globals.DEFAULT_COL
	elapsed_time	  = 0.0
	


# Detecting entering another area
func _on_area_entered(area: Area2D):
	# Getting the colour to absorb
	_last_absorbable_colour_entered = area as AbsorbableColor
	#TODO: add check for if _last_absorbable_colour_entered is not cast as a "AbsorbableColor" object
	_absorb 						= _last_absorbable_colour_entered.GetColor()

func IsHidden() -> bool:
	if _last_absorbable_colour_entered == null:
		return false
	
	var hidden:bool = _last_absorbable_colour_entered.TrueIfArgumentColourIsWithinTolerance(_colour.color)
	
	return hidden
