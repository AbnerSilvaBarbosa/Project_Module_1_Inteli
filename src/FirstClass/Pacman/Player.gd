extends KinematicBody2D

export (int) var speed = 175

var isMoving = 0
var lastDir = "left"
var FILE_NAME = 'user://infos.json'
var player = {
	'isMobile': false
}

var velocity = Vector2()

func loadInfos():
	var file = File.new()
	if file.file_exists(FILE_NAME): #Verifica se o arquivo já havia sido criado antes
		file.open(FILE_NAME, File.READ) #Le o arquivo local, com infos de vida e XP
		var data = parse_json(file.get_as_text()) #Torna o JSON em objeto para o GODOT
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			player = data #Define player com as informações do arquivo local
		else:
			printerr("Arquivo Corrompido!")
	else:
		printerr("Não existe arquivo!")

func get_input():
	velocity = Vector2()
	if (!MyGlobals.gameOver):
		if (Input.is_action_pressed('ui_right') || (isMoving && lastDir == "right")):
			isMoving = 1
			lastDir = "right"
			velocity.x += 1
			$AnimatedSprite.flip_h = false
		if (Input.is_action_pressed('ui_left') || (isMoving && lastDir == "left")):
			isMoving = 1
			lastDir = "left"
			velocity.x -= 1
			$AnimatedSprite.flip_h = true
		if (Input.is_action_pressed('ui_down') || (isMoving && lastDir == "down")):
			isMoving = 1
			lastDir = "down"
			velocity.y += 1
		if (Input.is_action_pressed('ui_up') || (isMoving && lastDir == "up")):
			isMoving = 1
			lastDir = "up"
			velocity.y -= 1
		velocity = velocity.normalized() * speed
	else:
		velocity = Vector2(0,0)

func _physics_process(delta):
	get_input()
	velocity = move_and_slide(velocity)


func _cimaJoystick():
	Input.action_press("ui_up")


func _baixoJoystick():
	Input.action_press("ui_down")


func _esquerdaJoystick():
	Input.action_press("ui_left")


func _direitaJoystick():
	Input.action_press("ui_right")


func _releaseJoystick():
	Input.action_release("ui_up")
	Input.action_release("ui_down")
	Input.action_release("ui_left")
	Input.action_release("ui_right")
