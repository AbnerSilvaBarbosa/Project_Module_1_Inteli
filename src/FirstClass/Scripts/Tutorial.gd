extends Node2D
var a = true


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Movimentação")
	$AnimatedSprite.position.x = 580
	pass # Replace with function body.

func _process(delta):
	if(a == true):
		$Personagem/AnimationPlayer.play("correndo_para_esquerda")
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_started(anim_name):
	$Personagem/AnimationPlayer.play("correndo_para_esquerda")
	
	
	pass # Replace with function body.


func _on_AnimationPlayer_animation_finished(anim_name):
	a = false
	pass # Replace with function body.


func _on_AnimaoTutorial_body_entered(body):
	if(body.name == "Personagem"):
		$AnimationPlayer2.play("finaltutorial")
	pass # Replace with function body.


func _on_AnimationPlayer2_animation_finished(anim_name):
	get_tree().change_scene("res://jogoComPixelArt.tscn")
	pass # Replace with function body.
