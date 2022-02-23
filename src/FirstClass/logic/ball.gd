extends Area2D

const DEFAULT_SPEED = 150

var _speed = DEFAULT_SPEED
var direction = Vector2.RIGHT

#
#func addPoints():
#	#$Pontos.text = '2'

onready var _initial_pos = position

func _process(delta):
	_speed += delta * 2
	position += _speed * delta * direction


func reset():
	direction = Vector2.RIGHT
	position = _initial_pos
	_speed = DEFAULT_SPEED
