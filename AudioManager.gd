extends Node


func play_sound(stream: AudioStream, bus_name: String, random_amount: float = 0.0):
	var audio = AudioStreamPlayer2D.new() as AudioStreamPlayer2D
	audio.stream = stream
	audio.bus = bus_name
	audio.pitch_scale = randf_range(1.0-random_amount, 1.0+random_amount)
	
	audio.finished.connect(audio.queue_free)
	audio.process_mode = Node.PROCESS_MODE_ALWAYS
	
	add_child(audio)
	audio.play()


func stop_sound(stream: AudioStream):
	for a in get_children():
		if a.stream == stream:
			a.queue_free()
