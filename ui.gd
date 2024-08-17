extends CanvasLayer

var fish = 0

func _ready() -> void:
	get_parent().caught.connect(add_fish)
	
func add_fish():
	fish += 1
	$Control/Fish.text = "Fish: " + str(fish)

func _on_window_close_requested() -> void:
	$Window.hide()


func _on_cast_button_pressed() -> void:
	if get_parent().cast_speed + 3.0 <= 90:
		get_parent().cast_speed += 3.0
		$Window/VBoxContainer/FasterCast/Label.text = \
				"Faster Cast: " \
				+ str(get_parent().cast_speed) \
				+ "%"


func _on_bait_button_pressed() -> void:
	if get_parent().bait_quality <= 80:
		get_parent().bait_quality += 4.0
		$Window/VBoxContainer/FasterCast/Label.text = \
				"Better Bait: " \
				+ str(get_parent().bait_quality) \
				+ "%"
