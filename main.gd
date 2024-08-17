extends Node2D

func _ready() -> void:
	cast()


func cast():
	var tween = get_tree().create_tween()
	tween.tween_property($player/rod, "position", Vector2(500, 150), 0.6)
	tween.finished.connect(func(): 
		$player/rod.position = Vector2.ZERO)
