extends Node


var Start_btn = load("res://Start_Btn.tscn")
var Start_bg = load("res://Start_Bg.tscn")
var screen_size

# Called when the node enters the scene tree for the first time.
func _ready():
	var start_btn = Start_btn.instance()
	var start_bg = Start_bg.instance()
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

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
