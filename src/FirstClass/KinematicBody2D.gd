extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO
onready var animacaoJogador = $AnimationPlayer

func _physics_process(delta):
	if Input.is_action_pressed('ui_right'):
		velocity.x = 2
		animacaoJogador.play("correndo para direita")
		if Input.is_action_pressed('ui_e'):
			animacaoJogador.play("bater")
	elif Input.is_action_pressed('ui_left'):
		velocity.x = -2
		animacaoJogador.play("correndo_para_esquerda")
		if Input.is_action_pressed('ui_e'):
			animacaoJogador.play("bater_esquerda")
	else:
		velocity.x = 0
		
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
			
			
	if Input.is_action_pressed('ui_down'):
		velocity.y = 2
		animacaoJogador.play("correndo_para_baixo")
		if Input.is_action_pressed('ui_e'):
			animacaoJogador.play("bater_baixo")
	elif Input.is_action_pressed('ui_up'):
		velocity.y = -2
		animacaoJogador.play("correndo_para_cima")
		if Input.is_action_pressed('ui_e'):
			animacaoJogador.play("bater_cima")
	else:
		velocity.y = 0
		
	move_and_collide(velocity)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
