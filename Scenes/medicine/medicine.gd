extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const DRINK : AudioStream= preload("uid://dulcfcpveuvd7")

func _on_pengzhuang_body_entered(body: Node2D) -> void:
	if (body.is_in_group(&"Player")):
		animation_player.play("pick_medicine");
		SoundManager.play_sound(DRINK);
		GameManager.JUMP_VELOCITY = -700;
		await animation_player.animation_finished;
		queue_free();
