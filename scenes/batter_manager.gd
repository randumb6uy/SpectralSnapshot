extends Node
@onready var canvas_modulate = $"../CanvasModulate"
@onready var screen_anim = $"../screen_anim"

var light
@onready var battery = $"../CanvasLayer2/Battery"
@onready var animation_player = $"../CanvasLayer2/battery_blink"
signal no_light
@onready var timer = $"../Timer"
func _ready():
	timer.start()
	light = get_tree().get_first_node_in_group("light")
	Global.power = Global.max_power
func _process(delta):
	var light_status
	if 80 > Global.power and Global.power>= 60: 
		battery.value = 100
		light_status = Global.battery_setup[0]
		set_light(light_status)
	elif 60 > Global.power and Global.power >= 40:
		battery.value = 65
		light_status = Global.battery_setup[1]
		set_light(light_status)
	elif  40 > Global.power and Global.power >= 20:
		battery.value = 45
		light_status = Global.battery_setup[2]
		set_light(light_status)
	elif 20 > Global.power and Global.power > 0  :
		battery.value = 30
		light_status = Global.battery_setup[3]
		set_light(light_status)
		animation_player.play("blink")
	elif Global.power <= 0 :
		print("no light")
		light.energy = 0
		battery.value = 0
		no_light.emit()
		canvas_modulate.color = Color(0,0,0)
	
func _on_timer_timeout():
	#timer.start()
	if Global.power > 0:
		Global.power -= Global.power_consumtion
		print(Global.power)
	else:
		
		print(Global.power)
	timer.start()

func set_light(setup):
	if randi_range(0,setup[1]) <= 1:
		light.energy = randf_range(0,setup[0])
	else:
		light.energy = 5
