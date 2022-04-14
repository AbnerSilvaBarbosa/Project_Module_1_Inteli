extends Node # instancia a classe Node2D

var status = 1 # 1 jogando, 0 parado
var vscore = 0 # pontuação obtida
var speed = 2 # velocidade, aumente esse valor para deixar o jogo mais difícil
var gravity = 3.5 # gravidade, aumente esse valor para deixar o jogo mais difícil
var FILE_NAME = 'user://infos.json'

var player = {
	'isMobile': false
}

func loadInfoMobile():
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

# executa essa função ao carregar o jogo
func _ready():
	loadInfoMobile()
	# oculta o "gameover"
	$perdeu.hide()


func bhramaUp():
	$BrahmaVoadora.position.y -= 70
	
func bhramaDown():
	$BrahmaVoadora.position.y += 56
	
func restartGame():
	$score.set_text("0") # zera o score
	vscore = 0 #Coloca os pontos em zero
	status = 1 #Informa que está jogando
	$BrahmaVoadora/bhramaImagens.playing = true #Inicia a animação da Brhama
	$BrahmaVoadora.position.y = 0 #Retorna a posição
	$Barrius.position.x = 400 #Altera o local do Barril
	$perdeu.hide() #Torna invísivel a imagem de perdeu
	$restartTouch.visible = false
	$bhramaBaixo.visible = true
	$bhramaCima.visible = true
	
func _process(delta):
	
	if (player.isMobile == true):
		$bhramaBaixo.visible = true
		$bhramaCima.visible = true
		$fecharTouch.visible = true
	
	if(vscore == 6):
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
		$perdeu.show() #Mostra a imagem de perdeu
		$restartTouch.visible = true
		$bhramaBaixo.visible = false
		$bhramaCima.visible = false

		if Input.is_action_pressed("ui_accept"):
			restartGame()
			
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


func _bhramaCimaPressed():
	bhramaUp()


func _bhramaBaixoPressed():
	bhramaDown()


func _restartGamePressed():
	restartGame()


func _fecharTouch():
	get_tree().change_scene("res://D&IMental.tscn")
