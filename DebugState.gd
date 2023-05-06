extends Label3D

@onready var warrior = $".."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if warrior._state == warrior.States.IDLE:
		text = "Idle"
	elif warrior._state == warrior.States.RUNNING:
		text = "Running"
	elif warrior._state == warrior.States.ROTATING:
		text = "Rotating"
	elif warrior._state == warrior.States.ATTACKING:
		text = "Attacking"
	else:
		print ("ERROR. Unknown state.")
