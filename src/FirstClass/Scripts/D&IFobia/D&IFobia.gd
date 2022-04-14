extends Node2D

var spritePersonagem = preload("res://teste1.png")
var spritePersonagemCompleted = preload("res://Action RPG Resources/Player/Pixilart Sprite Sheet.png")
var qntVidas = 0 
var FILE_NAME = "user://infos.json"
var FILE_PERGUNTAS = "user://PerguntasFase2.JSON"
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
	{'question': 'Sabendo-se disso, o que define a homofobia?', 'an1': 'Ódio à comunidade transsexual.', 'an2': 'Aversão a qualquer tipo de orientação sexual.', 'an3': 'Preconceito contra pessoas de orientação homossexual.', 'anc': 3, "tip": "A homofobia no Brasil ainda é um problema presente e constante, afetando diretamente uma parcela da comunidade LGBTQIA+.", "feedback": "A homofobia é um tipo de preconceito que atinge diretamente pessoas de orientação homossexual."},
	{'question': 'Por que o Dia Internacional Contra a Homofobia é celebrado dia 17 de maio?', 'an1': 'Porque esse foi o dia, em 1990, em que a ONU retirou a homossexualidade da classificação de doenças e problemas relacionados à saúde.', 'an2': 'Porque esse dia ficou conhecido como o dia em que o casamento entre casais homossexuais deixou de ser ilegal no Brasil.', 'an3': 'Porque foi nesse dia, em 1969, que ocorreu a Revolução de Stonewall, evento que marcou uma das maiores manifestações da comunidade gay contra a repressão.', 'anc': 1, "tip": "Sabendo-se que a homofobia ainda é um problema muito persistente no cenário global, existem ações que visam ao combate desse tipo de preconceito.", "feedback": "O dia em que a ONU retirou a homossexualidade da classificação de doenças e problemas relacionados a saúde marca o Dia Internacional Contra a Homofobia. Essa conquista da comunidade homossexual se deu no dia 17 de maio de 1990."},
	{'question': 'Qual seria uma alternativa viável para minimizar a violência contra a população LGBTQIA+?', 'an1': 'Conscientizar a população LGBTQIA+ para se prevenir de possíveis episódios de violência, orientando-as a esconder sua orientação sexual e identidade de gênero.', 'an2': 'A adoção de sistemas que permitam o registro, no boletim de ocorrência, dos casos de violência que tiveram como motivação a LGBTfobia.', 'an3': 'A criação de núcleos de apoio aos indivíduos da comunidade LGBTQIA + que os acolham depois que tenham sofrido violência.', 'anc': 2, "tip": "A pauta LGBTQIA+ vem ganhando espaço em amplas discussões em parâmetros globais. No entanto, embora alguns direitos de fundamental importância tenham sido conquistados pela comunidade, eles ainda são constantemente desrespeitados.", "feedback": "A adoção de sistemas que permitam classificar a violência sofrida como LGBTfobia em boletins de ocorrência é o primeiro passo para aprimorar as estatísticas já existentes acerca da problemática. Assim, a iniciativa se faz necessária para que a LGBTfobia possa ser mapeada de maneira mais eficiente e possibilitar, consequentemente, a estruturação de políticas públicas capazes de prevenir esse tipo de violência."},
	{'question': 'Por que a sigla LGBT sofreu alteração e ganhou mais três letras e um sinal, tornando-se LGBTQIA+?', 'an1': 'Por conta da alteração no código penal brasileiro que obrigou a adição na sigla.', 'an2': 'Para deslegitimar aqueles que foram incluídos, tornando a sigla uma espécie de chacota.', 'an3': 'Para se tornar mais inclusiva, aderindo a todas as diversidades relacionadas à pauta em questão.', 'anc': 3, "tip": "A sigla LGBTQIA+ sofreu algumas alterações desde que foi criada, em 1994.", "feedback": "Essa alteração se deve à adesão, pela sigla, de todas as diversidades relacionadas a essa pauta. O símbolo de “mais” no final da sigla aparece para incluir outras identidades de gênero e orientações sexuais que não se encaixam no padrão cis-heteronormativo, mas que não aparecem em destaque antes do símbolo."},
	{'question': 'Qual seria uma das maiores dificuldades enfrentadas pela comunidade LGBTQIA+ atualmente?', 'an1': 'Acesso às vagas de trabalho, dificultado por requisitos incompatíveis com a realidade social de muitos integrantes da comunidade, até a falta de acolhimento e inclusão nos ambientes corporativos.', 'an2': 'Acesso a eventos culturais, haja vista a proibição da permanência de pessoas LGBTQIA+ nesse tipo de ambiente.', 'an3': 'Acesso ao ambiente escolar, visto que processos seletivos de instituições acadêmicas costumam ser mais difíceis para o público em questão.', 'anc': 1, "tip": "É fato que a população LGBTQIA+, nos mais diversos espaços da sociedade, não recebe o acolhimento que deveria. Essa parcela da sociedade tem, por vezes, suas demandas ignoradas e, consequentemente, permanecem sob um constante cenário de vulnerabilidade.", "feedback": "Uma das maiores dificuldades enfrentadas pela comunidade LGBTQIA+ atualmente se refere ao acesso ao ambiente corporativo, bem como a falta de acolhimento e inclusão nesse tipo de espaço."},
	{'question': 'Essa porcentagem representa uma estimativa de 20 milhões de pessoas. Entretanto, esse número pode, na realidade, ser muito superior. Por quê?', 'an1': 'Porque há muito tempo não é realizado um censo demográfico que considere os dados relativos à população LGBTQIA+.', 'an2': 'Porque muitas pessoas que fazem parte da comunidade optam por não declarar sua identidade de gênero ou orientação sexual, normalmente para evitar preconceito.', 'an3': 'Porque a maioria dos cidadãos englobados pela sigla, em um estado de negação de sua identidade, prefere não se declarar LGBTQIA+.', 'anc': 2, "tip": "Atualmente, aproximadamente 10% de toda a população brasileira se declara parte da comunidade LGBTQIA+.", "feedback": "Buscando evitar o preconceito e discriminação, uma significativa parcela da população LGBTQIA+ omite sua identidade de gênero ou orientação sexual. Desse modo, os dados demográficos obtidos acerca desse grupo minoritário nem sempre são fiéis à realidade."},
	{'question': 'Gênero é igual a orientação sexual?', 'an1': 'Sim, o gênero de uma pessoa é o principal determinante de sua orientação sexual.', 'an2': 'Não,  o gênero é uma representação da identidade do indivíduo, enquanto sua orientação sexual é definida como a atração de uma pessoa em relação à outra.', 'an3': 'Depende. Alguns estudiosos sobre o assunto consideram que gênero seja igual à orientação sexual. Outros, por outro lado, não consideram.', 'anc': 2, "tip": "Baseando-se nos seus conhecimentos sobre gênero, responda à seguinte questão:", "feedback": "Gênero não é igual à orientação sexual! Fique atento para não confundir: o gênero é uma representação da identidade do indivíduo, enquanto sua orientação sexual é definida como a atração de uma pessoa em relação à outra."},
	{'question': 'Em qual definição melhor se encaixa o termo “gênero”?', 'an1': 'Gênero diz respeito aos comportamentos, forma de vestir, forma de apresentação, aspecto físico, gostos e atitudes de um indivíduo.', 'an2': 'Gênero é o conceito que define a diferenciação biológica entre homens e mulheres.', 'an3': 'Gênero diz respeito a como um indivíduo expressa sua orientação sexual perante a sociedade.', 'anc': 1, "tip": "Baseando-se nos seus conhecimentos sobre gênero, responda à seguinte questão:", "feedback": "Diferentemente do que muitos pensam, o conceito de gênero não leva em consideração a diferenciação biológica entre homens e mulheres. O gênero, na realidade, diz respeito aos comportamentos, forma de vestir, forma de apresentação, aspecto físico, gostos e atitudes de um indivíduo."},
	{'question': 'O que é orientação sexual?', 'an1': 'Trata-se de como o indivíduo expressa seu gênero perante a sociedade.', 'an2': 'Trata-se do estilo de vida que a população LGBTQIA+ decide viver.', 'an3': 'Trata-se da atração física e afetiva que um indivíduo sente por outros indivíduos de determinado(s) gênero(s).', 'anc': 3, "tip": "Um dos fatores contemplados pela pauta LGBTQIA+ é a orientação sexual.", "feedback": "A orientação sexual de um indivíduo se refere à atração de um indivíduo por determinados ou por nenhum gênero. A orientação sexual não é determinada pelo gênero ou pelo estilo de vida que uma pessoa decide viver."},
	{'question': 'Quem foi um dos grandes cientistas gays da história contemporânea?', 'an1': 'Alan Turing', 'an2': 'Albert Einstein', 'an3': 'Richard Feynman', 'anc': 1, "tip": "Por muito tempo, cidadãos homossexuais tiveram suas contribuições à sociedade descredibilizadas. Felizmente, esse cenário está mudando, mas não podemos nos esquecer daqueles que, no passado, precisaram lutar por reconhecimento.", "feedback": "Um dos grandes cientistas gays da história contemporânea foi Alan Turing. É considerado o pai da computação."},
]

# Variaveis que quarda experiencia "Xp" e vidas do jogador
var player = { 
	'xp': 0,
	'vidas': 0,
	'fobiaAlreadyCompleted': false,
	'alreadyPlayedFobia': false,
}

var perguntasFromDB = []

var anc = 1 #Resposta correta
var liberadoAbrir = false #Libera a abertura do QUIZ
var liberadoAbrirG = false #Libera a abertura do Minigame
var liberadoAbrirCientista = false #Libera a abertura do Cientista

var justOneTime = Perguntas

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
		player.fobiaAlreadyCompleted = true
		save()
		$Personagem/Camera/CanvasLayer/Popups/Popup4.visible = true #Torna vísivel aviso de perguntas acabaram
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundo
		$Personagem/Camera/CanvasLayer/Popups/Popup4.visible = false #Torna invísivel aviso de perguntas acabaram
		
#Load quantos pontos o player possui atualmente
func getPoints():
	return int($Personagem/Camera/Pontos.text) #Retorna em forma de número quantos pontos o player possui

#Verifica se o mapa já foi concluido alguma vez
func alreadyCompleted():
	if (player.fobiaAlreadyCompleted == false):
		$TileMap3.visible = false
		$TileMap4.visible = false
		#Preto e Branco
		$Sprite.visible = true
		$Sprite2.visible = true
		$Sprite3.visible = true
		$Sprite4.visible = true
		$Sprite5.visible = true
		$Sprite6.visible = true
		$Sprite7.visible = true
		$Sprite8.visible = true
		$Sprite9.visible = true
		$Sprite10.visible = true
	else:
		$TileMap3.visible = true
		$TileMap4.visible = true
		$Personagem/Sprite.texture = spritePersonagemCompleted
		$Personagem/Particles2D.emitting = false
		$Personagem/Light2D.enabled = false
		#Colorido
		$Pixil3.visible = true
		$Pixil4.visible = true
		$Pixil5.visible = true
		$Pixil6.visible = true
		$Pixil7.visible = true
		$Pixil8.visible = true
		$Pixil9.visible = true
		$Pixil10.visible = true
		$Pixil11.visible = true
		$Pixil12.visible = true

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
	
	if (player.alreadyPlayedFobia == false):
		$AnimationPlayer.play("Nova Animação")
	
	$Personagem/Sprite.texture = spritePersonagem

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
		
	
	if (player.fobiaAlreadyCompleted == true) and (player.mentalAlreadyCompleted == true) and (player.alreadyFinalScene == false):
		get_tree().change_scene("res://CenaFinal.tscn")
	
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
#			if(timeline == "Minigame1"):
#				var dialogMinigame = Dialogic.start("Minigame1")
#				add_child(dialogMinigame)
#			elif (timeline == 'Minigame2'):
#				var dialogMinigame2 = Dialogic.start("Minigame2")
#				add_child(dialogMinigame2)
#			elif (timeline == 'Minigame3'):
#				var dialogMinigame2 = Dialogic.start("Minigame3")
#				add_child(dialogMinigame2)
#			elif (timeline == 'Minigame4'):
#				var dialogMinigame2 = Dialogic.start("Minigame4")
#				add_child(dialogMinigame2)
			get_tree().change_scene(cenaDestination)
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
		$Personagem/Camera/CanvasLayer/Popups/Popup4.visible = true
		yield(get_tree().create_timer(3.0), "timeout") #Aguarda 3 segundo
		$Personagem/Camera/CanvasLayer/Popups/Popup4.visible = false
		player.fobiaAlreadyCompleted = true
		save()

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
		player.vidas += 1
		qntVidas += 1
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
		player.vidas += 1
		qntVidas += 1
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
		player.vidas += 1
		qntVidas += 1
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
		liberadoAbrirG = true
		if (player.isMobile == true):
			TouchPressG(true)
		else:
			MensagemPressG(true)
		timeline = 'Minigame3'
		Global.positionForMapa2 = Vector2(713, -223)
		cenaDestination = "res://Labirinto.tscn"
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
		liberadoAbrirG = true
		print(player)
		if (player.isMobile == true):
			TouchPressG(true)
		else:
			MensagemPressG(true)
		timeline = 'Minigame4'
		cenaDestination = "res://Pacman/Game.tscn"
		Global.positionForMapa1 = Vector2(730, -212)
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


func _on_Area2D_body_entered(body):
	if body.name == "Personagem":
		get_tree().change_scene("res://jogoComPixelArt.tscn")
		Global.positionForMapa2 = Vector2(30,-51)
	pass # Replace with function body.


func _areaAlreadyPlayed(body):
	if(body.name == 'Personagem'):
		player.alreadyPlayedFobia = true
		save()


func _on_Button_pressed():
	$Personagem/Camera/AudioStreamPlayer2D.stream_paused = true
	$Personagem/Button.visible = false
	$Personagem/Button2.visible = true
	pass # Replace with function body.


func _on_Button2_pressed():
	$Personagem/Camera/AudioStreamPlayer2D.stream_paused = false
	$Personagem/Button.visible = true
	$Personagem/Button2.visible = false
	pass # Replace with function body.
