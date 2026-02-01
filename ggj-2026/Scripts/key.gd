extends AnimatedSprite2D

var changed = false

var completed = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.play("unsolved")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if changed: 
		pass
	elif completed:
		changed = true
		self.play("solved")
	   
