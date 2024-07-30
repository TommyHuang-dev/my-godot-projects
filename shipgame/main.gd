extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

var timer = 2

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer -= delta
	
