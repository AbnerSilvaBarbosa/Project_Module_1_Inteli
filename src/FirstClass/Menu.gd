extends Node2D

func goToGame():
		get_tree().change_scene("res://jogoComPixelArt.tscn") #Altera a cena para a principal
func quitGame(): 
		get_tree().quit() #Faz o quit do jogo.
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func iniciarPressed():
	goToGame()#Chama a função acima.
	pass


func sairDoJogo():
	quitGame()#Chama a função acima.
	pass
