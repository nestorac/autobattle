extends Node3D

class_name MeleeWeapon

@export var damage_min = 10.0
@export var damage_max = 15.0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body.is_in_group("Troops"):
		if body.has_method("damage"):
			var enemy_defense = body.defense
			var strength = $"../../../..".strength
			var damage_reduction = abs( strength - enemy_defense )
			var damage = randi_range(damage_min, damage_max)
			damage = damage - ( damage / damage_reduction )
			body.damage(damage)
