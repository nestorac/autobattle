extends CharacterBody3D

@onready var damage_label = $DamageLabel

@export var life = 50

func damage(_damage):
	life -= _damage
	print ("damage!!!")
	damage_label.play_animation(_damage)
	if life <= 0:
		queue_free()
