extends Node2D

# List of colour cell objects
var _colour_cells = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# Creating the colour cells for the player
	self.create_colour_cells()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:

	# Checking if the player wants to average the colours
	if Input.is_action_pressed("equalize"):
		average_colour_cells(delta)

	# Releasing the absorbed colour behind the cell
	if Input.is_action_just_pressed("splat"):

		# Checking if the cells should splat
		for cell in _colour_cells:
			if cell.get_colour() != Globals.DEFAULT_COL:
				cell.splat()

# This function creates colour cells
func create_colour_cells() -> void:

	# Calculating a starting position
	var start_pos = Vector2(-Globals.PLAYER_X / 2.0, -Globals.PLAYER_Y / 2.0)

	# Creating a series of ColorRects that are the colour cells of the sponge
	for y in range(int(Globals.PLAYER_Y)):
		for x in range(int(Globals.PLAYER_X)):

			# Adding the colour rects to the scene tree
			var new_cell      = ColorCell.new()
			self.add_child(new_cell)

			# Setting a unique name
			new_cell.set_name("Cell_%dx_%dy" % [x, y])

			# Setting the scale and position
			new_cell.scale	  = Globals.PLAYER_SCALE
			new_cell.position = (start_pos + Vector2(x, y)) * Globals.PLAYER_SCALE

			# Adding to list
			_colour_cells.append(new_cell)

# Averaging the colours of all the cells
func average_colour_cells(delta: float) -> void:

	# Array of all the colours
	var cols: Array[Color] = []

	# Getting the colour of each cell
	for cell in _colour_cells:
		cols.append(cell.get_colour())

	# Getting the color average
	var col_avg = blend_colours(cols)

	# Setting each of the cell colours
	for cell in _colour_cells:
		cell.towards_colour(col_avg, delta)

# Called to blend colours in an array
func blend_colours(colours: Array[Color]):
	var r = 0
	var g = 0
	var b = 0

	for colour in colours:
		r+= colour.r
		g+= colour.g
		b+= colour.b
		
	var divider = colours.size()
		
	r = (float)(r / divider) 
	g = (float)(g / divider) 
	b = (float)(b / divider) 
	
	return Color(r,g,b)

#Returns the ratio of how many cells count as hidden
func GetHiddenRatio() -> float:
	var numberOfHiddenCells:float = 0
	for cell in _colour_cells:
		if(cell.IsHidden() == true):
			numberOfHiddenCells += 1
	
	return (numberOfHiddenCells / _colour_cells.size())
