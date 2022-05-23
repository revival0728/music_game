extends Node

signal change_side

var Difficulty_Btn
var Bg_Node
var Select_Bg
var screen_size
var now_difficulty	# integer
var now_bg_node_side
var difficulty_btns = []
var bg_node_list = []
var game_info
var Comfirm_Btn


func read_info():
	var json = File.new()
	json.open("res://song_template/options.json", File.READ)
	var game_info = JSON.parse(json.get_as_text())
	print(game_info)

# Called when the node enters the scene tree for the first time.
func _ready():
	read_info()
	
	Difficulty_Btn = load("res://Select_Music/Difficulty_Btn.tscn")
	Bg_Node = load("res://Select_Music/Bg_Node.tscn")
	Select_Bg = load("res://Select_Music/Select_Bg.tscn")
	Comfirm_Btn = load("res://Select_Music/Comfirm_Btn.tscn")
	
	screen_size = get_viewport().get_visible_rect().size
	
	var select_bg = Select_Bg.instance()
	select_bg.set_scale(
		Vector2(
			screen_size.x/select_bg.origin_width,
			screen_size.y/select_bg.origin_height
		)
	)
	select_bg.set_position(screen_size/2)
	add_child(select_bg)
		
	var diff_btns_pos = {
		"easy": Vector2(0.85, 0.3),
		"normal": Vector2(0.85, 0.5),
		"hard": Vector2(0.85, 0.7),
	}
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
	
	var bg_node_pos = [
		Vector2(0.165, 0.25),
		Vector2(0.2, 0.5),
		Vector2(0.165, 0.75)
	]
	now_bg_node_side = 0
	for i in range(3):
		var bg_node = Bg_Node.instance()
		if i%2 == 0:
			bg_node.get_node("Button").connect("pressed", self, "_on_bg_node_clicked")
		self.connect("change_side", bg_node, "_on_change_side")
		bg_node.set_position(
			Vector2(
				screen_size.x*bg_node_pos[i].x,
				screen_size.y*bg_node_pos[i].y
			)
		)
		bg_node.set_scale(
			Vector2(
				(screen_size.x/bg_node.origin_width)/5,
				(screen_size.y/bg_node.origin_height)/3
			)
		)
		bg_node.set_frame(i%2)
		bg_node_list.append(bg_node)
	for i in bg_node_list:
		add_child(i)
	
func _on_difficulty_changed(new_difficulty):
	now_difficulty = new_difficulty
	print("[In Select_Music] now difficulty: " + str(now_difficulty))
	
func _on_bg_node_clicked():
	for i in range(3):
		if i%2 == 1:
			continue
		if now_bg_node_side == 0:
			bg_node_list[i].position.x += 0.07*screen_size.x
		else:
			bg_node_list[i].position.x -= 0.07*screen_size.x
	now_bg_node_side ^= 1
	emit_signal("change_side")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
