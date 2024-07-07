extends Node
var obj_in_sight
@onready var raygroup = $"../Node2D/Raygroup"
var rays = []
@onready var light = $"../Node2D/PointLight2D"
func _ready():
	light.energy = Global.initial_light_brightness
	rays = raygroup.get_children()
func _physics_process(delta):
	if Input.is_action_just_pressed("fire"):
		print("Dds")
		var v = light.energy
		light.energy = 16
		await get_tree().create_timer(0.3).timeout
		light.energy = v
		for i in rays:
			if i.is_colliding():
				


