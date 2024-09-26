extends Area2D
@onready var flash = $flash


func _on_body_entered(body):
	if body.is_in_group("player"):
		print("charge")
		Global.power += Global.candle_inc
		flash.emitting
		queue_free()
	else:
		print("overlapping")
		queue_free()
