extends Node


var levelName = ''
var game = null


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
		yield(wait(1.0), "completed")
	print('Timer left: ' + str($Timer.get_time_left()))
	print('AudioStreamPlayer left:' + str($AudioStreamPlayer.get_playback_position()))
	$AudioStreamPlayer.stop()


# Called when the node enters the scene tree for the first time.
func _ready():
	readChart()
	syncMC(0)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
