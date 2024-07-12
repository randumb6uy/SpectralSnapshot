extends CanvasLayer
signal on_transition_finished

@onready var colorRect= $ColorRect2
@onready var animation_player = $AnimationPlayer

func _ready():
	colorRect.visible = false
	animation_player.animation_finished.connect(_on_animation_finished)

func transition():
	colorRect.visible = true
	animation_player.play("fade_to_black")

func _on_animation_finished(anim_name):
	if anim_name == "fade_to_black":
		on_transition_finished.emit()
		animation_player.play("fade_to_norm")
	elif anim_name == "fade_to_norm":
		colorRect.visible = false
