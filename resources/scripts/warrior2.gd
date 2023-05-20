extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var destination = Vector3(0,0,0)
var is_walking = false
@onready var timer = $Timer as Timer
@onready var anim = $AnimationPlayer as AnimationPlayer

enum States {IDLE, RUNNING, ROTATING, ATTACKING}

var _state : int = States.IDLE

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

	move_and_slide()


func _physics_process(delta):
	match _state:
		States.IDLE:
			pass
		States.RUNNING:
			anim.play("Run")
			movement()
		States.ROTATING:
			look_at(destination, Vector3(0,1,0))
		States.ATTACKING:
			print ("attttack!!!")

	
	if not is_walking:
		anim.stop()
		_state = States.IDLE
		return
#	
	var destination_flat = -destination
	# Add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta



func stop():
	is_walking = false


func _on_timer_timeout():
	print ("timeout!")
	_state = States.RUNNING
