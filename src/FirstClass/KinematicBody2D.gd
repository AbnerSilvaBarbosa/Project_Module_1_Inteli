extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
var rapidez = 140
onready var animacaoJogador = $AnimationPlayer

func direita():
	velocity.x = 2
	animacaoJogador.play("correndo_para_direita")
	
func esquerda():
	velocity.x = -2
	animacaoJogador.play("correndo_para_esquerda")

func baixo():
	velocity.y = 2
	animacaoJogador.play("correndo_para_baixo")

func cima():
	velocity.y = -2
	animacaoJogador.play("correndo_para_cima")

func _physics_process(_delta):
	
	var resultante = Vector2.ZERO
	resultante.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	resultante.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	resultante = resultante.normalized()
	
	if Input.get_action_strength("ui_right"):
		animacaoJogador.play("correndo_para_direita")
	elif Input.get_action_strength("ui_left"):
		animacaoJogador.play("correndo_para_esquerda")
	elif Input.get_action_strength("ui_up"):
		animacaoJogador.play("correndo_para_cima")
	elif Input.get_action_strength("ui_down"):
		animacaoJogador.play("correndo_para_baixo")
	else:
		return
	
	if resultante != Vector2.ZERO:
		velocity = resultante * rapidez
	else:
		velocity = Vector2.ZERO
	
	
	print(resultante)
#	if Input.is_action_pressed('ui_right'):
#		direita()
#
#	elif Input.is_action_pressed('ui_left'):
#		esquerda()
#
#	else:
#		velocity.x = 0
#
#	if Input.is_action_pressed('ui_down'):
#		baixo()
#
#	elif Input.is_action_pressed('ui_up'):
#		cima()
#
#	else:
#		velocity.y = 0
#
#	if Input. is_action_pressed('ui_shift'):
#		if Input.is_action_pressed('ui_right'):
#			velocity.x = 5
#			animacaoJogador.play("correndo para direita")
#			if Input.is_action_pressed('ui_e'):
#				animacaoJogador.play("bater")
#		elif Input.is_action_pressed('ui_left'):
#			velocity.x = -5
#			animacaoJogador.play("correndo_para_esquerda")
#			if Input.is_action_pressed('ui_e'):
#				animacaoJogador.play("bater_esquerda")

# HIT/BATER
	if Input.is_action_pressed('ui_space'):
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
		

# warning-ignore:return_value_discarded
	move_and_slide(velocity)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
