extends Node2D

func _physics_process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		$Node2D/rod_hint.position.x += delta * 300
	elif Input.is_action_just_released("cast"):
		cast()
	

func cast():
	var ver_tween = get_tree().create_tween()\
			.set_trans(Tween.TRANS_SINE)
	ver_tween.tween_property($player/rod, "position:y", \
			-$player.to_local(%rod_hint.global_position).y, 0.3) \
			.set_ease(Tween.EASE_OUT)
	
	ver_tween.tween_property($player/rod, "position:y", \
			$player.to_local(%rod_hint.global_position).y, 0.3) \
			.set_ease(Tween.EASE_IN)
		
	var hor_tween = get_tree().create_tween()\
			.set_trans(Tween.TRANS_SINE)
	hor_tween.tween_property($player/rod, "position:x", \
			$player.to_local(%rod_hint.global_position).x, 0.6)
	
	
	%rod_hint.position.x = 0
	await hor_tween.finished
	await get_tree().create_timer(randf_range(1, 10)).timeout
	$player/rod.position = Vector2.ZERO
