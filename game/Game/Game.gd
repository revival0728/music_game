extends Node


var Buttons = {
	"press": load("res://Game/Press.tscn"),
}
var levelName = ''
var game = null
var screen_size


func readChart():
	var json = File.new()
	levelName = 'TestLevel'
	json.open("res://test/TestLevel.json", File.READ)
	json = JSON.parse(json.get_as_text())
	game = json.result
	print('In readChar(): ' + str(json.error))

	var music = load('res://test/{musicSource}'.format(game))
	$AudioStreamPlayer.stream = music

func wait(second):
	yield(get_tree().create_timer(second), "timeout")

func syncMC(playerSetDelay):	# sync music and chart
	var timeDelay = AudioServer.get_time_to_next_mix() + AudioServer.get_output_latency() + playerSetDelay
	$AudioStreamPlayer.play()
	yield(wait(timeDelay), "completed")
	$Timer.start(float(game['length']))
	for i in range(game['length']):
		print('Timer left: ' + str($Timer.get_time_left()))
		print('AudioStreamPlayer left:' + str($AudioStreamPlayer.get_playback_position()))
		var btns = []
		for btn_info in game["chart"][i]:
			var btn = Buttons[btn_info.type].instance()
			btns.append(btn)
			add_child(btns.back())
			btns.back().set_bePos(btn_info.bPos, btn_info.ePos, screen_size)
			btns.back().move()
		yield(wait(1.0), "completed")
		for btn in btns:
			btn.stop()
			# btn.queue_free()
	print('Timer left: ' + str($Timer.get_time_left()))
	print('AudioStreamPlayer left:' + str($AudioStreamPlayer.get_playback_position()))
	$AudioStreamPlayer.stop()


# Called when the node enters th2e scene tree for the first time.
func _ready():
	screen_size = get_viewport().get_visible_rect().size
	readChart()
	syncMC(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
