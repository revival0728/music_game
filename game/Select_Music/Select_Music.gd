extends Node


var Difficulty_Btn
var Bg_Node
var screen_size
var now_difficulty	# integer


# Called when the node enters the scene tree for the first time.
func _ready():
	Difficulty_Btn = load("res://Select_Music/Difficulty_Btn.tscn")
	Bg_Node = load("res://Select_Music/Bg_Node.tscn")
	
	var difficulty_btns = []
	var diff_btns_pos = {
		"easy": Vector2(0.5, 0.4),
		"normal": Vector2(0.5, 0.6),
		"hard": Vector2(0.5, 0.8),
	}
	screen_size = get_viewport().get_visible_rect().size
	for diff in ["easy", "normal", "hard"]:
		var difficulty_btn = Difficulty_Btn.instance()
		difficulty_btn.set_position(
			Vector2(
				screen_size.x*diff_btns_pos[diff].x,
				screen_size.y*diff_btns_pos[diff].y
			)
		)
		difficulty_btn.set_to_difficulty(diff)
		difficulty_btn.connect("difficulty_changed", self, "_on_difficulty_changed")
		difficulty_btns.append(difficulty_btn)
	for i in difficulty_btns:
		add_child(i)
	
func _on_difficulty_changed(new_difficulty):
	now_difficulty = new_difficulty
	print("[In Select_Music] now difficulty: " + str(now_difficulty))
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
