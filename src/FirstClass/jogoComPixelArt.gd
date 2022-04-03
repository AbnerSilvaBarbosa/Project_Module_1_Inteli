extends Node2D

var FILE_NAME = "user://infos.json" #--Arquivo Local
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
var cutsi = false

var player = { #Local database
	'xp': 0,
	'vidas': 0,
	'mercadoAlreadyOpen': false,
	'alreadyPlayed': false,
	'isMobile': false
} 

#Coloca os pontos na HUD do jogo
func setPoints(points):
	$Personagem/Camera/Pontos.text = str(points) 

#Salva novas informações no arquivo .JSON
func save():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE) #Acessa o arquivo local para escrita
	file.store_string(to_json(player)) #Guarda a var Player em formato JSON dentro do arquivo local
	file.close()

#Carrega as informações que o arquivo .JSON possui.
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

#Verifica quantas vidas o player possui no DB, assim faz com que essas aparecem de forma correta na HUD
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

#Abre o PopUp do quiz
func beVisible(visible): 
	$Personagem/Camera/CanvasLayer/Popups/Popup.visible = visible
	
#Abre o PopUp do mercado
func beVisibleMarket(visible):
	$Personagem/Camera/CanvasLayer/Popups/Mercado.visible = visible
	
# Aparece para apertar M.
func MensagemPressM(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup3.visible = visible

# Aparece para apertar E.
func MensagemPressE(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup4.visible = visible

# Aparece para apertar G.
func MensagemPressG(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup5.visible = visible

#Abre o PopUp de resposta com "Acertou" ou "Errou"
func messageFinal(text):
	$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = true
	$Personagem/Camera/CanvasLayer/Popups/Popup2/Label.text = text
	
#Passa o conteúdo do Quiz para a tela do jogo.
func setPopUpContent(question, an1, an2, an3):
	$Personagem/Camera/CanvasLayer/Popups/Popup/Label.text = question
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button2/Label.text = an1
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button3/Label.text = an2
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button4/Label.text = an3

#Adiciona uma quantidade selecionada de pontos ao player
func addCoins(qnt):
	var pontosAtual = int($Personagem/Camera/Pontos.text) #Pega os pontos atuais e tranforma em Número
	var pontosAdicionados = pontosAtual ++ qnt #Adiciona o incremento passado pelo parametro da função
	var pontosInString = str(pontosAdicionados) #Retorna a soma para o formato String
	$Personagem/Camera/Pontos.text = pontosInString #Substitui o valor dos pontos pelo valor adicionado

#Remove uma quantidade selecionada de pontos do player
func deleteCoins(qnt):
	var pontosAtualRed = int($Personagem/Camera/Pontos.text) #Pega os pontos atuais e tranforma em Número
	var pontosAdicionadosRed = pontosAtualRed - qnt #Retira o incremento passado pelo parametro da função
	var pontosInStringRed = str(pontosAdicionadosRed) #Retorna o total para o formato String
	$Personagem/Camera/Pontos.text = pontosInStringRed #Substitui o valor dos pontos pelo valor retirado

#Verifica quantos pontos o player possui
func getPoints():
	return int($Personagem/Camera/Pontos.text) #Retorna em forma de número quantos pontos o player possui

#Abre CONFIRMAÇÃO ou ERRO do MERCADO
func messageMarket(message):
	$Personagem/Camera/CanvasLayer/Popups/marketMessage/Label.text = message
	$Personagem/Camera/CanvasLayer/Popups/marketMessage.visible = true
	yield(get_tree().create_timer(3.0), "timeout")
	$Personagem/Camera/CanvasLayer/Popups/marketMessage.visible = false

#Chamada assim que o jogo inicia
func _ready():
	if (Global.cutscene == true):
		$Barco/AnimationPlayer.play("Nova Animação")
		$Personagem.visible = false
		Global.cutscene = false
	else:
		$Personagem/Camera.current = true
	destination = get_node("Portaldestination").get_global_position()
	destination2 = get_node("Portaldestination2").get_global_position()
	loadInfos() #Carrega as informações
	qntVidas = player.vidas #Atualiza a qntDeVidas quando o jogo inicia
	setPoints(player.xp) #Atualiza os pontos quando o jogo inicia
	print(player)
	if(player.alreadyPlayed == false):
		var dialogWelcome = Dialogic.start("Welcome")
		add_child(dialogWelcome)
	save()
	
	$Personagem.set_position(Global.position)
	pass

#Roda em looping o que está dentro dela
func _process(delta):
	checkVidas() #Chama a função que verifica quantas sprites irão aparecer
	
	if (player.isMobile == false):
		$Personagem/Camera/Cima.visible = false
		$Personagem/Camera/Baixo.visible = false
		$Personagem/Camera/Esquerda.visible = false
		$Personagem/Camera/Direita.visible = false

	pontosToBuy = float($Personagem/Camera/Pontos.text) #Verifica os pontos recorrentemente para que sejam usados no --MERCADO--
	if liberadoAbrir: #Verifica se o pesonagem está dentro da AREA de Pergunta
		if Input.is_action_pressed('ui_m'):
			beVisible(true) #Torna vísivel o quiz
			get_tree().paused = true
	##		if (levelPassed == true):
	##			$Collisions/mecanicaTeste.disabled = true
	##		else:                                           #Sistema para bloquear as fases
	##			$Collisions/mecanicaTeste.disabled = false
	elif liberadoAbrirE: #Verifica se o pesonagem está dentro da AREA de Minigame
		if Input.is_action_pressed("ui_e"):
			get_tree().change_scene("res://pong.tscn") #Envia para o Minigame
	elif liberadoAbrirG:
		if Input.is_action_pressed("ui_g"): #Verifica se o pesonagem está dentro da AREA de Mercado
			beVisibleMarket(true) #Torna o mercado vísivel
			get_tree().paused = true
			MensagemPressG(false) #Fecha a mensagem 'Pressione G'
			player.mercadoAlreadyOpen = true
			save()
	else:
		pass

#Botão para fechar as perguntas
func _on_Button_pressed_close():
	beVisible(false) #Torna tudo referente as perguntas invisível
	get_tree().paused = false #Pausa o jogo
	
	#Quando a alternativa A é selecionada
func _on_Button2_pressed():
	if (anc == 1): #Resposta correta
		beVisible(false) #Torna o Quiz invisivel
		get_tree().paused = false
		messageFinal('Acertou') #Define a mensagem de acerto ou erro
		addCoins(100) #Adiciona pontos
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundo
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		player.xp = getPoints() #Captura a quantidade atual de pontos
		save() #Salva no arquivo local
	else: #Resposta errada
		beVisible(false) #Torna o quiz invisivel
		get_tree().paused = false 
		messageFinal('Errou') #Define o conteudo da mensagem final
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false #Some a mensagem final

#Quado a alternativa B é selecionada
func _on_Button3_pressed():
	if (anc == 2): #Resposta está correta
		beVisible(false) #Torna o quiz invisivel
		get_tree().paused = false #Despausa o jogo
		messageFinal('Acertou') #Define a mensagem que o player receberá
		addCoins(100) #Adiciona os pontos
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		player.xp = getPoints() #Captura a quantidade atual de pontos
		save() #Salva no arquivo local
	else: #Resposta errada
		beVisible(false) #Torna o quiz invisivel
		get_tree().paused = false #Despausa o jogo
		messageFinal('Errou') #Define a mensagem que o player receberá
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false

#Quado a alternativa C é selecionada
func _on_Button4_pressed():
	if (anc == 3): #Resposta está correta
		beVisible(false) #Torna o quiz invisivel
		get_tree().paused = false
		messageFinal('Acertou') #Define a mensagem final
		addCoins(100) #Adiciona pontos
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false #Some a mensagem final
		player.xp = getPoints() #Captura a quantidade atual de pontos
		save() #Salva no arquivo local
	else: #Resposta errada
		beVisible(false) #Torna o quiz invisivel
		get_tree().paused = false
		messageFinal('Errou') #Define a mensagem final
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false #Some a mensagem final
	

## Fechar o jogo quando o ESC e apertado
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()

#Quando um corpo entra na área 2D definida:
func _on_Area2D_body_entered(body):
	if body.name == "Personagem": # Aparece somente com a colisao DO PERSONAGEM
		liberadoAbrir = true #Libera a tecla M para funcionar
		MensagemPressM(true) #Torna o aviso de "Pressione M" visivel
		setPopUpContent('Quando entro na area selecionada', 'Teste2324234234', 'Teste432423423', 'Louco4324234234') #Define o conteudo da pergunta
		anc = 2
	else:
		get_tree().paused = false #Despausa o jogo

# Quando um corpo sai da área 2D definida:
func _on_Area2D_body_exited(body): 
	if body.name == "Personagem": 
		liberadoAbrir = false #Bloqueia a tecla M para funcionar
		MensagemPressM(false) #Torna o aviso de "Pressione M" invisivel
	pass

#Quando entra na área da pergunta
func _on_Area2D2_body_entered(body): 
	if body.name == 'Personagem': # Aparece somente com a colisao DO PERSONAGEM
		liberadoAbrirE = true #Libera a tecla E (NPC - História) para funcionar
		MensagemPressE(true) #Torna o aviso de "Pressione E" visivel
	pass

#Quando sai da área da pergunta
func _on_Area2D2_body_exited(body):
	if body.name == 'Personagem': 
		liberadoAbrirE = false #Bloqueia a tecla E (NPC - História) para funcionar
		MensagemPressE(false) #Torna o aviso de "Pressione E" invisivel
	pass

#Quando entra na área da pergunta
func _pergunta2Enter(body): 
	if body.name == 'Personagem': # Aparece somente com a colisao DO PERSONAGEM
		liberadoAbrir = true #Libera a tecla M (NPC - Pergunta) para funcionar
		MensagemPressM(true) #Torna o aviso de "Pressione M" visivel
		setPopUpContent('Essa é a pergunta 2', 'Resposta 1', 'Resposta2', 'Resposta3') 
		anc = 3
	else:
		get_tree().paused = false
	pass 

#Quando sai da área da pergunta
func _exitedPergunta2(body):
	if body.name == 'Personagem': 
		liberadoAbrir = false #Bloqueia a tecla M para funcionar
		MensagemPressM(false) #Torna o aviso de "Pressione M" invisivel
	pass 

# Quando o personagem entra na area de pergunta
func _on_Pergunta3_body_entered(body): 
	if body.name == 'Personagem': # Aparece somente com a colisao DO PERSONAGEM
		liberadoAbrir = true #Libera a tecla M para funcionar 
		MensagemPressM(true) #Torna o aviso de "Pressione M" visivel
		setPopUpContent('Quem descobriu o Brasil', 'Pedro Alvares Cabral', 'Frei Henrique de Coimbra', 'Pero vaz de Caminha') #Define o assunto do quiz
		anc = 1 #Define a resposta correta
	pass 

#Quando o personagem sai da área de pergunta
func _on_Pergunta3_body_exited(body): 
	if body.name == 'Personagem': 
		liberadoAbrir = false #Bloqueia a tecla M para funcionar
		MensagemPressM(false) #Torna o aviso de "Pressione M" invisivel
	pass 

#Quando o personagem entra na area do mercado
func marketOpenMessage(body):
	if body.name == 'Personagem': # Aparece somente com a colisao DO PERSONAGEM
		if (player.mercadoAlreadyOpen == true): #Usuário já jogou ou não
			print('Já abriu')
			liberadoAbrirG = true #Libera a tecla G para funcionar 
			MensagemPressG(true) #Torna o aviso de "Pressione G" visivel
		else:
			print('Nunca Abriu')
			var dialog = Dialogic.start("Mercado")
			add_child(dialog)
			dialog.connect('timeline_end', self, "unpause")
			liberadoAbrirG = true #Libera a tecla G para funcionar 
			MensagemPressG(true) #Torna o aviso de "Pressione G" visivel
	pass 

#Quando o dialogo finiliza
func unpause(timeline_Teste):
	get_tree().paused = false
	player.mercadoAlreadyOpen = true
	save()
#Quando o personagem sai da área do Mercado
func marketExited(body):
	if body.name == 'Personagem': 
		liberadoAbrirG = false #Bloqueia a tecla G para funcionar
		MensagemPressG(false) #Torna o aviso de "Pressione G" invisivel
	pass

#Fecha o mercado(torna tudo invisivel para que ele seja "Fechado")
func fecharMarket():
	beVisibleMarket(false)
	get_tree().paused = false #Sai do estado de pausa
	pass

#Quando uma vida é comprada dentro do mercado
func compraVida():
	if(pontosToBuy >= 1000): #Se os pontos forem maiores ou iguais a 1000
		if (qntVidas < 5): #Se a quantidade de vidas for menor que 5
			deleteCoins(1000) # Retira 1000 pontos do jogador
			beVisibleMarket(false) # Mercado fica invisivel
			get_tree().paused = false #Sai do estado de pausa
			messageMarket('Item comprado com sucesso') #Mostra a mensagem escrita "Item comprado com sucesso"
			qntVidas += 1 #Adiciona mais uma quantidade na vida 
			player.xp = getPoints() #Pega os pontos de Xp atuais do jogador
			player.vidas = qntVidas #Pega a quantidade de vidas atuais do jogador
			save() #Salvas as informações 
		else: #Se a quantidade de vidas for maior que 5
			beVisibleMarket(false) #Mercado fica invisivel
			get_tree().paused = false #Sai do estado de pausa
			messageMarket('Você já possui o máximo vidas') #Mostra a mensagem "Você já possui o máximo de vidas"
	else: #Se os pontos forem menores que 1000
		beVisibleMarket(false) #Mercado fica invisivel
		get_tree().paused = false #Sai do estado de pausa
		messageMarket('Você não possui dinheiro suficiente') #Mostra a mensagem "Você não possui dinheiro surficiente"
	pass 

#Quando a opção de comprar a Fase 2 é selecionada
func comprarFase2():
	if(pontosToBuy >= 2000): #Verifica se os pontos são suficientes
		deleteCoins(2000) #Retira a quantidade de pontos do player
		beVisibleMarket(false) #Torna o mercado invisivel
		get_tree().paused = false
		messageMarket('Item comprado com sucesso') #Define a mensagem final do mercado
		player.xp = getPoints() #Captura os pontos atuais do player
		save() #Salva as informações em arquivo local
	else: #Pontos não suficientes
		beVisibleMarket(false) #Torna o mercado invisivel
		get_tree().paused = false
		messageMarket('Você não possui experiência suficiente') #Usuário não tem experiência necessária
	pass 


#Quando a FASE3 é comprada no mercado
func comprarFase3():
	if (pontosToBuy >= 3000): #Se os pontos forem maiores ou iguais a 3000
		deleteCoins(3000) #Retira 3000 dos pontos atuais 
		beVisibleMarket(false) #Mercado fica invisivel
		get_tree().paused = false #Sai do estado de pausa
		messageMarket('Item comprado com sucesso') #Mostra a mensagem "Item comprado com sucesso"
		player.xp = getPoints() #Pega a quantidade de pontos atuais do player
		save() #Salva as informações
	else: #Se os pontos forem menores que 3000
		beVisibleMarket(false) #Mercado fica invisivel
		get_tree().paused = false #Sai do estado de pausa
		messageMarket('Você não possui dinheiro suficiente') #Mostra a seguinte mensagem "Você não possui dinheiro suficiente"
	pass 

#Quando o personagem entra no portal
func _on_Area2D3_body_entered(body):
	if body.name == "Personagem":
		get_tree().change_scene('res://D&IMental.tscn')
		Global.position = Vector2(1179, -1874)
	pass 

#Quando o personagem entra no outro portal
func _on_Area2D4_body_entered(body):
	body.set_position(destination2)
	pass



#Quando a animação do barco inicial finaliza.
func _on_AnimationPlayer_animation_finished(anim_name):
	$Personagem/Camera.current = true
	$Personagem.visible = true
	
	pass


#Checkpoint de que o personagem já jogou o jogo.
func _verifyPlayed(body):
	player.alreadyPlayed = true
	save()
	pass


func _onNPCEntered(body):
	var dialogNPCHistoria = Dialogic.start("EronHistoria")
	add_child(dialogNPCHistoria)
