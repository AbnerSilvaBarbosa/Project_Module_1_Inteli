extends Area2D

const MOVE_SPEED = 100

var _ball_dir
var _up
var _down
var teste = 1.5

onready var _screen_size_y = get_viewport_rect().size.y

func _ready():
#	while position.y > 0:
#		print('Foi')
#		teste = 1

	
	
	var n = String(name).to_lower()
	_up = n + "_move_up"
	_down = n + "_move_down"
	if n == "left":
		_ball_dir = 1
	else:
		_ball_dir = -1
		


func _process(delta):
	# Move up and down based on input.
	var input = Input.get_action_strength("left_move_down") - Input.get_action_strength("left_move_up")
	position.y = clamp(position.y + teste * MOVE_SPEED * delta, 16, _screen_size_y - 16)


func _on_area_entered(area):
	if area.name == "Ball":
		# Assign new direction.
		area.direction = Vector2(_ball_dir, randf() * 2 - 1).normalized()


func _tocouEmbaixo(area):
	if area.name == "Left":
		teste = -1.5
	pass # Replace with function body.


func _on_Ceiling_area_entered(area):
	if area.name == "Left":
		teste = 1.5
	pass # Replace with function body.
