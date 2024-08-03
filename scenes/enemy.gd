extends CharacterBody2D

var target = null

var speed = Global.enemy_speed
var acc = 5
var p_target = position
@onready var navigation_agent = $NavigationAgent2D
@onready var detect = $Area2D/CollisionShape2D



func _physics_process(delta):
	var dir = Vector2.ZERO
	dir = navigation_agent.get_next_path_position() - global_position
	dir = dir.normalized()
	velocity = velocity.lerp(dir * speed , acc * delta * 0.5)
	move_and_slide()
	p_target = position

func _on_timer_timeout():
	if target != null:
		navigation_agent.target_position = target.global_position
		p_target = position
	else:
		navigation_agent.target_position = p_target

func _on_area_2d_body_entered(body):
	print(Global.is_sneaking)
	if body.is_in_group("player") :
		target = body
		
func _on_area_2d_2_body_exited(body):
	target = null


