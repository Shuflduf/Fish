extends CanvasLayer

var fish = 0

func _ready() -> void:
	get_parent().caught.connect(add_fish)
	
func add_fish():
	fish += 1
	$Control/Fish.text = "Fish: " + str(fish)
