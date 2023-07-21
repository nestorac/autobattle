extends CharacterBody3D

const SPEED = 0.5
const JUMP_VELOCITY = 4.5

var destination = Vector3(0,0,0)
#var move_to = Vector3(0,0,0)
var is_walking = false
var moved = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var timer = $Timer as Timer
@onready var anim = $AnimationPlayer as AnimationPlayer

@onready var body_mesh = $Armature/Skeleton3D/BodyMesh
@onready var damage_label = $DamageLabel

@export var team = "GREEN"
@export var life = 50

enum States {IDLE, RUNNING, ROTATING, ATTACKING}

var _state : int = States.IDLE

func set_destination(_destination: Vector3):
	destination = _destination

func _ready():
	pass


func movement():
	# Handle Jump.
#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	if not moved:
		var direction = destination
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = 0
		velocity.z = 0

	move_and_slide()


func _physics_process(delta):
	print ("destination: " + str(destination))
	match _state:
		States.IDLE:
			pass
		States.RUNNING:
			anim.play("Run")
			movement()
		States.ROTATING:
			look_at(destination, Vector3(0,1,0))
		States.ATTACKING:
			anim.play("Attack")

	
	if not is_walking:
		anim.stop()
		_state = States.IDLE
		return

#	var destination_flat = -destination
	# Add gravity
	if not is_on_floor():
		velocity.y -= gravity * delta



func stop():
	is_walking = false


func damage(_damage):
	life -= _damage
	print ("damage!!!")
	damage_label.play_animation(_damage)
	if life <= 0:
		queue_free()


func _on_timer_timeout():
	print ("timeout!")
	_state = States.RUNNING


func _on_vision_area_body_entered(body):
	if body.is_in_group("Troops"):
		if body.team == team:
			return
		print ("Entrando...")
		set_destination(body.global_transform.origin)
		_state = States.ROTATING
		timer.start(0.0)
#		move_and_slide()


func _on_attack_area_body_entered(body):
	if body.is_in_group("Troops"):
		if body.team == team:
			return
		_state = States.ATTACKING
