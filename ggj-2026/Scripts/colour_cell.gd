extends Area2D
class_name ColorCell

# The ColorRect for the colour of the cell
var _colour: ColorRect
var _collision: CollisionShape2D
var _absorb: Color

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
	var rect		 = RectangleShape2D.new()
	rect.size		 = Vector2(0.5, 0.5)

	# Adding it as a child of the Area2D
	_collision.shape = rect

	# Connecting necessary signals
	self.connect("area_entered", _on_area_entered)
	self.connect("area_exited", _on_area_entered)

func _process(delta: float) -> void:

	# Absorbing the colour
	if Input.is_action_pressed("absorb"):

		# Changing colours
		_colour.color = _absorb

# Detecting entering another area
func _on_area_entered(area: Area2D):

	# Getting the colour to absorb
	var absorbable_colour:AbsorbableColor = area as AbsorbableColor
	_absorb 						  	  = absorbable_colour.GetColor()

# Detecting leaving another area
func _on_area_exited(area: Area2D):
	print("exited")
