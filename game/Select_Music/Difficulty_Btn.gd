extends Area2D


signal difficulty_changed(new_difficulty)
var difficulty	# string

var diff_dict = {
	"easy": 0,
	"normal": 1,
	"hard": 2
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func set_to_difficulty(_difficulty):
	if _difficulty in ["easy", "normal", "hard"]:
		difficulty = _difficulty
		$AnimatedSprite.set_frame(diff_dict[difficulty])
	else:
		print("[CODE ERROR] difficulty setting error")
		

func _on_Button_pressed():
	print("difficulty set to " + difficulty)
	emit_signal("difficulty_changed", diff_dict[difficulty])
