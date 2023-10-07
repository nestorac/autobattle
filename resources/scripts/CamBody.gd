extends CharacterBody3D

const SPEED = 1
const MAX_SPEED = 50

func _physics_process(delta):

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("Left", "Right", "Up", "Down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = move_toward(velocity.x, direction.x * MAX_SPEED, SPEED)
		velocity.z = move_toward(velocity.z, direction.z * MAX_SPEED, SPEED)
#		velocity.x = direction.x * SPEED
#		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	print ("Velocity: ", velocity)
	
	move_and_slide()
