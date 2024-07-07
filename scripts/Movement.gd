extends Node

@onready var player = $".."
@onready var flash = $"../Node2D"
@onready var light = $"../Node2D/PointLight2D"

func _physics_process(delta):
	var dir = Input.get_vector("LEFT","RIGHT","UP","DOWN")
	player.velocity = dir * Global.player_speed
	player.move_and_slide()
	flash.look_at(player.get_global_mouse_position())
	
