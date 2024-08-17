extends Node2D

func _physics_process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$Node2D/rod_hint.position.x += delta * 300
	elif Input.is_action_just_released("cast"):
		cast()
	

func cast():
	var tween = get_tree().create_tween()
	tween.tween_property($player/rod, "position", $player.to_local(%rod_hint.global_position), 0.6)
	%rod_hint.position.x = 0
	await tween.finished
	await get_tree().create_timer(1).timeout
	$player/rod.position = Vector2.ZERO
