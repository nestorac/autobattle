extends Camera3D

const RAY_LENGHT = 1000
const DISTANCE = -15

@export var mouse_click_activated = false
@export var following_player = true

@onready var warrior = $"../TheGoodOnes/warrior"
@onready var pivot = get_parent() as Node3D
@onready var cam_parent = get_parent().get_parent() as Node3D
var cube = preload("res://resources/scenes/stop_area.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if (event.is_action("Down")):
		pivot.global_position = pivot.global_position + Vector3(0,0,1)
	elif (event.is_action("Up")):
		pivot.global_position = pivot.global_position + Vector3(0,0,-1)
	if (event.is_action("Left")):
		pivot.global_position = pivot.global_position + Vector3(-1,0,0)
	elif (event.is_action("Right")):
		pivot.global_position = pivot.global_position + Vector3(1,0,0)
	if (event.is_action("Rotate_left")):
		pivot.rotation_degrees += Vector3(0,1,0)
	if (event.is_action("Rotate_right")):
		pivot.rotation_degrees -= Vector3(0,1,0)
	if (event.is_action("Zoom_in")):
		fov +=1
	if (event.is_action("Zoom_out")):
		fov -=1
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if following_player:
		look_at(warrior.global_position)
		global_position = warrior.global_position - Vector3(0, -12, DISTANCE)
	if Input.is_action_pressed("left_click") and mouse_click_activated:
		var mouse_position = get_viewport().get_mouse_position()
		var ray_result = ray_from_mouse(mouse_position)
		if (ray_result):
			if ray_result.collider.is_in_group("Floor"):
				warrior.is_walking = true
#				warrior.set_destination(ray_result["position"])
				place_cube(ray_result["position"])
#			elif ray_result.collider.is_in_group("Troops"):
#				warrior._state = warrior.States.ATTACKING
##				print ("ray_result: ", ray_result)

func ray_from_mouse (mouse_position):
	var ray_start = project_ray_origin(mouse_position)
	var ray_end = ray_start + project_ray_normal(mouse_position) * RAY_LENGHT
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	var collision = get_world_3d().direct_space_state.intersect_ray(query)
	return collision

func place_cube(place: Vector3):
	var children = get_children()
	for child in children:
		child.queue_free()
#	print ("Hijos: ", children)
	var cube_instance = cube.instantiate()
	add_child(cube_instance)
	cube_instance.global_position = place
	warrior.set_destination(place)
#	print ("Where we go: ", place)
#	print("Cube instance: ", cube_instance.global_position)
	warrior._state = warrior.States.ROTATING
	warrior.timer.start(0.0)
