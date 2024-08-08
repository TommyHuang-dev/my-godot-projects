extends Camera2D


func _ready():
	pass # Replace with function body.


func _process(delta):
	var PlayerGroup = get_tree().get_nodes_in_group("PlayerGroup")
	if len(PlayerGroup) > 0:
		var player_pos = PlayerGroup[0].position
		position = player_pos  # for now, have the camera follow the player
		var distance = player_pos.length()
		var distance_zoom = 1 / clamp(distance / 200, 1, 4)
		set_zoom(Vector2(distance_zoom, distance_zoom))
