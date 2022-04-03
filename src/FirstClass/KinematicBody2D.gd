extends KinematicBody2D

var velocity = Vector2.ZERO
var rapidez = 180
onready var animacaoJogador = $AnimationPlayer

var somePressed = false
var buttonPressed

#Começa a animação de correr para a direita
func direita():
	animacaoJogador.play("correndo_para_esquerda") #Começa a animação para direita -- AnimationPlayer
	
#Começa a animação de correr para a esquerda
func esquerda():
	animacaoJogador.play("correndo_para_direita") #Começa a animação para esquerda -- AnimationPlayer

#Começa a animação de correr para baixo
func baixo():
	animacaoJogador.play("correndo_para_baixo") #Começa a animação para baixo -- AnimationPlayer

#Começa a animação de correr para cima
func cima():
	animacaoJogador.play("correndo_para_cima") #Começa a animação para cima -- AnimationPlayer

#Captura os vetores do personagem para descobrir sua direção e velocidade
func _physics_process(_delta):
	var resultante = Vector2.ZERO
	
	if (somePressed == false):
		#Captura em vetor se ele está indo para esquerda ou direita (x) (-1 ou 1)
		resultante.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
		#Captura em vetor se ele está indo para cima ou baixo (y) (-1 ou 1)
		resultante.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
		#Retira o bug de vetores quando se somam vetor nos sentidos x e y
		resultante = resultante.normalized()
		

		#Chama a animação correta, referente ao lado que o personagem está se deslocando
		if Input.get_action_strength("ui_right"):
			direita()
		elif Input.get_action_strength("ui_left"):
			esquerda()
		elif Input.get_action_strength("ui_up"):
			cima()
		elif Input.get_action_strength("ui_down"):
			baixo()
		else:
	#		animacaoJogador.seek(0, true)
			return
	else:
		if (buttonPressed == 'Cima'):
			resultante.y = -1
			cima()
		elif (buttonPressed == 'Baixo'):
			resultante.y = 1
			baixo()
		elif (buttonPressed == 'Esquerda'):
			resultante.x = -1
			esquerda()
		elif (buttonPressed == 'Direita'):
			resultante.x = 1
			direita()
	
	#Verificar a velocidade e dá-la se for necessário.
	if resultante != Vector2.ZERO:
		#Serve para dar velocidade ao personagem, independentemente para que lado ele esteja andando
		velocity = resultante * rapidez
	else:
		#Caso nenhuma tecla esteja sendo pressionada, o personagem se mantém parado
		velocity = Vector2.ZERO

# HIT/BATER
	if Input.is_action_pressed('ui_space'):
		#Entede qual a animação estava sendo executada, para então conseguir executar a animação de correr para o lado correto
		if animacaoJogador.current_animation == "correndo_para_baixo":
			animacaoJogador.play("bater_baixo")
		if animacaoJogador.current_animation == "correndo_para_cima":
			animacaoJogador.play("bater_cima")
		if animacaoJogador.current_animation == "correndo_para_direita":
			animacaoJogador.play("bater_direita")
		if animacaoJogador.current_animation == "correndo_para_esquerda":
			animacaoJogador.play("bater_esquerda")
		if animacaoJogador.current_animation == "":
			animacaoJogador.play("")
		else: return
	#Move o personagem com a velocity (atrelando resultante com a rapidez)
	move_and_slide(velocity)
func _ready():
	pass


func _CimaJoystick():
	somePressed = true
	buttonPressed = 'Cima'
	
func _baixoJoystick():
	somePressed = true
	buttonPressed = 'Baixo'
	
func _esquerdaJoystick():
	somePressed = true
	buttonPressed = 'Esquerda'

func _direitaJoystick():
	somePressed = true
	buttonPressed = 'Direita'

func _joystickExited():
	somePressed = false
	buttonPressed = 'Idle'
