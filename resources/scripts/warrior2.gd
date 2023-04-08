extends CharacterBody3D

const SPEED = 5.0

@export var destination = Vector3(0,0,0)


func set_destination(_destination: Vector3):
	destination = _destination


func _physics_process(delta):
	pass
#	print("destination: ", destination) 
#	var input_dir = destination
#	var direction = (transform.basis * Vector3(input_dir.x, input_dir.y, 0)).normalized()
#
#	if destination.x == direction.y and destination.y == direction.y:
#		return
#
#	if direction:
#		velocity.x = direction.x * SPEED
#		velocity.y = direction.y * SPEED
##		velocity.z = direction.z * SPEED
#	else:
#		velocity.x = move_toward(velocity.x, 0, SPEED)
#		velocity.y = move_toward(velocity.y, 0, SPEED)
##		velocity.z = move_toward(velocity.z, 0, SPEED)
#
#	move_and_slide()
