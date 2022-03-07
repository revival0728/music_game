extends Area2D

var origin_width = 1280
var origin_height = 720


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func _on_change_side():
	var now_frame = $AnimatedSprite.get_frame()
	$AnimatedSprite.set_frame(now_frame^1)

func set_frame(frame_id):
	$AnimatedSprite.set_frame(frame_id)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
