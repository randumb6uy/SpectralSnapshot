extends CharacterBody2D
@onready var timer = $Timer
var target = null
var e_ready = false
var speed = Global.enemy_speed
var acc = 10
var p_target = position
@onready var navigation_agent = $NavigationAgent2D
@onready var detect = $Area2D/CollisionShape2D
var manager
@onready var wander_ray = $Node
var player
func _ready():
	await get_tree().create_timer(0.5).timeout
	e_ready = true
	
	
func _physics_process(delta):
	var dir = Vector2.ZERO
	var wander_target = 2 *  Vector2(randf_range(-64 , 64) , randf_range(-64 , 64))
	
	dir = navigation_agent.get_next_path_position() - global_position
	dir = dir.normalized()
	velocity = velocity.lerp(dir * speed , acc * delta * 0.5)
	move_and_slide()
	p_target = wander_target 

func _on_area_2d_3_body_entered(body):
	manager = get_tree().get_first_node_in_group("manager")
	print("maja",manager.enem_no)
	if !e_ready && manager.enem_no >= 4:
		print("nig")
		print(body)
		
		
		
func _on_timer_timeout():
	player = get_tree().get_first_node_in_group("player")
	if target != null:
		navigation_agent.target_position = target.global_position +  Vector2(randf_range(-64 , 64) , randf_range(-64 , 64))
		p_target = position
	else:
		navigation_agent.target_position = 3 * Vector2(randf_range(-64 , 64) , randf_range(-64 , 64)) + position

func _on_area_2d_body_entered(body):
	if body.is_in_group("player") :
		target = body
		timer.wait_time = 0.5 
func _on_area_2d_2_body_exited(body):
	target = null
	timer.wait_time = 1 + randf_range(0,3)




		
