extends Area2D
class_name ColorCell

# The ColorRect for the colour of the cell
var _colour: ColorRect
var _collision: CollisionShape2D
var _absorb: Color
var _last_absorbable_colour_entered:AbsorbableColor = null

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

# Getter for the colour
func get_colour() -> Color:
	return _colour.get_color()

# Setter for the colour
func set_colour(new_col: Color) -> void:
	_colour.color = new_col

# Called to eject paint colour as a new absorbable and reset the cell
func splat() -> void:

	# Creating a new absorbable
	var new_splat = splat_scene.instantiate()
	get_tree().root.get_child(0).add_child(new_splat)

	# Setting the colour of the new splat
	new_splat.SetColor(_colour.get_color())

	# Resetting the cell colour
	_colour.color = Globals.DEFAULT_COL

# Detecting entering another area
func _on_area_entered(area: Area2D):
	# Getting the colour to absorb
	_last_absorbable_colour_entered = area as AbsorbableColor
	#TODO: add check for if _last_absorbable_colour_entered is not cast as a "AbsorbableColor" object
	_absorb 						= _last_absorbable_colour_entered.GetColor()

# Detecting leaving another area
func _on_area_exited(area: Area2D):
	print("exited")

func IsHidden() -> bool:
	if _last_absorbable_colour_entered == null:
		return false
	
	var hidden:bool = _last_absorbable_colour_entered.TrueIfArgumentColourIsWithinTolerance(_colour.color)
	
	return hidden
