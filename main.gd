extends Node2D

var fishing = false

signal caught

# in percent, where 100% is instant and 0% is normal
var cast_speed = 0.0
var bait_quality = 0.0
var rain = 1

var continuous_fishing = false:
	set(value):
		continuous_fishing = value
		%rod_hint.visible = !value

func _ready() -> void:
	randomize()


func _physics_process(delta: float) -> void:
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		if continuous_fishing:
			%rod_hint.position.x = randi_range(0, 800)
			cast()
		else:
			%rod_hint.position.x += delta * 300
			%rod_hint.position.x = clamp(%rod_hint.position.x, 0, 800)
		
	elif Input.is_action_just_released("cast"):
		cast()
	

func cast():
	if fishing:
		%rod_hint.position.x = 0
		return
	fishing = true
	
	var pre_cast_speed = lerp(0.6, 0.0, cast_speed / 100.0)
	await launch_into(%rod, %rod_hint.global_position, 0, pre_cast_speed)
	
	%rod_hint.position.x = 0
	var wait_time = lerp(randf_range(4, 8), 0.3, bait_quality / 100.0)
	await get_tree().create_timer(wait_time).timeout
	
	
	for i in floori(rain / 2.0):
		var new_fish = $fish.duplicate()
		$Fish.add_child(new_fish)
		new_fish.show()
		new_fish.global_position = %rod.global_position
		launch_into(new_fish, $player/basket.global_position, \
				300 + randf_range(-50, 80), \
				0.6 + randf_range(-0.2, 0.2), true)
		await get_tree().create_timer(1 / (rain * ((cast_speed + 5) / 10.0))).timeout
		caught.emit()
	
	
	$player/rod.position = Vector2.ZERO
	fishing = false

func launch_into(object: Node2D, target: Vector2, offset := 0.0, speed = 0.6, delete_on_finish = false):
	var ver_tween = get_tree().create_tween()\
			.set_trans(Tween.TRANS_SINE)
	ver_tween.tween_property(object, "position:y", \
			(-object.get_parent()\
			.to_local(target).y) - offset, speed / 2.0) \
			.set_ease(Tween.EASE_OUT)
	
	ver_tween.tween_property(object, "position:y", \
			object.get_parent()\
			.to_local(target).y, speed / 2.0) \
			.set_ease(Tween.EASE_IN)
		
	var hor_tween = get_tree().create_tween()\
			.set_trans(Tween.TRANS_SINE)
	hor_tween.tween_property(object, "position:x", \
			object.get_parent()\
			.to_local(target).x, speed)
	await hor_tween.finished
	if delete_on_finish:
		object.queue_free()
	return
