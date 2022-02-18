extends Area2D

func _on_wall_area_entered(area):
	if area.name == "Ball":
		#oops, ball went out of game place, reset
		get_parent().addCoins(1)
		#print('Foi')
		area.reset()
