extends Node2D

onready var sprite_texture = [preload("res://trovao3.png"),preload("res://trovao3.png"), preload("res://trovao3.png")
]

func _ready():
	$Timer.wait_time = rand_range(1, 8)
	$Timer.start()
	

func tempestade2():
#	$Sprite.texture = sprite_texture[randi() % 3 ]
	position.x = rand_range(-800, 800)
	position.y = rand_range(-800,800)
	
	$AnimationPlayer.play("Tempestade")
	$Timer.wait_time = rand_range(1, 8)
	$Timer.start()
	




func _on_Timer_timeout():
	tempestade2()
	
