extends Node3D

@onready var warrior = $warrior

var mouse_pressed = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


#func move_to(target_pos: Vector3) -> void:
#	# Calculate the distance and direction to the target position
#	var distance = target_pos.distance_to(global_position)
#	var direction = (target_pos - global_position).normalized()
#	# Define the speed at which the object should move
#	var speed = 200.0
#	# Define the time it should take to reach the target position
#	var time = distance / speed
#	# Use the Tween node to interpolate the object's position
##	var tween = Tween.new()
##	warrior.transform = global_transform.xform(Transform3D(target_pos))
##	add_child(tween)
##	tween.interpolate_property(self, "global_position", global_position, target_pos, time, Tween.TRANS_LINEAR)
##	tween.start()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		# Check if the left mouse button is pressed or released
		if event.button_index == MOUSE_BUTTON_LEFT:
			mouse_pressed = event.pressed

	elif event is InputEventMouseMotion and mouse_pressed:
		# Calculate the movement vector based on the mouse motion
		var movement = Vector3(event.relative.x, -event.relative.y, 0) * 0.1

		# Rotate the movement vector based on the camera orientation
		var global_basis = global_transform.basis
		movement = global_basis.xform(movement)

		# Move the object's position based on the movement vector
		position += movement


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Play"):
		# Call your function here
		warrior.play()
#		print ("key pressed")
