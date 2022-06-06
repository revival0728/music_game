extends	KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var width = 1280
var height = 720
var velocity = Vector2()
var move = false

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass # Replace with function body.
	
func set_bePos(bPos, ePos, screen_size):
	set_position(Vector2(bPos[0]/16*screen_size.x, bPos[1]/9*screen_size.y))
	set_scale(
		Vector2(
			screen_size.x/width,
			screen_size.y/height
		)*0.6
	)
	velocity.x = (ePos[0] - bPos[0])/16*screen_size.x
	velocity.y = (ePos[1] - bPos[1])/9*screen_size.y
	
func move():
	move = true
	
func stop():
	move = false
	
func _physics_process(delta):
	if move:
		move_and_slide(velocity)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
