extends Node2D

var FILE_NAME = "user://infos.json"
var isVisible = true
var anc = 0
var levelPassed = false
var liberadoAbrir = false
var liberadoAbrirE = false
var liberadoAbrirG = false
var qntVidas = 0
var pontosToBuy
var destination
var destination2

var player = {
	'xp': 0,
	'vidas': 0
}

func setPoints(points): #Colca os pontos na HUD do jogo.
	$Personagem/Camera/Pontos.text = str(points) 

func save(): #Salva novas informações no arquivo .JSON
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(player))
	file.close()

func loadInfos(): #Carrega as informações que o arquivo .JSON possui
	var file = File.new()
	if file.file_exists(FILE_NAME):
		file.open(FILE_NAME, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		if typeof(data) == TYPE_DICTIONARY:
			player = data
		else:
			printerr("Corrupted data!")
	else:
		printerr("No saved data!")

func checkVidas():
	if (qntVidas == 1): #Se tiver somente uma vida
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = false
		$Personagem/Camera/Vidas/Vida3.visible = false
		$Personagem/Camera/Vidas/Vida4.visible = false
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 2): #Se tiver duas vidas
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = true
		$Personagem/Camera/Vidas/Vida3.visible = false
		$Personagem/Camera/Vidas/Vida4.visible = false
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 3): #Se tiver três vidas
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = true
		$Personagem/Camera/Vidas/Vida3.visible = true
		$Personagem/Camera/Vidas/Vida4.visible = false
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 4): #Se tiver quatro vidas
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = true
		$Personagem/Camera/Vidas/Vida3.visible = true
		$Personagem/Camera/Vidas/Vida4.visible = true
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 5): #Se tiver cinco vidas
		$Personagem/Camera/Vidas/Vida1.visible = true
		$Personagem/Camera/Vidas/Vida2.visible = true
		$Personagem/Camera/Vidas/Vida3.visible = true
		$Personagem/Camera/Vidas/Vida4.visible = true
		$Personagem/Camera/Vidas/Vida5.visible = true
		$Personagem/Camera/Vidas/VidaVazia.visible = false
	elif (qntVidas == 0): #Se não tiver nenhuma vida
		$Personagem/Camera/Vidas/Vida1.visible = false
		$Personagem/Camera/Vidas/Vida2.visible = false
		$Personagem/Camera/Vidas/Vida3.visible = false
		$Personagem/Camera/Vidas/Vida4.visible = false
		$Personagem/Camera/Vidas/Vida5.visible = false
		$Personagem/Camera/Vidas/VidaVazia.visible = true

func beVisible(visible): 
	$Personagem/Camera/CanvasLayer/Popups/Popup.visible = visible  #Abre o PopUp do quiz
	
func beVisibleMarket(visible):
	$Personagem/Camera/CanvasLayer/Popups/Mercado.visible = visible
	
func MensagemPressM(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup3.visible = visible # Aparece para apertar M.

func MensagemPressE(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup4.visible = visible # Aparece para apertar M.

func MensagemPressG(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup5.visible = visible # Aparece para apertar M.

func messageFinal(text):
	$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = true
																	 #Abre o PopUp de resposta com "Acertou" ou "Errou"
	$Personagem/Camera/CanvasLayer/Popups/Popup2/Label.text = text
	
func setPopUpContent(question, an1, an2, an3):
	$Personagem/Camera/CanvasLayer/Popups/Popup/Label.text = question
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button2/Label.text = an1
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button3/Label.text = an2    #Passa o conteudo do Quiz para a tela do jogo
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button4/Label.text = an3
	
func addCoins(qnt):
	var pontosAtual = int($Personagem/Camera/Pontos.text) #Pega os pontos atuais e tranforma em Número
	var pontosAdicionados = pontosAtual ++ qnt #Adiciona o incremento passado pelo parametro da função
	var pontosInString = str(pontosAdicionados) #Retorna a soma para o formato String
	$Personagem/Camera/Pontos.text = pontosInString #Substitui o valor dos pontos pelo valor adicionado
	
func deleteCoins(qnt):
	var pontosAtualRed = int($Personagem/Camera/Pontos.text) #Pega os pontos atuais e tranforma em Número
	var pontosAdicionadosRed = pontosAtualRed - qnt #Retira o incremento passado pelo parametro da função
	var pontosInStringRed = str(pontosAdicionadosRed) #Retorna o total para o formato String
	$Personagem/Camera/Pontos.text = pontosInStringRed #Substitui o valor dos pontos pelo valor retirado

func getPoints():
	return int($Personagem/Camera/Pontos.text)

func messageMarket(message):
	$Personagem/Camera/CanvasLayer/Popups/marketMessage/Label.text = message
	$Personagem/Camera/CanvasLayer/Popups/marketMessage.visible = true
	yield(get_tree().create_timer(3.0), "timeout")                           #Abre CONFIRMAÇÃO ou ERRO do MERCADO
	$Personagem/Camera/CanvasLayer/Popups/marketMessage.visible = false
#
func _ready():
	destination = get_node("Portaldestination").get_global_position()
#	destination2 = get_node("Portaldestination2").get_global_position()
	loadInfos() #Carrega as infos
	qntVidas = player.vidas #Atualiza a qntDeVidas quando o jogo inicia
	setPoints(player.xp) #Atualiza os pontos quando o jogo inicia
	print(player)
	pass

func _process(delta):
	checkVidas() #Chama a função que verifica quantas sprites irão aparecer
	pontosToBuy = float($Personagem/Camera/Pontos.text) #Verifica os pontos recorrentemente para que sejam usados no --MERCADO--
	if liberadoAbrir: #Verifica se o pesonagem está dentro da AREA de Pergunta
		if Input.is_action_pressed('ui_m'):
			beVisible(true)
			get_tree().paused = true
	#		if (levelPassed == true):
	#			$Collisions/mecanicaTeste.disabled = true
	#		else:                                           #Sistema para bloquear as fases
	#			$Collisions/mecanicaTeste.disabled = false
	elif liberadoAbrirE: #Verifica se o pesonagem está dentro da AREA de Minigame
		if Input.is_action_pressed("ui_e"):
			get_tree().change_scene("res://pong.tscn")
	elif liberadoAbrirG:
		if Input.is_action_pressed("ui_g"): #Verifica se o pesonagem está dentro da AREA de Mercado
			beVisibleMarket(true) 
			get_tree().paused = true
			MensagemPressG(false)
	else:
		pass

func _on_Button_pressed_close(): #Botão para fechar as perguntas
	beVisible(false) #Torna tudo referente as perguntas invisível
	get_tree().paused = false #Pausa o jogo
	
func _on_Button2_pressed(): #Quando a alternativa A é selecionada
	if (anc == 1):
		beVisible(false)
		get_tree().paused = false
		messageFinal('Acertou')
		addCoins(100)
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		player.xp = getPoints()
		save()
	else:
		beVisible(false)
		get_tree().paused = false
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false

func _on_Button3_pressed(): #Quado a alternativa B é selecionada
	if (anc == 2):
		beVisible(false)
		get_tree().paused = false
		messageFinal('Acertou')
		addCoins(100)
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		player.xp = getPoints()
		save()
	else:
		beVisible(false)
		get_tree().paused = false
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false

func _on_Button4_pressed(): #Quando a alternativa C é selecionada
	if (anc == 3):
		beVisible(false)
		get_tree().paused = false
		messageFinal('Acertou')
		addCoins(100)
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		player.xp = getPoints()
		save()
	else:
		beVisible(false)
		get_tree().paused = false
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false# Replace with function body.
	

## Fechar o jogo quando o ESC e apertado
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()

func _on_Area2D_body_entered(body): #Quando o personagem entra na AREA
	if body.name == "Personagem": # Aparece somente com a colisao DO PERSONAGEM
		liberadoAbrir = true
		MensagemPressM(true)
		setPopUpContent('Quando entro na area selecionada', 'Teste2324234234', 'Teste432423423', 'Louco4324234234')
		anc = 2
#		if Input.is_action_pressed("ui_m"):
#			beVisible(true)
#			get_tree().paused = true
	else:
		get_tree().paused = false # Replace with function body


func _on_Area2D_body_exited(body): #Quando o personagem entra na AREA
	if body.name == "Personagem": # Aparece somente com a colisao DO PERSONAGEM
		liberadoAbrir = false
		MensagemPressM(false)
	pass # Replace with function body.

func _on_Area2D2_body_entered(body): #Quando o personagem entra na AREA
	if body.name == 'Personagem':
		#get_tree().change_scene("res://pong.tscn")
		liberadoAbrirE = true
		MensagemPressE(true)
	pass # Replace with function body.

func _on_Area2D2_body_exited(body): #Quando o personagem entra na AREA
	if body.name == 'Personagem':
		liberadoAbrirE = false
		MensagemPressE(false)
	pass # Replace with function body.


func _pergunta2Enter(body): #Quando o personagem entra na AREA
	if body.name == 'Personagem':
		liberadoAbrir = true
		MensagemPressM(true)
		setPopUpContent('Essa é a pergunta 2', 'Resposta 1', 'Resposta2', 'Resposta3')
		anc = 3
	else:
		get_tree().paused = false
	pass # Replace with function body.


func _exitedPergunta2(body): #Quando o personagem entra na AREA
	if body.name == 'Personagem':
		liberadoAbrir = false
		MensagemPressM(false)
	pass # Replace with function body.


func _on_Pergunta3_body_entered(body): #Quando o personagem entra na AREA
	if body.name == 'Personagem':
		liberadoAbrir = true
		MensagemPressM(true)
		setPopUpContent('Quem descobriu o Brasil', 'Pedro Alvares Cabral', 'Frei Henrique de Coimbra', 'Pero vaz de Caminha')
		anc = 1
	pass # Replace with function body.


func _on_Pergunta3_body_exited(body): #Quando o personagem entra na AREA
	if body.name == 'Personagem':
		liberadoAbrir = false
		MensagemPressM(false)
	pass # Replace with function body.


func marketOpenMessage(body): #Quando o personagem entra na AREA
	if body.name == 'Personagem':
		liberadoAbrirG = true
		MensagemPressG(true)
	pass # Replace with function body.


func marketExited(body): #Quando o personagem entra na AREA
	if body.name == 'Personagem':
		liberadoAbrirG = false
		MensagemPressG(false)
	pass # Replace with function body.


func fecharMarket(): #Torna tudo do MERCADO invisivel para que esse seja "FECHADO"
	beVisibleMarket(false)
	get_tree().paused = false
	pass # Replace with function body.

func compraVida(): #Quando a opção de vida é selecionada
	if(pontosToBuy >= 1000):
		if (qntVidas < 5):
			deleteCoins(1000)
			beVisibleMarket(false)
			get_tree().paused = false
			messageMarket('Item comprado com sucesso')
			qntVidas += 1
			player.xp = getPoints()
			player.vidas = qntVidas
			save()
		else:
			beVisibleMarket(false)
			get_tree().paused = false
			messageMarket('Você já possui o máximo vidas')
	else:
		beVisibleMarket(false)
		get_tree().paused = false
		messageMarket('Você não possui dinheiro suficiente')
	pass # Replace with function body.


func comprarFase2(): #Quando a opção de FASE1 é selecionada
	if(pontosToBuy >= 2000):
		deleteCoins(2000)
		beVisibleMarket(false)
		get_tree().paused = false
		messageMarket('Item comprado com sucesso')
		player.xp = getPoints()
		save()
	else:
		beVisibleMarket(false)
		get_tree().paused = false
		messageMarket('Você não possui dinheiro suficiente')
	pass # Replace with function body.


func comprarFase3(): #Quando a opção de FASE2 é selecionada
	print(pontosToBuy)
	if (pontosToBuy >= 3000):
		deleteCoins(3000)
		beVisibleMarket(false)
		get_tree().paused = false
		messageMarket('Item comprado com sucesso')
		player.xp = getPoints()
		save()
	else:
		beVisibleMarket(false)
		get_tree().paused = false
		messageMarket('Você não possui dinheiro suficiente')
	pass # Replace with function body.


func _on_Area2D3_body_entered(body): #Quando o personagem entra na PORTAL
	if body.name == "Personagem":
		get_tree().change_scene("res://D&IMental.tscn")


	pass # Replace with function body.


func _on_Area2D4_body_entered(body): #Quando o personagem entra no PORTAL
	body.set_position(destination2)
	pass # Replace with function body.
