extends Node
signal obj_in_sight(enemy)
@onready var raygroup = $"../Node2D/Raygroup"
var rays = []
@onready var light = $"../Node2D/PointLight2D"
func _ready():
	light.energy = Global.initial_light_brightness
	rays = raygroup.get_children()
func _physics_process(delta):
	if Input.is_action_just_pressed("fire"):
		var v = light.energy
		light.energy = 16
		await get_tree().create_timer(0.3).timeout
		light.energy = v
		for i in rays:
			if i.is_colliding() && i.get_collider().is_in_group("enemy"):
				print("Gg")
				obj_in_sight.emit(i.get_collider())
				break

