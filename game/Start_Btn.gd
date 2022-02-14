extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

signal start_btn_active


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Button_pressed():
	print('button pressed')
	emit_signal("start_btn_active")
