extends Node
signal on_transition_finished

@onready var colorRect = $"../../ColorRect2"
@onready var animation_player = $"../../AnimationPlayer"
var light  
var player

func _ready():
	animation_player.animation_finished.connect(_on_animation_finished)
	#animation_player.play("fade_to_normal_long")
func transition():
	print("jjkgl")
	animation_player.play("fade_to_black")


func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		animation_player.play("fade_to_norm")
		on_transition_finished.emit()
