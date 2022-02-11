extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


var isVisible = true
var anc = 0

func beVisible(visible): 
	$Popup.visible = visible
	
func messageFinal(text):
	$Popup2.visible = true
	
	$Popup2/Label.text = text
	
func setPopUpContent(question, an1, an2, an3):
	$Popup/Label.text = question
	$Popup/Button2/Label.text = an1
	$Popup/Button3/Label.text = an2
	$Popup/Button4/Label.text = an3

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("ui_m"):
		beVisible(true)
		setPopUpContent('Testeeeeeeeeeee', 'Answer1', 'Answer2', 'Answer3')
		anc = 2
#	pass


func _on_Button_pressed_close():
	beVisible(false)
	pass 
	
func _on_Button2_pressed():
	if (anc == 1):
		beVisible(false)
		messageFinal('Acertou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Popup2.visible = false
	else:
		beVisible(false)
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Popup2.visible = false
	pass
# Replace with function body.


func _on_Button3_pressed():
	if (anc == 2):
		beVisible(false)
		messageFinal('Acertou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Popup2.visible = false
	else:
		beVisible(false)
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Popup2.visible = false
	pass # Replace with function body.


func _on_Button4_pressed():
	if (anc == 3):
		beVisible(false)
		messageFinal('Acertou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Popup2.visible = false
	else:
		beVisible(false)
		messageFinal('Errou')
		yield(get_tree().create_timer(3.0), "timeout")
		$Popup2.visible = false
	pass # Replace with function body.
