extends Node2D

var qntVidas = 0 
var FILE_NAME = "user://infos.json"
var FILE_PERGUNTAS = "user://PerguntasFase1.JSON"
var randomNumberForDelete = 0
var timeline = ''
var cenaDestination = "res://D&IMental.tscn"
var pergunta1Blocked = false
var pergunta2Blocked = false
var pergunta3Blocked = false
var pergunta4Blocked = false
var pergunta5Blocked = false
var pergunta6Blocked = false
var pergunta7Blocked = false
var pergunta8Blocked = false
var pergunta9Blocked = false
var pergunta10Blocked = false
var toBlock
#Define as perguntas padrões
const Perguntas = [
	{'question': 'Qual o nome dado ao preconceito contra vítimas de transtornos mentais?', 'an1': 'Psicofobia', 'an2': 'Capacitismo', 'an3': 'Mentalismo', 'anc': 1, "tip": "Algumas pessoas possuem transtornos mentais e, normalmente, além de ter que conviver com esse peso, são negligenciadas em diversos contextos. Isso impede que elas vivam uma vida tranquila, visto que precisam aprender a conviver também com o preconceito.", "feedback": "O nome dado ao preconceito contra vítimas de transtornos mentais é psicofobia."},
	{'question': 'Qual a campanha mais famosa de prevenção ao suicídio?', 'an1': 'Setembro Amarelo', 'an2': 'Dia Mundial da Saúde Mental', 'an3': 'Janeiro Branco', 'anc': 1, "tip": "O suicídio é a segunda principal causa de morte entre jovens com idade entre 15 e 29 anos. Esse dado preocupante evidencia a negligência com a qual são tratados aqueles que enfrentam problemas psicológicos.", "feedback": "Embora todas as opções apresentadas sejam iniciativas em prol da saúde mental, aquela que se destaca enquanto campanha de prevenção ao suicídio é o Setembro Amarelo."},
	{'question': 'A psicofobia é enquadrada no código penal como:', 'an1': 'Difamação', 'an2': 'Injúria', 'an3': 'Calúnia', 'anc': 2, "tip": "É chamada de “psicofobia” a discriminação contra um traço ou condição mental que uma pessoa tem ou julga ter. Esse tipo de opressão é considerado crime no Brasil.", "feedback": "O código penal brasileiro reconhece a psicofobia como um crime de injúria. Injúria, por definição, consiste na ação de ofender a honra e a dignidade de alguém. Portanto, fique ligado! Ofender pessoas que lidam com doenças mentais não se trata de liberdade de expressão. É um crime, que deve ser levado a sério."},
	{'question': 'Qual o tamanho da pena para quem comete psicofobia?', 'an1': '2 a 4 anos', 'an2': '8 anos', 'an3': 'Apenas multa', 'anc': 1, "tip": "É chamada de “psicofobia” a discriminação contra um traço ou condição mental que uma pessoa tem ou julga ter. Esse tipo de opressão é considerado crime no Brasil.", "feedback": "A legislação brasileira determina pena de 2 a 4 anos para o indivíduo que comete psicofobia."},
	{'question': 'Em qual hospital ocorreu o "holocausto brasileiro"?', 'an1': 'Hospital Colônia de Barbacena', 'an2': 'Hospital Primavera', 'an3': 'Hospital Albert Einstein', 'anc': 1, "tip": "Um dos mais chocantes episódios de discriminação contra doente mentais ocorridos no Brasil foi o “holocausto brasileiro”. Comparado a um campo de concentração, torturava seus pacientes sob o pretexto de tratar doenças mentais.", "feedback": "O episódio conhecido como “holocausto brasileiro” ocorreu no Hospital Colônia, localizado na cidade de Barbacena."},
	{'question': 'Quais as principais razões pelas quais os doentes mentais sofriam tanto no Hospital de Barbacena?', 'an1': 'Por conta da sua origem', 'an2': 'Por preconceito racial', 'an3': 'Discriminação em relação a sua adversidade mental', 'anc': 3, "tip": "Um dos mais chocantes episódios de discriminação contra doente mentais ocorridos no Brasil foi o “holocausto brasileiro”. Comparado a um campo de concentração, torturava seus pacientes sob o pretexto de tratar doenças mentais.", "feedback": "A principal razão pela qual os doentes mentais sofriam tamanha crueldade no Hospital de Barbacena era a discriminação relacionada a suas adversidades mentais."},
	{'question': 'Quais os dois transtornos mentais mais comuns no Brasil?', 'an1': 'Depressão e ansiedade', 'an2': 'TDAH e transtorno de personalidade', 'an3': 'Bipolaridade e esquizofrenia', 'anc': 1, "tip": "O Brasil, atualmente, se destaca entre os países com maiores índices de transtornos mentais. Conhecer esse cenário é o primeiro passo para lutar contra a prevalência das adversidades psicológicas no país.", "feedback": "Os transtornos mentais mais comuns no Brasil são a depressão e a ansiedade. O Brasil figura no topo entre os países com maiores índices dessas duas condições."},
	{'question': 'O que não fazer quando alguém tem uma crise de ansidade?', 'an1': 'Ajudar a pessoa a controlar a respiração', 'an2': 'Levar a pessoa ao relaxamento, muscular ou outros', 'an3': 'Fazer com que a pessoa mude de assunto', 'anc': 3, "tip": "Crises de ansiedade são eventos recorrentes em pessoas que possuem Transtorno de Ansiedade Generalizada. Consistem em momentos nos quais os sintomas da ansiedade se manifestam de forma abrupta e intensa.", "feedback": "Quando alguém tem uma crise de ansiedade, o recomendável é ajudá-la a controlar sua respiração e buscar levá-la ao relaxamento, muscular ou outros. Fazer com que a pessoa mude de assunto não irá afastar os sintomas da crise, configurando um cenário ainda mais prejudicial para ela."},
	{'question': 'O que não fazer quando alguém apresenta sintomas de depressão?', 'an1': 'Ouvir com atenção o que a pessoa tem a dizer', 'an2': 'Minimizar o problema, dizendo que vai passar logo', 'an3': 'Recomendar que ela procure ajuda profissional', 'anc': 2, "tip": "O número de pessoas que vivem com depressão, segundo a OMS, está aumentando – 18% entre 2005 e 2015. A estimativa é que, atualmente, mais de 300 milhões de pessoas de todas as idades sofram com a doença em todo o mundo. O órgão alertou ainda que a depressão figura como a principal causa de incapacidade laboral no planeta.", "feedback": "Para ajudar uma pessoa que está com depressão, é recomendável indicá-la ajuda profissional e ouvir com atenção o que ela tem a dizer. Minimizar o problema pode atenuar o problema e fazer com que a pessoa se torne ainda mais insegura para falar sobre o assunto."},
	{'question': 'Qual o nome da instituição responsável pelo abrigo e tratamento de pacientes diagnosticados com doenças mentais?', 'an1': 'Hospital Psiquiátrico', 'an2': 'Casa de repouso', 'an3': 'Hospício', 'anc': 1, "tip": "Quando se é diagnosticado com uma doença mental antissocial ou em estágio antissocial, o paciente deve ser internado e tratado em uma instituição apropriada, no qual deve receber auxílio de médicos, enfermeiras, psicólogos e outros profissionais da saúde especializados.", "feedback": "Hospício é uma forma pejorativa que remete aos tempos em que o chamado Holocausto Brasileiro aconteceu no Hospital Colônia. A nomenclatura correta é Hospital Psiquiátrico."},
]

var perguntasFromDB = []

#Salva as perguntas dentro do Perguntas.JSON
func savePerguntas():
	var file = File.new()
	file.open(FILE_PERGUNTAS, File.WRITE)
	file.store_string(to_json(perguntasFromDB))
	file.close()

#Faz o load das perguntas que estão dentro do Perguntas.JSON
func loadPerguntas():
	var file = File.new()
	if file.file_exists(FILE_PERGUNTAS):
		file.open(FILE_PERGUNTAS, File.READ)
		var data = parse_json(file.get_as_text())
		file.close()
		perguntasFromDB = data
		return data
	else:
		printerr("No saved data!")
		savePerguntas()
		get_tree().change_scene("res://D&IMental.tscn")

var anc = 1 #Resposta correta
var liberadoAbrir = false #Libera a abertura do QUIZ
var liberadoAbrirG = false #Libera a abertura do Minigame
var liberadoAbrirCientista = false #Libera a abertura do Cientista

var justOneTime = Perguntas

#Trava o NPC que o usuário interagiu
func blockQuestion():
	print(toBlock)
	if(toBlock == 'Pergunta1'):
		pergunta1Blocked = true
	elif(toBlock == 'Pergunta2'):
		pergunta2Blocked = true
	elif(toBlock == 'Pergunta3'):
		pergunta3Blocked = true
	elif(toBlock == 'Pergunta4'):
		pergunta4Blocked = true
	elif(toBlock == 'Pergunta5'):
		pergunta5Blocked = true
	elif(toBlock == 'Pergunta6'):
		pergunta6Blocked = true
	elif(toBlock == 'Pergunta7'):
		pergunta7Blocked = true
	elif(toBlock == 'Pergunta8'):
		pergunta8Blocked = true
	elif(toBlock == 'Pergunta9'):
		pergunta9Blocked = true
	elif(toBlock == 'Pergunta10'):
		pergunta10Blocked = true

func contador():
	var qntQuestions = loadPerguntas()
	if qntQuestions != null:
		return len(qntQuestions)
	else:
		printerr("arquivos de perguntas não existentes")
		pass
	
#Verifica se já foi completado o banco de questões
func verifyQuestions():
	var quantityQuestions = loadPerguntas()
	
	if quantityQuestions != null:
		if len(quantityQuestions) >= 1:
			return true
		else:
			return false
	else:
		printerr('Sem Arquivo de Perguntas!')
		pass

#Torna o quiz vísivel
func beVisible(visible): 
	$Personagem/Camera/CanvasLayer/Popups/Popup.visible = visible

#Torna o TIP do QUIZ vísivel
func beVisibleTip(visible): 
	$Personagem/Camera/CanvasLayer/Popups/Popup6.visible = visible

#Torna o feedback do QUIZ vísivel
func beVisibleFeedback(visible): 
	$Personagem/Camera/CanvasLayer/Popups/Popup7.visible = visible

#Define o conteúdo da TIP do QUIZ
func setTipContent(content):
	$Personagem/Camera/CanvasLayer/Popups/Popup6/Label.text = content

#Define o conteúdo do Feedback do QUIZ
func setFeedbackContent(content):
	$Personagem/Camera/CanvasLayer/Popups/Popup7/Label.text = content

# Aparece para apertar M.
func MensagemPressM(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup3.visible = visible

# Aparece o Touch do M
func TouchPressM(visible):
	$Personagem/Camera/openMTouch.visible = visible

# Aparece o Touch do G
func TouchPressG(visible):
	$Personagem/Camera/openGTouch.visible = visible

# Aparece para apertar G.
func MensagemPressG(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup5.visible = visible

#Abre o PopUp de resposta com "Acertou" ou "Errou"
func messageFinal(text):
	$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = true
	$Personagem/Camera/CanvasLayer/Popups/Popup2/Label.text = text

#Passa o conteudo do Quiz para a tela do jogo
func setPopUpContent(question, an1, an2, an3):
	$Personagem/Camera/CanvasLayer/Popups/Popup/Label.text = question
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button2/Label.text = an1
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button3/Label.text = an2   
	$Personagem/Camera/CanvasLayer/Popups/Popup/Button4/Label.text = an3

#Seleciona uma questão aleatória dentro do banco de questões existentes
func selectQuestion():
	var lenght = float(len(perguntasFromDB)) - 1
	var NumberGenerator = RandomNumberGenerator.new()
	NumberGenerator.randomize()                              #Randomiza um número de 0 até o (lenght do array de perguntas)
	var randomNumber = NumberGenerator.randi_range(0, lenght)
	

	#Guarda um array contendo a pergunta selecionada
	var selectedQuestion = [perguntasFromDB[randomNumber].question, perguntasFromDB[randomNumber].an1, perguntasFromDB[randomNumber].an2, perguntasFromDB[randomNumber].an3, perguntasFromDB[randomNumber].anc, perguntasFromDB[randomNumber].tip, perguntasFromDB[randomNumber].feedback]
	randomNumberForDelete = randomNumber #Guarda o número que foi randomizado, para assim quando a pergunta for acertada, essa possa ser deletada


	return selectedQuestion #Return um array completo com a questão

#Verifica quantas vidas o player tem no DB, e reproduz isso na HUD
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
		
# Variaveis que quarda experiencia "Xp" e vidas do jogador
var player = { 
	'xp': 0,
	'vidas': 0,
	'mentalAlreadyCompleted': false,
}

#Colca os pontos na HUD do jogo.
func setPoints(points):
	$Personagem/Camera/Pontos.text = str(points) 

#Add uma quantidade específica de pontos do player
func addCoins(qnt): # Uma função que adiciona coinds "Dinheiro" para o personagem como forma de "Xp"
	var pontosAtual = int($Personagem/Camera/Pontos.text) #Pega os pontos atuais e tranforma em Número
	var pontosAdicionados = pontosAtual ++ qnt #Adiciona o incremento passado pelo parametro da função
	var pontosInString = str(pontosAdicionados) #Retorna a soma para o formato String
	$Personagem/Camera/Pontos.text = pontosInString #Substitui o valor dos pontos pelo valor adicionado
	$Personagem/Camera/moneyChange.text = str("+" + str(qnt)) #Define o valor do moneyChange
	$Personagem/Camera/moneyChange.text_color = Color.green #define a cor 
	$Personagem/Camera/moneyChange.visible = true #Torna o popup de moneychange vísivel
	yield(get_tree().create_timer(6.0), "timeout") #Aguarda 3 segundos
	$Personagem/Camera/moneyChange.visible = false #Torna o popup de moneychange invísivel

#Deleta uma quantidade específica de pontos do player
func deleteCoins(qnt):
	var pontosAtualRed = int($Personagem/Camera/Pontos.text) #Pega os pontos atuais e tranforma em Número
	var pontosAdicionadosRed = pontosAtualRed - qnt #Retira o incremento passado pelo parametro da função
	var pontosInStringRed = str(pontosAdicionadosRed) #Retorna o total para o formato String
	$Personagem/Camera/Pontos.text = pontosInStringRed #Substitui o valor dos pontos pelo valor retirado

#Faz a pergunta aparcer na tela do usuário
func defineQuestion():
	var lenghtArray = float(len(perguntasFromDB))
	if lenghtArray >= 1:
		liberadoAbrir = true #Libera a tecla M para funcionar
		if (player.isMobile == true):
			TouchPressM(true) #Torna o botão touch para abrir M vísivel
		else:
			MensagemPressM(true) #Torna o aviso de "Pressione M" visivel
		var content = selectQuestion() #Gera uma pergunta de forma aleatória
		setPopUpContent(content[0],content[1], content[2], content[3]) #Define o conteudo da pergunta
		anc = content[4] #Define qual a resposta correta
		setTipContent(content[5])
		setFeedbackContent(content[6])
	else:
		print('Acabou as perguntas!')
		player.mentalAlreadyCompleted = true
		save()
		$Personagem/Camera/CanvasLayer/Popups/Popup4.visible = true #Torna vísivel aviso de perguntas acabaram
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundo
		$Personagem/Camera/CanvasLayer/Popups/Popup4.visible = false #Torna invísivel aviso de perguntas acabaram
		
#Load quantos pontos o player possui atualmente
func getPoints():
	return int($Personagem/Camera/Pontos.text) #Retorna em forma de número quantos pontos o player possui

#Verifica se o mapa já foi concluido alguma vez
func alreadyCompleted():
	if (player.mentalAlreadyCompleted == false):
		$TileMap2.visible = true
	else:
		$TileMap2.visible = false

#Salva novas informações no arquivo .JSON
func save():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE)
	file.store_string(to_json(player))
	file.close()

#Carrega as informações que o arquivo .JSON possui
func loadInfos():
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
			save()
	else:
		printerr("Sem informações salvas!")
		save()

# Chamada assim que o jogo é iniciado
func _ready():
	loadInfos() #Carrega as infos
	qntVidas = player.vidas #Atualiza a qntDeVidas quando o jogo inicia
	setPoints(player.xp) #Atualiza os pontos quando o jogo inicia
	$Personagem.position = Global.positionForMapa1
	var checkQntPerguntas = loadPerguntas()
	savePerguntas()
	if checkQntPerguntas != null:
		if len(checkQntPerguntas) == 0:
			perguntasFromDB = Perguntas
			savePerguntas()
		else:
			pass
	else:
		savePerguntas()
		
func attQnt(valor1,valor2):
	$Personagem/Camera/contador.text = "Perguntas: " + String(valor1) + "/" + String(valor2)

#Roda em looping
func _process(delta):
	checkVidas() #Chama a função que verifica quantidade de vidas
	
	if (player.isMobile == false):
		$Personagem/Camera/Cima.visible = false
		$Personagem/Camera/Baixo.visible = false
		$Personagem/Camera/Esquerda.visible = false
		$Personagem/Camera/Direita.visible = false
	
	alreadyCompleted() #Verifica se o mapa já foi completado alguma vez ou não
	var cont = contador()

	var cauntMax = len(Perguntas)
	
	attQnt(cont,cauntMax)

	
	
	#Verifica se o pesonagem está dentro da AREA de Pergunta
	if liberadoAbrir:
		if Input.is_action_pressed('ui_m'):
			beVisibleTip(true) #Torna vísivel o quiz
			get_tree().paused = true
	#Verifica se o personagem está dentro de AREA de minigame
	if liberadoAbrirG:
		if Input.is_action_pressed("ui_g"):
			if(timeline == "Minigame1"):
				var dialogMinigame = Dialogic.start("Minigame1")
				add_child(dialogMinigame)
				qntVidas = 1
				player.vidas = 1
				save()
			elif (timeline == 'Minigame2'):
				var dialogMinigame2 = Dialogic.start("Minigame2")
				add_child(dialogMinigame2)
				qntVidas = 1
				player.vidas = 1
				save()
	if liberadoAbrirCientista:
		if Input.is_action_pressed("ui_g"):
			var dialogScientist = Dialogic.start("Cientista")
			add_child(dialogScientist)
	pass

#Quando o personagem entra no portal
func _on_Area2D3_body_entered(body):
	if body.name == "Personagem":
		get_tree().change_scene("res://jogoComPixelArt.tscn")
		Global.positionForMapa1 = Vector2(147,22)
	pass

#Verifica as questões e o que será mostrado
func checkQuestoes():
	var questionExist = verifyQuestions()
	if questionExist == true:
		pass
	else:
		player.mentalAlreadyCompleted = true
		save()
		$Personagem/Camera/CanvasLayer/Popups/Popup4.visible = true
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundo
		$Personagem/Camera/CanvasLayer/Popups/Popup4.visible = false
		

#Quando você entra dentro de uma área destinada a pergunta
func _perguntaEntered(body):
	if (body.name == 'Personagem'):
		if pergunta1Blocked == true:
			checkQuestoes()
		else:
			toBlock = 'Pergunta1'
			defineQuestion()
	else:
		pass

#Quando você sai dentro de uma área destinada a pergunta
func _perguntaExited(body):
	if body.name == "Personagem": 
		liberadoAbrir = false #Bloqueia a tecla M para funcionar
		MensagemPressM(false) #Torna o aviso de "Pressione M" invisivel
		TouchPressM(false)
	pass 
	

#Quando o botão A é selecionado no QUIZ
func _onFirstOptionSelected():
	if (anc == 1): #Resposta correta
		beVisible(false) #Torna o Quiz invisivel
		messageFinal('Acertou') #Define a mensagem de acerto ou erro
		addCoins(500) #Adiciona pontos
		perguntasFromDB.remove(randomNumberForDelete) #Deleto a pergunta que o player acertou
		savePerguntas() #Salva as perguntas após o remove
		blockQuestion()
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundo
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		get_tree().paused = false
		liberadoAbrir = false
		player.xp = getPoints() #Captura a quantidade atual de pontos
		save() #Salva no arquivo local
	else: #Resposta errada
		beVisible(false) #Torna o quiz invisivel
		liberadoAbrir = false
		messageFinal('Errou') #Define o conteudo da mensagem final
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false #Some a mensagem final
		beVisibleFeedback(true)

#Quando a opção B é selecionada
func _onSecondOptionSelected():
	if (anc == 2): #Resposta está correta
		beVisible(false) #Torna o Quiz invisivel
		messageFinal('Acertou') #Define a mensagem de acerto ou erro
		addCoins(500) #Adiciona pontos
		perguntasFromDB.remove(randomNumberForDelete) #Deleto a pergunta que o player acertou
		savePerguntas() #Salva as perguntas após o remove
		blockQuestion()
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundo
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		get_tree().paused = false
		liberadoAbrir = false
		player.xp = getPoints() #Captura a quantidade atual de pontos
		save() #Salva no arquivo local
	else: #Resposta errada
		beVisible(false) #Torna o quiz invisivel
		liberadoAbrir = false
		messageFinal('Errou') #Define o conteudo da mensagem final
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false #Some a mensagem final
		beVisibleFeedback(true)

#Quando a opção C é selecionada
func _onThirdOptionSelected():
#Resposta está correta:
	if (anc == 3):
		beVisible(false) #Torna o Quiz invisivel
		messageFinal('Acertou') #Define a mensagem de acerto ou erro
		addCoins(500) #Adiciona pontos
		perguntasFromDB.remove(randomNumberForDelete) #Deleto a pergunta que o player acertou
		savePerguntas() #Salva as perguntas após o remove
		blockQuestion()
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundo
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
		get_tree().paused = false
		liberadoAbrir = false
		player.xp = getPoints() #Captura a quantidade atual de pontos
		save() #Salva no arquivo local
	else: #Resposta errada
		beVisible(false) #Torna o quiz invisivel
		liberadoAbrir = false
		messageFinal('Errou') #Define o conteudo da mensagem final
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false #Some a mensagem final
		beVisibleFeedback(true)

#Quando o botão de fechar no QUIZ for selecionado
func _onClosePressed():
	beVisible(false) #Torna tudo referente as perguntas invisível
	get_tree().paused = false #Pausa o jogo

#Quando entra na área de MINIGAME
func _onMinigame1Entered(body):
	if (body.name == 'Personagem'):
		if (qntVidas < 5):
			$Personagem/Camera/CanvasLayer/Popups/Popup8.visible = true
			yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
			$Personagem/Camera/CanvasLayer/Popups/Popup8.visible = false
		else:
			liberadoAbrirG = true
			if (player.isMobile == true):
				TouchPressG(true)
			else:
				MensagemPressG(true)
			timeline = 'Minigame2'
			Global.positionForMapa1 = Vector2(337, 925)
			cenaDestination = "res://pong.tscn"
			pass

#Quando o dialogo referente ao minigame é finalizado
func dialogFinished():
	get_tree().change_scene(cenaDestination)

#Quando você sai da área de minigame
func _onMinigameExited(body):
	liberadoAbrirG = false
	liberadoAbrirCientista = false
	MensagemPressG(false)
	TouchPressG(false)
	timeline = ""
	pass

#Quando entra na área do segundo minigame
func _onMinigame2Entered(body):
	if (body.name == 'Personagem'):
		if (qntVidas < 5):
			$Personagem/Camera/CanvasLayer/Popups/Popup8.visible = true
			yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundos
			$Personagem/Camera/CanvasLayer/Popups/Popup8.visible = false
		else:
			liberadoAbrirG = true
			print(player)
			if (player.isMobile == true):
				TouchPressG(true)
			else:
				MensagemPressG(true)
			timeline = 'Minigame1'
			cenaDestination = "res://FlappyBrahma.tscn"
			Global.positionForMapa1 = Vector2(-30, 925)
			pass

#Quando o botão de seguir é pressionado no TIP do QUIZ
func _onButtonSeguirPressed():
	beVisibleTip(false)
	beVisible(true)
	pass

#Quando a resposta selecionado for incorreta
func _onErrouPressed():
	beVisibleFeedback(false)
	get_tree().paused = false
	pass

#Quando entra dentro da área de pergunta
func _pergunta2Entered(body):
	if (body.name == 'Personagem'):
		if pergunta2Blocked == true:
			checkQuestoes()
		else:
			toBlock = 'Pergunta2'
			defineQuestion()
	else:
		pass

#Quando entra dentro da área de pergunta
func _pergunta3Entered(body):
	if (body.name == 'Personagem'):
		if pergunta3Blocked == true:
			checkQuestoes()
		else:
			toBlock = 'Pergunta3'
			defineQuestion()
	else:
		pass

#Quando entra dentro da área de pergunta
func _pergunta4Entered(body):
	if (body.name == 'Personagem'):
		if pergunta4Blocked == true:
			checkQuestoes()
		else:
			toBlock = 'Pergunta4'
			defineQuestion()
	else:
		pass

#Quando entra dentro da área de pergunta
func _pergunta5Entered(body):
	if (body.name == 'Personagem'):
		if pergunta5Blocked == true:
			checkQuestoes()
		else:
			toBlock = 'Pergunta5'
			defineQuestion()
	else:
		pass

#Quando entra dentro da área de pergunta
func _pergunta6Entered(body):
	if (body.name == 'Personagem'):
		if pergunta6Blocked == true:
			checkQuestoes()
		else:
			toBlock = 'Pergunta6'
			defineQuestion()
	else:
		pass

#Quando entra dentro da área de pergunta
func _pergunta7Entered(body):
	if (body.name == 'Personagem'):
		if pergunta7Blocked == true:
			checkQuestoes()
		else:
			toBlock = 'Pergunta7'
			defineQuestion()
	else:
		pass

#Quando entra dentro da área de pergunta
func _pergunta8Entered(body):
	if (body.name == 'Personagem'):
		if pergunta8Blocked == true:
			checkQuestoes()
		else:
			toBlock = 'Pergunta8'
			defineQuestion()
	else:
		pass

#Quando entra dentro da área de pergunta
func _pergunta9Entered(body):
	if (body.name == 'Personagem'):
		if pergunta9Blocked == true:
			checkQuestoes()
		else:
			toBlock = 'Pergunta9'
			defineQuestion()
	else:
		pass

#Quando entra dentro da área de pergunta
func _pergunta10Entered(body):
	if (body.name == 'Personagem'):
		if pergunta10Blocked == true:
			checkQuestoes()
		else:
			toBlock = 'Pergunta10'
			defineQuestion()
	else:
		pass

#Quando o personagem entra na área do cientista 
func _onScientistEntered(body):
	if (body.name == 'Personagem'):
		MensagemPressG(true) #Aparece a mensagem de pressione G
		liberadoAbrirCientista = true #Libera que o dialógo seja aberto


func _pressedTouchG():
	Input.action_press("ui_g")


func _pressedTouchM():
	Input.action_press("ui_m")
