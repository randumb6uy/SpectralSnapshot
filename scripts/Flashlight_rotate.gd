extends Node
signal obj_in_sight(enemy)
var screen_anim
@onready var raygroup = $"../Node2D/Raygroup"
var rays = []
@onready var player_sprite = $"../playerSprite"
@onready var light = $"../Node2D/PointLight2D"
@onready var flash_eff = $"../Node2D/flash_eff"
func _ready():
	light.energy = Global.initial_light_brightness 
	rays = raygroup.get_children()
	print(rays)
	screen_anim = get_tree().get_first_node_in_group("screen_anim")
	print(screen_anim)
func _physics_process(delta):
	if Input.is_action_just_pressed("fire")&& Global.power > 0:
		var v = light.energy
		print("j")
		light.energy = 40
		Global.power -= Global.power_snap_consump
		screen_anim.play("snap")
		flash_eff.emitting = true
		await screen_anim.animation_finished
		light.energy = v
		for i in rays:
			if i.is_colliding() && i.get_collider().is_in_group("enemy"):
				obj_in_sight.emit(i.get_collider())
				break
	if Input.get_vector("LEFT","RIGHT","UP","DOWN").length() > 0 :
		player_sprite.play("walk")
	else:
		player_sprite.play("idle")
		
	
