extends Node

# The number of colour cells in each direction for the player
const PLAYER_X: 	float  	= 16.0
const PLAYER_Y: 	float 	= 16.0

# Scale for the player
const PLAYER_SCALE: Vector2 = Vector2(3.7, 3.7)

#1,5,4
var CHECKERS = false

var GRADIENT = false
var STICK_MAN_TORSO = false
var STICK_MAN_NECK = false
var ADDS_ONE = false
var ADDS_TWO = false

var MIX = false
var TETRIS = false
var SUN = false
var EYE = false

# Default colour
var DEFAULT_COL: 	Color 	= Color(1.0, 1.0, 1.0, 1.0)

var HUEDIFFERENCETOLERANCE:float = 0.10
