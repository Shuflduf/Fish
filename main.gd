extends Node2D

var fishing = false

signal caught

# in percent, where 0% is instant and 100% is normal
var cast_speed = 100.0

func _physics_process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		%rod_hint.position.x += delta * 300
		%rod_hint.position.x = clamp(%rod_hint.position.x, 0, 800)
		
	elif Input.is_action_just_released("cast"):
		cast()
	

func cast():
	if fishing:
		%rod_hint.position.x = 0
		return
	fishing = true
	
	var pre_cast_speed = 0.6 * (cast_speed / 100.0)
	await launch_into(%rod, %rod_hint.global_position, 0, pre_cast_speed)
	
	%rod_hint.position.x = 0
	await get_tree().create_timer(randf_range(1, 5)).timeout
	var new_fish = $fish.duplicate()
	add_child(new_fish)
	new_fish.show()
	new_fish.global_position = %rod.global_position
	launch_into(new_fish, $player/basket.global_position, 300)
	caught.emit()
	$player/rod.position = Vector2.ZERO
	fishing = false

func launch_into(object: Node2D, target: Vector2, offset := 0.0, speed = 0.6):
	var ver_tween = get_tree().create_tween()\
			.set_trans(Tween.TRANS_SINE)
	ver_tween.tween_property(object, "position:y", \
			(-object.get_parent()\
			.to_local(target).y) - offset, 0.3) \
			.set_ease(Tween.EASE_OUT)
	
	ver_tween.tween_property(object, "position:y", \
			object.get_parent()\
			.to_local(target).y, 0.3) \
			.set_ease(Tween.EASE_IN)
		
	var hor_tween = get_tree().create_tween()\
			.set_trans(Tween.TRANS_SINE)
	hor_tween.tween_property(object, "position:x", \
			object.get_parent()\
			.to_local(target).x, 0.6)
	await hor_tween.finished
	return
