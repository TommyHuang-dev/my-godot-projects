extends Camera2D


func _ready():
	set_zoom(Vector2(0.5, 0.5))
	pass # Replace with function body.

var offset_difference_move_multi = 3
var mouse_offset_smoothing_min_move = 40
var mouse_offset_smoothing_max_move = 400
var mouse_offset = Vector2(0, 0)

func _process(delta):
	var PlayerGroup = get_tree().get_nodes_in_group("PlayerGroup")
	if len(PlayerGroup) > 0:
		var player_pos = PlayerGroup[0].position
		
		var target_offset = get_local_mouse_position() / 4
		# TODO clean up this code
		if (mouse_offset - target_offset).length() \
			<= mouse_offset_smoothing_min_move * offset_difference_move_multi * delta:
			mouse_offset = target_offset
		else:
			var difference_direction = (target_offset - mouse_offset).normalized()
			var difference_vector = difference_direction * \
					clamp((mouse_offset - target_offset).length() *
							 offset_difference_move_multi,
						mouse_offset_smoothing_min_move, 
						mouse_offset_smoothing_max_move) \
					* delta
			mouse_offset += difference_vector
		
		# camera follows the player but adjust towards mouse aim direction
		position = player_pos + mouse_offset
		
		# remove zooming for now
		#var distance = player_pos.length()
		#var distance_zoom = 1 / clamp(distance / 400, 1, 2)
		#set_zoom(Vector2(distance_zoom, distance_zoom))
