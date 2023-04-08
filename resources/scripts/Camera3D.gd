extends Camera3D

const RAY_LENGHT = 1000

@onready var warrior = $"../warrior"

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
				print ("Mouse position: ", ray_result["position"])
				warrior.destination = ray_result["position"]
#				warrior.set_destination(ray_result["position"])


func ray_from_mouse (mouse_position, collision_mask):
	var ray_start = project_ray_origin(mouse_position)
	var ray_end = ray_start + project_ray_normal(mouse_position) * RAY_LENGHT
	var space_state = get_world_3d().direct_space_state
	var query = PhysicsRayQueryParameters3D.create(ray_start, ray_end)
	var collision = get_world_3d().direct_space_state.intersect_ray(query)
	return collision
