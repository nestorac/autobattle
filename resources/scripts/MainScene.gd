extends Node3D

@onready var warrior = $warrior

var mouse_pressed = false

@export var the_good_ones: Node3D

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
#		var global_basis = global_transform.basis
#		movement = global_basis.xform(movement)

		# Move the object's position based on the movement vector
		position += movement


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("Play"):
		# Call your function here
		warrior.play()
#		print ("key pressed")

func spawn_warriors(qty_of_warriors, team):
	var warrior = load("res://warrior.tscn")
	
	var pos = Vector3(0,0,0)
	
	if team == "GREEN":
		pos = Vector3(-50,0.1,80)
	else:
		pos = Vector3(-50,0.1,-80)
	
	for i in qty_of_warriors:
		var instance_warrior = warrior.instantiate()
		instance_warrior.team = team
		the_good_ones.add_child(instance_warrior)
		instance_warrior.transform.origin = pos
		instance_warrior.is_walking = true
		if team == "GREEN":
			var material = instance_warrior.body_mesh.get("surface_material_override/0")
			material.albedo_color = Color.DARK_GREEN
			instance_warrior.set_destination(Vector3(instance_warrior.global_position.x,0,-98))
			instance_warrior.body_mesh.set("surface_material_override/0", material)
		else:
			var material2 = instance_warrior.body_mesh.get("surface_material_override/0")
			material2.albedo_color = Color.DARK_RED
			instance_warrior.set_destination(Vector3(instance_warrior.global_position.x,0,98))
			instance_warrior.body_mesh.set("surface_material_override/0", material2)
		pos = pos + Vector3(10,0,0)
		instance_warrior._state = instance_warrior.States.ROTATING
		instance_warrior.timer.start(0.0)

#	for i in the_good_ones.get_children():
#		print (Vector3(i.global_position.x, i.global_position.y, i.global_position.z - 100))
