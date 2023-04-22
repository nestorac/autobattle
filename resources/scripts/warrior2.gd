extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var destination = Vector3(0,0,0)
var is_walking = false
var is_rotating = false


func set_destination(_destination: Vector3):
	destination = _destination


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	if is_rotating:
		# Poner un timer de 1s, y cuando termine...
		look_at(-destination, Vector3(0,1,0))
		is_rotating = false
		return
	if not is_walking:
		return
#	var destination_flat = -destination
	print ("Destination: ", destination) 
#	print ("Angle: ", rotation)
	rotation.x = 0
	rotation.z = 0
#	print ("Angle bis: ", rotation)
#	print ("Look at: ", -destination)
#	global_rotation.x = 0
#	global_rotation.z = 0
	# Add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
#	var input_dir = destination
#	var direction = (transform.basis * input_dir).normalized()
	var direction = transform.basis.z
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()



func stop():
	is_walking = false
