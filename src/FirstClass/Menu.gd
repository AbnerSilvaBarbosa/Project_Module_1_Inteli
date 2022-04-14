extends Node2D

var FILE_NAME = "user://infos.json" #--Arquivo Local

func goToGame():
		get_tree().change_scene("res://Tutorial.tscn") #Altera a cena para a principal
func quitGame(): 
		get_tree().quit() #Faz o quit do jogo.
func goToCredit():
	get_tree().change_scene("res://Creditos.tscn")
		
var player = { #Local database
	'xp': 0,
	'vidas': 0,
	'mercadoAlreadyOpen': false,
	'alreadyPlayed': false,
	'isMobile': false
} 		

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

# Called when the node enters the scene tree for the first time.
func _ready():
	loadInfos()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func iniciarPressed():
	goToGame()#Chama a função acima.
	pass


func sairDoJogo():
	quitGame()#Chama a função acima.
	pass


func _optionsClicked():
	$Popup.visible = true

func _onCloseClicked():
	$Popup.visible = false

func _onComputerPressed():
	player.isMobile = false
	save()
	$Popup.visible = false
	
func _onMobileClicked():
	player.isMobile = true
	save()
	$Popup.visible = false


func _Creditos():
	goToCredit()
	pass # Replace with function body.
