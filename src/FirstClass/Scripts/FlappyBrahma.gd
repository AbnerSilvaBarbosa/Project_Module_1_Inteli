extends Node # instancia a classe Node2D

var status = 1 # 1 jogando, 0 parado
var vscore = 0 # pontuação obtida
var speed = 2 # velocidade, aumente esse valor para deixar o jogo mais difícil
var gravity = 3.5 # gravidade, aumente esse valor para deixar o jogo mais difícil

# executa essa função ao carregar o jogo
func _ready():
	# oculta o "gameover"
	$perdeu.hide()


# executa essa função a cada frame (60 FPS)
func _process(delta):
	
	if(vscore == 10):
		print('Venceu')
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundo
		get_tree().change_scene("res://D&IMental.tscn")
	if status == 1: # jogando
		
		# movimenta o cenário do fundo
		$Fundo.position.x -= 2*speed
		if ($Fundo.position.x) < -200:
			$Fundo.position.x = 600
			
		# movimenta as colunas para colisão
		$Barrius.position.x -= 3*speed
		if ($Barrius.position.x) < -550:
			$Barrius.position.x = rand_range(0, 350) - 50
			$Barrius.position.y = rand_range(0, 400) - 200
		
		# puxa o dragão para baixo
		$BrahmaVoadora.position.y += gravity

		# se bateu no fundo, não desce mais e termina o jogo
		if $BrahmaVoadora.position.y > 480:
			$BrahmaVoadora.position.y = 480
			status = 0 # muda o status para "parado"

		# se bateu no teto, não sobe mais
		if $BrahmaVoadora.position.y < -20:
			$BrahmaVoadora.position.y = -20
		
		
			
		# se apertou seta para baixo, aumenta o valor de y (posição vertical) do dragão
		if Input.is_action_pressed("ui_down"):
			$BrahmaVoadora.position.y += 6

		# se apertou seta para cima, diminui o valor de y (posição vertical) do dragão
		if Input.is_action_pressed("ui_up"):
			$BrahmaVoadora.position.y -= 10
			
	elif status == 0: #Bhrama está parada
		
		$BrahmaVoadora/bhramaImagens.playing = false # faz dragão parar de bater as asas
		$perdeu.show() # exibe imagem gameover

		# se apertou enter ou space, recomeça o jogo
		if Input.is_action_pressed("ui_accept"):
			$score.set_text("0") # zera o score
			vscore = 0 # zera o score
			status = 1 # muda o status para "jogando"
			$BrahmaVoadora/bhramaImagens.playing = true # faz dragão voltar a bater as asas
			$BrahmaVoadora.position.y = 0 # volta o dragão para a posição original
			$Barrius.position.x = 400 # muda a posição das colunas
			$perdeu.hide() # oculta o gameover
			
#Assim que o personagem passa pelo Barril
func _passouBarril(body):
	if (body.name == 'BrahmaVoadora'):
		vscore += 1 # aumenta o score
		$score.set_text(str(vscore)) # atualiza o painel

#Assim que o personagem colide com um dos barrius
func _bateuBarril(body):
	if (body.name == "BrahmaVoadora"):
		status = 0 # muda o status para "parado"
		

##Retornar para a cena principal quando o ESC e apertado
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().change_scene("res://D&IMental.tscn")
