extends Camera3D

const RAY_LENGTH = 1000
const DISTANCE = -15

const MINIMUM_SPEED = 1.0
const MAXIMUM_SPEED = 2.0

var speed = 1.0
var is_moving = false
var timer_factor = 0

@export var mouse_click_activated = false
@export var following_player = true

@onready var pivot = get_parent() as Node3D
@onready var cam_parent = get_parent().get_parent() as Node3D

var cube = preload("res://resources/scenes/stop_area.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if (event.is_action("Rotate_left")):
		pivot.rotation_degrees += Vector3(0,1,0)
	if (event.is_action("Rotate_right")):
		pivot.rotation_degrees -= Vector3(0,1,0)
	if (event.is_action("Zoom_in")):
		size *= 1.1
	if (event.is_action("Zoom_out")):
		size *= 0.9
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func ray_from_mouse (mouse_position):
	var ray_start = project_ray_origin(mouse_position)
	var ray_end = ray_start + project_ray_normal(mouse_position) * RAY_LENGTH
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	var collision = get_world_3d().direct_space_state.intersect_ray(query)
	return collision

#func place_cube(place: Vector3):
#	var children = get_children()
#	for child in children:
#		child.queue_free()
##	print ("Hijos: ", children)
#	var cube_instance = cube.instantiate()
#	add_child(cube_instance)
#	cube_instance.global_position = place
##	warrior.set_movement_target(place)
##	print ("Where we go: ", place)
##	print("Cube instance: ", cube_instance.global_position)
##	warrior._state = warrior.States.ROTATINGDown
##	warrior.timer.start(0.0)


#func _on_timer_timeout():
#	speed = MAXIMUM_SPEED
