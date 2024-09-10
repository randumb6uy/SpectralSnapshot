extends Area2D


func _on_area_entered(area):
	Global.power += Global.candle_inc
	queue_free()
