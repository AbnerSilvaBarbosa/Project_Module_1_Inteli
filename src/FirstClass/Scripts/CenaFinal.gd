extends Node2D

var FILE_NAME = 'user://infos.json'

var player = {
	'alreadyFinalScene': true
}

func save():
	var file = File.new()
	file.open(FILE_NAME, File.WRITE) #Acessa o arquivo local para escrita
	file.store_string(to_json(player)) #Guarda a var Player em formato JSON dentro do arquivo local
	file.close()

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
	player.alreadyFinalScene = true
	save()


func _on_AnimationPlayer_animation_finished(anim_name):
	get_tree().change_scene("res://Creditos.tscn")
	pass # Replace with function body.
