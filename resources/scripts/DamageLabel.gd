extends Label3D

@onready var animation = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func play_animation(damage):
	text = str(damage)
	animation.play("damaged")
