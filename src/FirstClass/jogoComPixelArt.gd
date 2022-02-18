extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var isVisible = true
var anc = 0
var levelPassed = false
var liberadoAbrir = false

func beVisible(visible): 
	$Personagem/Camera/CanvasLayer/Popups/Popup.visible = visible  #Abre o PopUp do quiz
	
func MensagemPressM(visible):
	$Personagem/Camera/CanvasLayer/Popups/Popup3.visible = visible # Aparece para apertar M.
	
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
	var pontosAdicionadosRed = pontosAtualRed ++ qnt #Retira o incremento passado pelo parametro da função
	var pontosInStringRed = str(pontosAdicionadosRed) #Retorna o total para o formato String
	$Personagem/Camera/Pontos.text = pontosInStringRed #Substitui o valor dos pontos pelo valor retirado

# Called when the node enters the scene tree for the first time.
#func _ready(): 
#	pass# Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if liberadoAbrir:
		if Input.is_action_pressed('ui_m'):
			beVisible(true)
			get_tree().paused = true
	#		if (levelPassed == true):
	#			$Collisions/mecanicaTeste.disabled = true
	#		else:
	#			$Collisions/mecanicaTeste.disabled = false
	else:
		pass

func _on_Button_pressed_close():
	beVisible(false)
	get_tree().paused = false
	
func _on_Button2_pressed():
	if (anc == 1):
		beVisible(false)
		get_tree().paused = false
		messageFinal('Acertou')
		addCoins(100)
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
	else:
		beVisible(false)
		get_tree().paused = false
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false

func _on_Button3_pressed():
	if (anc == 2):
		beVisible(false)
		get_tree().paused = false
		messageFinal('Acertou')
		addCoins(100)
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
	else:
		beVisible(false)
		get_tree().paused = false
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false

func _on_Button4_pressed():
	if (anc == 3):
		beVisible(false)
		get_tree().paused = false
		messageFinal('Acertou')
		addCoins(100)
		yield(get_tree().create_timer(3.0), "timeout")
		$Personagem/Camera/CanvasLayer/Popups/Popup2.visible = false
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

func _on_Area2D_body_entered(body):
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


func _on_Area2D_body_exited(body):
	if body.name == "Personagem": # Aparece somente com a colisao DO PERSONAGEM
		liberadoAbrir = false
		MensagemPressM(false)
	pass # Replace with function body.

func _on_Area2D2_body_entered(body):
	if body.name == 'Personagem':
		get_tree().change_scene("res://pong.tscn")
	pass # Replace with function body.


func _pergunta2Enter(body):
	if body.name == 'Personagem':
		liberadoAbrir = true
		MensagemPressM(true)
		setPopUpContent('Essa é a pergunta 2', 'Resposta 1', 'Resposta2', 'Resposta3')
		anc = 3
	else:
		get_tree().paused = false
	pass # Replace with function body.


func _exitedPergunta2(body):
	if body.name == 'Personagem':
		liberadoAbrir = false
		MensagemPressM(false)
	pass # Replace with function body.
