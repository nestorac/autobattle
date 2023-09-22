extends Node3D

@onready var level_node = get_tree().get_nodes_in_group("Level").front()
@onready var arrow_scene = load("res://resources/scenes/arrow.tscn")
@onready var arrow_position = $ArrowPos
@onready var character = $"../../../../.."

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func shoot_arrow():
	var arrow_instance = arrow_scene.instantiate()
	arrow_instance.team = character.team
	level_node.add_child(arrow_instance)
	arrow_instance.collision_shape.disabled = false
	arrow_instance.global_position = arrow_position.global_position
	arrow_instance.global_rotation = arrow_position.global_rotation
	arrow_instance.arrow_is_shot = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
