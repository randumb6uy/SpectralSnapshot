extends Area2D


signal leaving_level


func _on_body_entered(body):
	print("gey")
	leaving_level.emit()
