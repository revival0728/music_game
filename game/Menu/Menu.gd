extends Node


var Start_Btn
var Start_Bg
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	Start_Btn = load("res://Menu/Start_Btn.tscn")
	Start_Bg = load("res://Menu/Start_Bg.tscn")
	
	var start_btn = Start_Btn.instance()
	var start_bg = Start_Bg.instance()
	screen_size = get_viewport().get_visible_rect().size
	start_btn.set_position(Vector2(screen_size.x/2, screen_size.y*(1.0*188/720)*3.2))
	start_bg.set_position(Vector2(screen_size.x/2, screen_size.y/2))
	start_bg.set_scale(
		Vector2(
			screen_size.x/start_bg.origin_with,
			screen_size.y/start_bg.origin_height
		)
	)
	start_btn.connect("start_btn_active", self, "_on_start_btn_active")
	add_child(start_bg)
	add_child(start_btn)

func _on_start_btn_active():
	print('start_btn_active')
