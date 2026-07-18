extends Node2D
const COIN_SOUND : AudioStream= preload("uid://cw8vyg7vk4g6b")
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_pickable_range_body_entered(body: Node2D) -> void:
	if (body.is_in_group(&"Player")):
		#检测body(即玩家)是否在特定的组(这里指金币的碰撞箱)内 用&"字符串"声明StringName类型 这个类型的变量的值不能改变
		#右边player必须全部场景都要勾选 要不然直接用 add_to_group("Player"); 放在ready里也行 否则拾取会出问题
		SoundManager.play_sound(COIN_SOUND);
		animation_player.play("OnPick");
		await animation_player.animation_finished;
		#等待animation_finished 这个信号的传出 表示动画结束 最后删除
		GameManager.score += 1;
		queue_free();#删除自身
