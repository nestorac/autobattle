extends Camera3D

const RAY_LENGHT = 1000

@onready var warrior = $"../warrior"
var cube = preload("res://resources/scenes/stop_area.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_pressed("left_click"):
		var mouse_position = get_viewport().get_mouse_position()
		var ray_result = ray_from_mouse(mouse_position, 9)
		if (ray_result):
			if ray_result.collider.is_in_group("Floor"):
				warrior.is_walking = true
#				warrior.set_destination(ray_result["position"])
				place_cube(ray_result["position"])
				print ("ray_result: ", ray_result)

func ray_from_mouse (mouse_position, collision_mask):
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
	warrior.is_rotating = true
	warrior.timer.start(0.0)
