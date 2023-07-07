extends Control

@onready var label_green = $LabelGreen
@onready var label_red = $LabelRed

@onready var slider_green = $SliderGreen
@onready var slider_red = $SliderRed

@export var main_scene: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	label_green.text = "Number of green units: " + str(slider_green.value)
	label_red.text = "Number of red units: " + str(slider_red.value)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_slider_green_drag_ended(value_changed):
	label_green.text = "Number of green units: " + str(slider_green.value)


func _on_slider_red_drag_ended(value_changed):
	label_red.text =  "Number of red units: " + str(slider_red.value)


func _on_play_button_up():
	main_scene.spawn_warriors(slider_green.value, "GREEN")
	main_scene.spawn_warriors(slider_red.value, "RED")
	hide()
