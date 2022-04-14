extends Area2D

const MOVE_SPEED = 100

var _ball_dir
var _up
var _down

var FILE_NAME = 'user://infos.JSON'

var player = {
	'isMobile': false
}

onready var _screen_size_y = get_viewport_rect().size.y

func loadIsMobile():
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			player = data
			return data
		else:
			printerr("Arquivo corrompido")
	else:
		printerr("Sem informações salvas!")

func _ready():
	loadIsMobile()
	var n = String(name).to_lower()
	_up = n + "_move_up"
	_down = n + "_move_down"
	if n == "left":
		_ball_dir = 1
	else:
		_ball_dir = -1
		
func moveDireita():
	position.y -= 5

func moveDireitaBaixo():
	position.y += 5

func _process(delta):
	# Move up and down based on input.
	var input = Input.get_action_strength("right_move_down") - Input.get_action_strength("right_move_up")
	position.y = clamp(position.y + input * MOVE_SPEED * delta, 16, _screen_size_y - 16)


func _on_area_entered(area):
	if area.name == "Ball":
		# Assign new direction.
		area.direction = Vector2(_ball_dir, randf() * 2 - 1).normalized()


func _touchUpPong():
	moveDireita()


func _touchDownPong():
	moveDireitaBaixo()
