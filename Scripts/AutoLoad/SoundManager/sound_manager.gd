extends AudioStreamPlayer
func play_sound(audio_stream : AudioStream):
	if (!playing):
		play();
	var playback : AudioStreamPlaybackPolyphonic = get_stream_playback();
	playback.play_stream(audio_stream);
	pass;
