extends Node2D
const _1 = preload("uid://c5wd28uee3fbo")
@onready var back_sound_stream_player: AudioStreamPlayer = $BackSoundStreamPlayer

func _ready() -> void:
	back_sound_stream_player.stream = _1
	# 先拿到stream，再设置循环模式
	back_sound_stream_player.stream.loop = true
	# 启动播放
	back_sound_stream_player.play()
