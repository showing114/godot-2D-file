extends Node2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const DRINK = preload("uid://dulcfcpveuvd7")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.is_in_group(&"Player")):
		animation_player.play("pick_medicine2");
		SoundManager.play_sound(DRINK);
		GameManager.SPEED = 450;
		await animation_player.animation_finished;
		queue_free();
