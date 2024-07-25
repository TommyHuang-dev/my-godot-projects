extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_pos = get_node("../Player").position
	var camera_base_bounds = [1280 / 2, 720 / 2]
	var horizontal_required_zoom = 1
	var vertical_required_zoom = 1
	horizontal_required_zoom = min(1, (camera_base_bounds[0] - 100) / abs(player_pos[0]))
	vertical_required_zoom = min(1, (camera_base_bounds[1] - 100) / abs(player_pos[1]))
	var required_zoom = min(horizontal_required_zoom, vertical_required_zoom)
	set_zoom(Vector2(required_zoom, required_zoom))
