extends CharacterBody3D

@export var life = 50

func damage(_damage):
	life -= _damage
	print ("damage!!!")
	if life <= 0:
		queue_free()
