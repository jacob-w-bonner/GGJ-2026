extends Node2D

# List of colour cell objects
var _colour_cells = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:

	# Creating the colour cells for the player
	self.create_colour_cells()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# This function creates colour cells
func create_colour_cells() -> void:

	# Scaling for the cells
	var scale_set = Vector2(1, 1)
	
	# Creating a series of ColorRects that are the colour cells of the sponge
	for y in range(int(Globals.PLAYER_Y)):
		for x in range(int(Globals.PLAYER_X)):

			# Adding the colour rects to the scene tree
			var new_cell      = ColorRect.new()
			self.add_child(new_cell)

			# Setting a unique name
			new_cell.set_name("Cell_%dx_%dy" % [x, y])

			# Setting the default cell colour
			new_cell.set_color(Globals.DEFAULT_COL)

			# Setting the scale and position
			new_cell.size     = scale_set
			new_cell.position = Vector2(x, y)

			# Adding to list
			_colour_cells.append(new_cell)
