extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play():
	var animation_player = $AnimationPlayer
	animation_player.play("Armature001|mixamocom|Layer0")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
