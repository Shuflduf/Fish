extends CanvasLayer

var fish = 0

func _ready() -> void:
	get_parent().caught.connect(add_fish)
	
func add_fish():
	fish += 1
	$Control/Fish.text = "Fish: " + str(fish)


func _on_button_pressed() -> void:
	if get_parent().cast_speed - 5 > 0:
		
		$Window/VBoxContainer/FasterCast/Label.text = \
				"Faster Cast: " \
				+ str((1.0 / get_parent().cast_speed) * 1000).pad_decimals(2) \
				+ "%"
		get_parent().cast_speed -= 5.0


func _on_window_close_requested() -> void:
	$Window.hide()
