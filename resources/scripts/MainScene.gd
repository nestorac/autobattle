extends Node3D

@onready var warrior = $warrior
@onready var floor = $floor

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func move_to(target_pos: Vector3) -> void:
	# Calculate the distance and direction to the target position
	var distance = target_pos.distance_to(global_position)
	var direction = (target_pos - global_position).normalized()
	# Define the speed at which the object should move
	var speed = 200.0
	# Define the time it should take to reach the target position
	var time = distance / speed
	# Use the Tween node to interpolate the object's position
#	var tween = Tween.new()
	warrior.position = global_transform.xform(target_pos)
#	add_child(tween)
#	tween.interpolate_property(self, "global_position", global_position, target_pos, time, Tween.TRANS_LINEAR)
#	tween.start()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			# Get the mouse position and convert it to global coordinates
#			var mouse_pos = get_global_mouse_position()
			var mouse_pos = get_viewport().get_mouse_position()
			# Call the move function with the mouse position as a parameter
			move_to(Vector3(mouse_pos.x, mouse_pos.y, 0))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Play"):
		# Call your function here
		warrior.play()
#		print ("key pressed")
