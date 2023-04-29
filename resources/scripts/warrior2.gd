extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var destination = Vector3(0,0,0)
var is_walking = false
var is_rotating = false
@onready var timer = $Timer as Timer
@onready var anim = $AnimationPlayer as AnimationPlayer


func set_destination(_destination: Vector3):
	destination = _destination


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func movement():
	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	var direction = -transform.basis.z

	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0
		velocity.z = 0

	if not is_rotating:
		move_and_slide()


func _physics_process(delta):
#	print ("is_rotating: ", is_rotating)
	if is_rotating:
#		print ("Where we REALLY go: ", destination)
		# Poner un timer de 1s, y cuando termine...
		# Investigar. Producto punto de dos vectores paralelos.
		look_at(destination, Vector3(0,1,0))
	
	if not is_walking:
		anim.stop()
		return
	
	if is_walking:
		anim.play("Run")
#	
	var destination_flat = -destination
	# Add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta

	if not is_rotating:
		movement()



func stop():
	is_walking = false


func _on_timer_timeout():
	print ("timeout!")
	is_rotating = false
