extends CharacterBody3D

class_name Unit

#const SPEED = 0.5
const JUMP_VELOCITY = 4.5

# STATS
@export var team = "GREEN"

@export var life = 50.0
@export var speed = 10.0
@export var strength = 10.0
@export var attack_range = 1.0
@export var defense = 20.0
@export var price = 10.0

var destination = Vector3(0,0,0)
#var move_to = Vector3(0,0,0)
var is_walking = false
var moved = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var timer = $Timer as Timer
@export var anim: AnimationPlayer

@onready var body_mesh = $Armature/Skeleton3D/BodyMesh
@onready var damage_label = $DamageLabel

# NAVIGATION
var movement_speed: float = 2.0
var movement_target_position: Vector3 = Vector3(-3.0,0.0,2.0)

@onready var navigation_agent: NavigationAgent3D = $NavigationAgent3D

# END NAVIGATION

enum States {IDLE, RUNNING, ROTATING, ATTACKING}

var _state : int = States.IDLE

#func set_destination(_destination: Vector3):
#	destination = _destination

func set_movement_target(movement_target: Vector3):
	navigation_agent.set_target_position(movement_target)


func _ready():
	pass


func movement():
	if navigation_agent.is_navigation_finished():
		return

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = navigation_agent.get_next_path_position()

	var new_velocity: Vector3 = next_path_position - current_agent_position
	new_velocity = new_velocity.normalized()
	new_velocity = new_velocity * movement_speed

	velocity = new_velocity
	move_and_slide()


func _physics_process(delta):
#	print ("destination: " + str(destination))
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
	life -= ( _damage )
	print ("damage!!!")
	damage_label.play_animation(_damage)
	if life <= 0.0:
		queue_free()


func _on_timer_timeout():
	print ("timeout!")
	_state = States.RUNNING


func _on_vision_area_body_entered(body):
	if body.is_in_group("Troops"):
		if body.team == team:
			return
		print ("Entrando...")
		set_movement_target(body.global_transform.origin)
		_state = States.ROTATING
		timer.start(0.0)
#		move_and_slide()


func _on_attack_area_body_entered(body):
	if body.is_in_group("Troops"):
		if body.team == team:
			return
		_state = States.ATTACKING
