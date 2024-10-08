extends CanvasLayer

var fish = 0:
	set(value):
		fish = value
		update_fish_label()

var rain_cost = 1

func _ready() -> void:
	update_fish_label()
	get_parent().caught.connect(add_fish)

func add_fish():
	fish += 1

func _on_window_close_requested() -> void:
	$Window.hide()

func update_fish_label():
	$Control/MarginContainer/Fish.text = "Fish: " + str(fish)


func _on_rain_button_pressed() -> void:
	if fish < rain_cost:
		return

	fish -= rain_cost
	get_parent().rain *= 2
	rain_cost *= 2
	$Window/VBoxContainer/Rain/RainLabel.text = \
			"Rain: " + str(get_parent().rain)
	$Window/VBoxContainer/Rain/RainButton.text = \
			str(rain_cost) + " Fish / 1"

func _on_cast_button_pressed() -> void:
	if fish < 10:
		return

	if get_parent().cast_speed + 3.0 <= 90:
		fish -= 10
		get_parent().cast_speed += 3.0
		$Window/VBoxContainer/FasterCast/CastLabel.text = \
				"Faster Cast: " \
				+ str(get_parent().cast_speed) \
				+ "%"


func _on_bait_button_pressed() -> void:

	if fish < 30:
		return

	if get_parent().bait_quality + 4.0 <= 80:
		fish -= 30
		get_parent().bait_quality += 4.0
		$Window/VBoxContainer/BetterBait/BaitLabel.text = \
				"Better Bait: " \
				+ str(get_parent().bait_quality) \
				+ "%"

func _on_continuous_button_pressed() -> void:
	if %ContinuousButton.text == "Toggle":
		get_parent().continuous_fishing = !get_parent().continuous_fishing
		$Window/VBoxContainer/Continuous/ContinuousLabel.text = \
				"Continuous Fishing: " \
				+ str(get_parent().continuous_fishing)
	else:
		if fish < 100:
			return

		fish -= 100
		$Window/VBoxContainer/Continuous/ContinuousButton.text = "Toggle"


func _on_button_pressed() -> void:
	$Window.show()
