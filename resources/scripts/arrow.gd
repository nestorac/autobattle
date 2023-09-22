extends Area3D


@export var damage_min = 10.0
@export var damage_max = 15.0
@export var team = "GREEN"

@onready var collision_shape = $CollisionShape3D

var arrow_is_shot = false
var SPEED = 10

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if not arrow_is_shot:
		return
	position -= transform.basis.z * delta * SPEED


func _on_body_entered(body):
	if body.is_in_group("Troops"):
		print ("in group troops")
		if body.team == team:
			return
		if body.has_method("damage"):
			var enemy_defense = body.defense
			var damage = randi_range(damage_min, damage_max)
			var damage_reduction = abs( damage - enemy_defense )
			damage = damage - ( damage / damage_reduction )
			body.damage(damage)
			collision_shape.disabled = true
			hide()
			queue_free()


func _on_timer_timeout():
	queue_free()
