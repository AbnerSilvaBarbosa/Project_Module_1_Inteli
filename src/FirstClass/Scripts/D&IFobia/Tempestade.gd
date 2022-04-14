extends Node2D

var spaw_position = null

var tempestade = preload("res://TesteTempestade.tscn")

var FILE_NAME = "user://infos.json"

var player = {
	'fobiaAlreadyPlayed': false
}

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
	else:
		printerr("Sem informações salvas!")

func _ready():
	loadInfos()
	randomize()
	spaw_position =  $SpawTempestade.get_children()
	
	pass # Replace with function body.

func spaw_tempestade():
	if (player.fobiaAlreadyCompleted == false):
		var index = randi() % spaw_position.size()
		var tempes = tempestade.instance()
		
		tempes.global_position = spaw_position[index].global_position
		add_child(tempes)
	else:
		pass
	
	



func _on_Timer_timeout():
	spaw_tempestade()
	pass # Replace with function body.
